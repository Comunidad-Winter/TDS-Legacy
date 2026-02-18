@echo off
setlocal

set "TOOLS_DIR=%~dp0"
set "CLIENT_ROOT=%TOOLS_DIR%.."
set "PYTHON_EXE=python"
set "TOOL_SCRIPT=%TOOLS_DIR%tdsl_resource_tool.py"
set "OUT_BASE=%TOOLS_DIR%recursos_descompilados"
set "WARNINGS=0"

if not exist "%TOOL_SCRIPT%" (
  echo ERROR: No se encontro el script %TOOL_SCRIPT%
  exit /b 1
)

if not exist "%OUT_BASE%" mkdir "%OUT_BASE%"

echo.
echo [1/6] Extrayendo Interface.TDSL...
call :extract_archive "%CLIENT_ROOT%\Graficos\Interface.TDSL" "%OUT_BASE%\Interface"

echo [2/6] Extrayendo Graphics.TDSL...
call :extract_archive "%CLIENT_ROOT%\Graficos\Graphics.TDSL" "%OUT_BASE%\Graphics"

echo [3/6] Extrayendo INITs.TDSL...
call :extract_archive "%CLIENT_ROOT%\Graficos\INITs.TDSL" "%OUT_BASE%\INITs"

echo [4/6] Extrayendo Musics.TDSL...
call :extract_archive "%CLIENT_ROOT%\Graficos\Musics.TDSL" "%OUT_BASE%\Musics"

echo [5/6] Extrayendo Sounds.TDSL...
call :extract_archive "%CLIENT_ROOT%\Graficos\Sounds.TDSL" "%OUT_BASE%\Sounds"

echo [6/6] Extrayendo MapsTDS.TDSL...
call :extract_archive "%CLIENT_ROOT%\Mapas\MapsTDS.TDSL" "%OUT_BASE%\MapsTDS"

echo.
echo OK: Recursos descompilados en "%OUT_BASE%"
if not "%WARNINGS%"=="0" (
  echo WARNING: Se encontraron %WARNINGS% paquetes vacios o invalidos.
)
exit /b 0

:extract_archive
set "ARCHIVE_PATH=%~1"
set "TARGET_DIR=%~2"

if not exist "%ARCHIVE_PATH%" (
  echo WARNING: No existe "%ARCHIVE_PATH%". Se omite.
  set /a WARNINGS+=1
  goto :eof
)

for %%F in ("%ARCHIVE_PATH%") do set "ARCHIVE_SIZE=%%~zF"
if "%ARCHIVE_SIZE%"=="0" (
  echo WARNING: "%ARCHIVE_PATH%" esta vacio. Se omite.
  set /a WARNINGS+=1
  goto :eof
)

if exist "%TARGET_DIR%" rd /s /q "%TARGET_DIR%"
mkdir "%TARGET_DIR%"

"%PYTHON_EXE%" "%TOOL_SCRIPT%" extract-all "%ARCHIVE_PATH%" "%TARGET_DIR%" --auto-fix-ext
if errorlevel 1 (
  echo WARNING: Fallo al extraer "%ARCHIVE_PATH%". Se omite.
  set /a WARNINGS+=1
)
goto :eof
