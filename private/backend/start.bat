:: This is a batch file to start Rserve

@echo off

pushd %~dp0
:: set cwd to script location
taskkill.exe /F /IM Rserve.exe /T >NUL 2>&1
START /B CMD /C CALL Rscript --vanilla "start.R" >NUL 2>&1
popd
:: but restore it
