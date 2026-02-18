#!/usr/bin/env python3
"""TDSL resource archive tool compatible with the VB6 client format.

Format inferred from CLIENTE TDS LEGACY/CODIGO/modCompression.bas:
- FILEHEADER: Long lngFileSize, Integer intNumFiles
- INFOHEADER: Long lngFileStart, Long lngFileSize, String * 16 strFileName, Long lngFileSizeUncompressed
- Stored data: zlib-compressed bytes where first byte is XORed with 166
"""

from __future__ import annotations

import argparse
import hashlib
import struct
import sys
import zlib
from dataclasses import dataclass
from pathlib import Path
from typing import Iterable, List

FILEHEADER_STRUCT = struct.Struct("<lh")
INFOHEADER_STRUCT = struct.Struct("<ll16sl")
XOR_KEY = 166
MAX_ARCHIVE_NAME = 16


@dataclass(frozen=True)
class InfoHeader:
    file_start: int
    compressed_size: int
    file_name_raw: bytes
    uncompressed_size: int

    @property
    def file_name(self) -> str:
        return self.file_name_raw.decode("cp1252", errors="strict").rstrip(" ")


@dataclass(frozen=True)
class ArchiveEntry:
    name: str
    data: bytes


def _detect_extension_by_magic(data: bytes) -> str | None:
    if data.startswith(b"\x89PNG\r\n\x1a\n"):
        return ".png"
    if data.startswith(b"BM"):
        return ".bmp"
    return None


def _build_output_path(base_dir: Path, archive_name: str, data: bytes, auto_fix_ext: bool) -> Path:
    output_name = archive_name
    if auto_fix_ext:
        guessed_ext = _detect_extension_by_magic(data)
        if guessed_ext:
            current_ext = Path(archive_name).suffix.lower()
            if current_ext != guessed_ext:
                output_name = f"{Path(archive_name).stem}{guessed_ext}"

    candidate = base_dir / output_name
    if not candidate.exists():
        return candidate

    if output_name.lower() == archive_name.lower():
        # Same final name as original file entry, allow overwrite semantics.
        return candidate

    original_ext = Path(archive_name).suffix.lower().lstrip(".") or "bin"
    fallback_name = f"{Path(output_name).stem}__from_{original_ext}{Path(output_name).suffix}"
    fallback = base_dir / fallback_name
    if not fallback.exists():
        return fallback

    index = 2
    while True:
        numbered = (
            base_dir
            / f"{Path(output_name).stem}__from_{original_ext}_{index}{Path(output_name).suffix}"
        )
        if not numbered.exists():
            return numbered
        index += 1


def _normalize_bmp_payload(data: bytes) -> bytes:
    if len(data) < 6 or not data.startswith(b"BM"):
        return data

    declared_size = struct.unpack("<I", data[2:6])[0]
    if declared_size <= 0:
        return data

    if len(data) == declared_size:
        return data

    if len(data) < declared_size:
        return data + bytes(declared_size - len(data))

    return data[:declared_size]


def _normalize_archive_name(name: str) -> str:
    normalized = name.replace("\\", "/").split("/")[-1].strip().lower()
    encoded = normalized.encode("cp1252", errors="strict")
    if len(encoded) > MAX_ARCHIVE_NAME:
        raise ValueError(
            f"El archivo '{name}' supera {MAX_ARCHIVE_NAME} bytes en CP1252 y no entra en INFOHEADER.strFileName."
        )
    return normalized


def _name_to_fixed_bytes(name: str) -> bytes:
    raw = name.encode("cp1252", errors="strict")
    return raw.ljust(MAX_ARCHIVE_NAME, b" ")


def _decompress_data(data: bytes, original_size: int) -> bytes:
    if not data:
        if original_size > 0:
            return bytes(original_size)
        return b""
    mutable = bytearray(data)
    mutable[0] ^= XOR_KEY
    output = zlib.decompress(bytes(mutable))

    # Emulate VB6 behavior: destination buffer is pre-sized with OrigSize,
    # and uncompress writes into it. If output is shorter, remaining bytes
    # stay as zero; if larger, it is effectively limited by the destination size.
    if original_size <= 0:
        return output

    vb6_buffer = bytearray(original_size)
    copy_len = min(len(output), original_size)
    vb6_buffer[:copy_len] = output[:copy_len]
    return bytes(vb6_buffer)


def _compress_data(data: bytes, level: int = 9) -> bytes:
    compressed = bytearray(zlib.compress(data, level))
    if compressed:
        compressed[0] ^= XOR_KEY
    return bytes(compressed)


