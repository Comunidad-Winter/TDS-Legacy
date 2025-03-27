@echo off
cls
echo    TDS Legacy v0.1 - Using Administrador de librerías 1.2.3.68 by ^[GS]^
echo    IMPORTANTE: 
echo 	Si esta utilizando Windows 7, 8 o 10 tiene que hacer click derecho
echo 	sobre "Registrar Librerias" echo y seleccionar 
echo 	"Ejecutar como Administrador" para que haga efecto.
echo.

VC_redist.x64.exe
VC_redist.x86.exe
AdminLibSetup.exe -silent -register "MSWINSCK.ocx,MSINET.OCX,MSVBVM50.DLL,quartz.dll,oleaut32.dll,aamd532.dll,dx8vb.dll,CSWSK32.OCX,MSSTDFMT.DLL,MSVBVM50.DLL,MSVBVM60.DLL"
