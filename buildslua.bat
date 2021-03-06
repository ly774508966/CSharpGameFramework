@echo off
if NOT "%1" EQU "" (
  set cfg=%1
) else (
  set cfg=Debug
)
if NOT "%2" EQU "" (
  set is_pause=%2
) else (
  set is_pause=True
)

rem lang: chs cht kr
set lang=chs

rem working directory
set workdir=%~dp0

set plugindir=%workdir%\Unity3d\Assets\Plugins
set logdir=%workdir%\BuildLog
set libdir=%workdir%\ExternLibrary

rem xbuild is copy from mono-3.0.3/lib/mono/4.5
rem this xbuild will probably not work in a clean machine
set xbuild=%workdir%\Tools\xbuild\xbuild.exe

rem mdb generator
set pdb2mdb=%workdir%\Tools\mono\mono.exe %workdir%\Tools\lib\mono\4.0\pdb2mdb.exe

rem show xbuild version
%xbuild% /version
echo.

rem make build log dir
mkdir %logdir%

rem 1. build SluaExport.sln
rem 2. update output(dll/pdb) to dinary directory
rem 3. generate mdb at binary directory according to pdb files

echo building SluaExport.sln ...
%xbuild% /nologo /noconsolelogger /property:Configuration=%cfg% ^
         /flp:LogFile=%logdir%\SluaExport.sln.log;Encoding=UTF-8 ^
		 /t:clean;rebuild ^
         %workdir%\SluaExport\SluaExport.sln
if NOT %ERRORLEVEL% EQU 0 (
  echo build failed, check %logdir%\SluaExport.sln.log.
  goto error_end
) else (
  echo done.
)

echo [client]: generate *mdb debug files for mono

pushd %workdir%\SluaExport\bin\%cfg%
for /r %%i in (*.pdb) do (
  %pdb2mdb% %%~dpni.dll
)
popd
echo done. & echo.

rem copy dll to unity3d's plugin directory
echo "update binaries"
xcopy %workdir%\SluaExport\bin\%cfg%\SluaExport.dll %plugindir% /y /q
xcopy %workdir%\SluaExport\bin\%cfg%\SluaExport.dll.mdb %plugindir% /y /q
xcopy %workdir%\SluaExport\bin\%cfg%\SluaManaged.dll %plugindir% /y /q
xcopy %workdir%\SluaExport\bin\%cfg%\SluaManaged.dll.mdb %plugindir% /y /q

if NOT %ERRORLEVEL% EQU 0 (
  echo copy failed, exclusive access error? check your running process and retry.
  goto error_end
) else (
  echo done.
)

goto good_end

:error_end
set ec=1
goto end
:good_end
set ec=0
echo All Done, Good to Go.
:end
if %is_pause% EQU True (
  pause
  exit /b %ec%
)
