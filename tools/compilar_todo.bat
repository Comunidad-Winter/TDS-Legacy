@echo off
setlocal

set "TOOLS_DIR=%~dp0"
set "CLIENT_ROOT=%TOOLS_DIR%.."
set "PYTHON_EXE=python"
set "TOOL_SCRIPT=%TOOLS_DIR%tdsl_resource_tool.py"
set "IN_BASE=%TOOLS_DIR%recursos_descompilados"
set "OUT_BASE=%TOOLS_DIR%recursos_compilados"

if not exist "%TOOL_SCRIPT%" (
  echo ERROR: No se encontro el script %TOOL_SCRIPT%
  exit /b 1
)

if not exist "%IN_BASE%" (
  echo ERROR: No existe la carpeta de entrada "%IN_BASE%"
  echo Primero ejecuta descompilar_todo.bat o crea manualmente las carpetas.
  exit /b 1
)

if not exist "%OUT_BASE%" mkdir "%OUT_BASE%"

if not exist "%IN_BASE%\Interface" mkdir "%IN_BASE%\Interface"
if not exist "%IN_BASE%\Graphics" mkdir "%IN_BASE%\Graphics"
if not exist "%IN_BASE%\INITs" mkdir "%IN_BASE%\INITs"
if not exist "%IN_BASE%\Musics" mkdir "%IN_BASE%\Musics"
if not exist "%IN_BASE%\Sounds" mkdir "%IN_BASE%\Sounds"
if not exist "%IN_BASE%\MapsTDS" mkdir "%IN_BASE%\MapsTDS"

echo.
echo [1/6] Compilando Interface.TDSL...
"%PYTHON_EXE%" "%TOOL_SCRIPT%" pack "%IN_BASE%\Interface" "%OUT_BASE%\Interface.TDSL"
if errorlevel 1 exit /b 1

echo [2/6] Compilando Graphics.TDSL...
"%PYTHON_EXE%" "%TOOL_SCRIPT%" pack "%IN_BASE%\Graphics" "%OUT_BASE%\Graphics.TDSL"
if errorlevel 1 exit /b 1

echo [3/6] Compilando INITs.TDSL...
"%PYTHON_EXE%" "%TOOL_SCRIPT%" pack "%IN_BASE%\INITs" "%OUT_BASE%\INITs.TDSL"
if errorlevel 1 exit /b 1

echo [4/6] Compilando Musics.TDSL...
"%PYTHON_EXE%" "%TOOL_SCRIPT%" pack "%IN_BASE%\Musics" "%OUT_BASE%\Musics.TDSL"
if errorlevel 1 exit /b 1

echo [5/6] Compilando Sounds.TDSL...
"%PYTHON_EXE%" "%TOOL_SCRIPT%" pack "%IN_BASE%\Sounds" "%OUT_BASE%\Sounds.TDSL"
if errorlevel 1 exit /b 1

echo [6/6] Compilando MapsTDS.TDSL...
"%PYTHON_EXE%" "%TOOL_SCRIPT%" pack "%IN_BASE%\MapsTDS" "%OUT_BASE%\MapsTDS.TDSL"
if errorlevel 1 exit /b 1

echo.
echo OK: Recursos compilados en "%OUT_BASE%"
echo Si quieres reemplazar los del cliente, copia manualmente:
echo   - Interface/Graphics/INITs/Musics/Sounds a "%CLIENT_ROOT%\Graficos"
echo   - MapsTDS.TDSL a "%CLIENT_ROOT%\Mapas"
exit /b 0