def read_archive_headers(archive_path: Path) -> List[InfoHeader]:
    with archive_path.open("rb") as f:
        file_header_raw = f.read(FILEHEADER_STRUCT.size)
        if len(file_header_raw) != FILEHEADER_STRUCT.size:
            raise ValueError("Archivo TDSL invalido: FILEHEADER incompleto.")

        _, num_files = FILEHEADER_STRUCT.unpack(file_header_raw)
        if num_files < 0:
            raise ValueError("Archivo TDSL invalido: cantidad de archivos negativa.")

        headers: List[InfoHeader] = []
        for _ in range(num_files):
            raw = f.read(INFOHEADER_STRUCT.size)
            if len(raw) != INFOHEADER_STRUCT.size:
                raise ValueError("Archivo TDSL invalido: INFOHEADER incompleto.")
            file_start, comp_size, file_name_raw, uncomp_size = INFOHEADER_STRUCT.unpack(raw)
            headers.append(InfoHeader(file_start, comp_size, file_name_raw, uncomp_size))

    return headers


def list_entries(archive_path: Path) -> List[InfoHeader]:
    return read_archive_headers(archive_path)


def extract_entry(
    archive_path: Path,
    entry_name: str,
    output_dir: Path,
    auto_fix_ext: bool = False,
) -> Path:
    normalized = _normalize_archive_name(entry_name)
    target_header = None

    for header in read_archive_headers(archive_path):
        if _normalize_archive_name(header.file_name) == normalized:
            target_header = header
            break

    if target_header is None:
        raise FileNotFoundError(f"No se encontro '{entry_name}' en '{archive_path.name}'.")

    with archive_path.open("rb") as f:
        # VB6 positions are 1-based; Python seeks with 0-based offsets.
        f.seek(target_header.file_start - 1)
        comp = f.read(target_header.compressed_size)

    data = _decompress_data(comp, target_header.uncompressed_size)
    data = _normalize_bmp_payload(data)
    output_dir.mkdir(parents=True, exist_ok=True)
    output_path = _build_output_path(output_dir, target_header.file_name, data, auto_fix_ext)
    output_path.write_bytes(data)
    return output_path


def extract_all(archive_path: Path, output_dir: Path, auto_fix_ext: bool = False) -> List[Path]:
    output_dir.mkdir(parents=True, exist_ok=True)
    extracted: List[Path] = []

    with archive_path.open("rb") as f:
        headers = read_archive_headers(archive_path)
        for header in headers:
            f.seek(header.file_start - 1)
            comp = f.read(header.compressed_size)
            data = _decompress_data(comp, header.uncompressed_size)
            data = _normalize_bmp_payload(data)
            out = _build_output_path(output_dir, header.file_name, data, auto_fix_ext)
            out.write_bytes(data)
            extracted.append(out)

    return extracted


def _iter_input_files(input_dir: Path) -> Iterable[Path]:
    for path in sorted(input_dir.rglob("*")):
        if path.is_file():
            yield path


def pack_archive(input_dir: Path, archive_path: Path) -> int:
    if not input_dir.exists() or not input_dir.is_dir():
        raise ValueError(f"Directorio invalido: {input_dir}")

    entries: List[ArchiveEntry] = []
    seen = set()

    for file_path in _iter_input_files(input_dir):
        archive_name = _normalize_archive_name(file_path.name)
        if archive_name in seen:
            raise ValueError(
                f"Nombre duplicado en archivo TDSL (case-insensitive): {archive_name}"
            )
        seen.add(archive_name)
        entries.append(ArchiveEntry(name=archive_name, data=file_path.read_bytes()))

    # Required for VB6 File_Find binary search compatibility.
    entries.sort(key=lambda x: _name_to_fixed_bytes(x.name))

    if len(entries) > 32767:
        raise ValueError("La cantidad de archivos supera el limite de Integer en VB6 (32767).")

    compressed_chunks: List[bytes] = [_compress_data(e.data) for e in entries]

    data_start_1_based = FILEHEADER_STRUCT.size + len(entries) * INFOHEADER_STRUCT.size + 1

    current_data_offset = 0
    info_headers_bytes = bytearray()
    for entry, chunk in zip(entries, compressed_chunks):
        file_start = data_start_1_based + current_data_offset
        info_headers_bytes.extend(
            INFOHEADER_STRUCT.pack(
                file_start,
                len(chunk),
                _name_to_fixed_bytes(entry.name),
                len(entry.data),
            )
        )
        current_data_offset += len(chunk)

    all_data = b"".join(compressed_chunks)
    total_size = FILEHEADER_STRUCT.size + len(info_headers_bytes) + len(all_data)
    file_header_bytes = FILEHEADER_STRUCT.pack(total_size, len(entries))

    archive_path.parent.mkdir(parents=True, exist_ok=True)
    with archive_path.open("wb") as f:
        f.write(file_header_bytes)
        f.write(info_headers_bytes)
        f.write(all_data)

    return len(entries)


