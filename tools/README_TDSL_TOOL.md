# TDSL Resource Tool (compatibilidad VB6)

Herramienta para comprimir y descomprimir recursos `.TDSL` usando el mismo formato del cliente VB6.

## Ubicacion

- Script: `tools/tdsl_resource_tool.py`

## Requisitos

- Python 3.8+

## Uso simple (recomendado)

Ejecutar desde `CLIENTE TDS LEGACY`:

```powershell
tools\descompilar_todo.bat
tools\compilar_todo.bat
```

### Que hace cada script

- `tools\descompilar_todo.bat`
  - Extrae todo lo posible desde:
    - `Graficos\Interface.TDSL`
    - `Graficos\Graphics.TDSL`
    - `Graficos\INITs.TDSL`
    - `Graficos\Musics.TDSL`
    - `Graficos\Sounds.TDSL`
    - `Mapas\MapsTDS.TDSL`
  - Salida organizada en carpetas separadas:
    - `tools\recursos_descompilados\Interface`
    - `tools\recursos_descompilados\Graphics`
    - `tools\recursos_descompilados\INITs`
    - `tools\recursos_descompilados\Musics`
    - `tools\recursos_descompilados\Sounds`
    - `tools\recursos_descompilados\MapsTDS`
  - Si algun `.TDSL` no existe, esta vacio o esta corrupto, lo reporta como `WARNING` y continua.

- `tools\compilar_todo.bat`
  - Toma las carpetas anteriores como entrada.
  - Genera nuevos `.TDSL` en:
    - `tools\recursos_compilados\Interface.TDSL`
    - `tools\recursos_compilados\Graphics.TDSL`
    - `tools\recursos_compilados\INITs.TDSL`
    - `tools\recursos_compilados\Musics.TDSL`
    - `tools\recursos_compilados\Sounds.TDSL`
    - `tools\recursos_compilados\MapsTDS.TDSL`

### Flujo recomendado

1. Ejecuta `tools\descompilar_todo.bat`.
2. Edita/organiza archivos dentro de `tools\recursos_descompilados\...`.
3. Ejecuta `tools\compilar_todo.bat`.
4. Si quieres usar esos paquetes en el cliente, copia manualmente desde `tools\recursos_compilados` a `Graficos` y `Mapas`.

## Comandos

Ejecutar desde `CLIENTE TDS LEGACY`:

```powershell
python tools/tdsl_resource_tool.py list "Graficos/Interface.TDSL"
python tools/tdsl_resource_tool.py extract "Graficos/Interface.TDSL" "10006.bmp" "tools/_tdsl_test/extracted_interface"
python tools/tdsl_resource_tool.py extract-all "Graficos/Graphics.TDSL" "tools/_tdsl_test/all_graphics"
python tools/tdsl_resource_tool.py pack "tools/_tdsl_test/extracted_interface" "tools/_tdsl_test/new_interface.tdsl"
python tools/tdsl_resource_tool.py verify-roundtrip "tools/_tdsl_test/extracted_interface/10006.bmp" "tools/_tdsl_test/roundtrip_interface.tdsl" "tools/_tdsl_test/roundtrip_work"
```

## Notas de compatibilidad

- `INFOHEADER.strFileName` tiene limite de 16 bytes (CP1252), como en VB6.
- Los nombres se almacenan en minusculas para mantener el comportamiento del cliente.
- Los datos usan `zlib` y el primer byte comprimido se ofusca con `XOR 166`.
- Las entradas del archivo se ordenan por nombre para mantener compatibilidad con la busqueda binaria del cliente (`File_Find`).