def _sha256(path: Path) -> str:
    return hashlib.sha256(path.read_bytes()).hexdigest()


def verify_roundtrip(input_file: Path, archive_path: Path, temp_dir: Path) -> None:
    if not input_file.exists() or not input_file.is_file():
        raise ValueError(f"Archivo invalido para verificacion: {input_file}")

    src_dir = temp_dir / "source"
    out_dir = temp_dir / "out"
    src_dir.mkdir(parents=True, exist_ok=True)
    out_dir.mkdir(parents=True, exist_ok=True)

    staged = src_dir / input_file.name
    staged.write_bytes(input_file.read_bytes())

    pack_archive(src_dir, archive_path)
    extracted_path = extract_entry(archive_path, input_file.name, out_dir)

    h_src = _sha256(staged)
    h_out = _sha256(extracted_path)

    if h_src != h_out:
        raise ValueError(
            "Verificacion fallida: el hash del archivo original no coincide con el extraido."
        )


def _build_parser() -> argparse.ArgumentParser:
    parser = argparse.ArgumentParser(
        description="Herramienta para comprimir/descomprimir recursos TDSL compatibles con cliente VB6"
    )
    sub = parser.add_subparsers(dest="command", required=True)

    p_list = sub.add_parser("list", help="Lista los recursos contenidos en un .TDSL")
    p_list.add_argument("archive", type=Path)

    p_extract = sub.add_parser("extract", help="Extrae un recurso puntual desde un .TDSL")
    p_extract.add_argument("archive", type=Path)
    p_extract.add_argument("file_name")
    p_extract.add_argument("output_dir", type=Path)
    p_extract.add_argument(
        "--auto-fix-ext",
        action="store_true",
        help="Corrige extension segun firma binaria cuando no coincide (ej: BMP que en realidad es PNG).",
    )

    p_extract_all = sub.add_parser("extract-all", help="Extrae todos los recursos")
    p_extract_all.add_argument("archive", type=Path)
    p_extract_all.add_argument("output_dir", type=Path)
    p_extract_all.add_argument(
        "--auto-fix-ext",
        action="store_true",
        help="Corrige extension segun firma binaria cuando no coincide (ej: BMP que en realidad es PNG).",
    )

    p_pack = sub.add_parser("pack", help="Comprime una carpeta hacia un .TDSL")
    p_pack.add_argument("input_dir", type=Path)
    p_pack.add_argument("archive", type=Path)

    p_verify = sub.add_parser(
        "verify-roundtrip",
        help="Empaqueta un archivo, lo extrae y valida hash para comprobar compresion/descompresion",
    )
    p_verify.add_argument("input_file", type=Path)
    p_verify.add_argument("archive", type=Path)
    p_verify.add_argument("temp_dir", type=Path)

    return parser


def main(argv: list[str]) -> int:
    parser = _build_parser()
    args = parser.parse_args(argv)

    try:
        if args.command == "list":
            headers = list_entries(args.archive)
            print(f"Entradas: {len(headers)}")
            for h in headers:
                print(
                    f"- {h.file_name} | comp={h.compressed_size} bytes | raw={h.uncompressed_size} bytes | start={h.file_start}"
                )

        elif args.command == "extract":
            output = extract_entry(
                args.archive,
                args.file_name,
                args.output_dir,
                auto_fix_ext=args.auto_fix_ext,
            )
            print(f"Extraido: {output}")

        elif args.command == "extract-all":
            outputs = extract_all(args.archive, args.output_dir, auto_fix_ext=args.auto_fix_ext)
            print(f"Extraidos: {len(outputs)}")

        elif args.command == "pack":
            count = pack_archive(args.input_dir, args.archive)
            print(f"Archivo generado: {args.archive} ({count} recursos)")

        elif args.command == "verify-roundtrip":
            verify_roundtrip(args.input_file, args.archive, args.temp_dir)
            print("Verificacion OK: compresion/descompresion consistente")

        else:
            parser.print_help()
            return 1

        return 0
    except Exception as exc:
        print(f"ERROR: {exc}", file=sys.stderr)
        return 1


if __name__ == "__main__":
    raise SystemExit(main(sys.argv[1:]))
