mkdir build
cd build

cmake %CMAKE_ARGS% ^
    -G "Ninja" ^
    -DCMAKE_INSTALL_PREFIX=%LIBRARY_PREFIX% ^
    -DCMAKE_BUILD_TYPE=Release ^
    -DCMAKE_INSTALL_SYSTEM_RUNTIME_LIBS_SKIP=True ^
    %SRC_DIR%
if errorlevel 1 exit 1

:: Install.
cmake --build . --config Release --target install
if errorlevel 1 exit 1

:: A real executable works without Windows symlink privileges.
if exist "%LIBRARY_BIN%\fast-discovery-server.exe" del "%LIBRARY_BIN%\fast-discovery-server.exe"
if errorlevel 1 exit 1
copy /Y "%LIBRARY_BIN%\fast-discovery-server-1.0.0.exe" "%LIBRARY_BIN%\fast-discovery-server.exe"
if errorlevel 1 exit 1

:: Use the environment's Python, not the system-wide py launcher.
> "%LIBRARY_BIN%\fastdds.bat" echo @python "%%~dp0..\tools\fastdds\fastdds.py" %%*
if errorlevel 1 exit 1
> "%LIBRARY_BIN%\ros-discovery.bat" echo @python "%%~dp0..\tools\fastdds\fastdds.py" discovery %%*
if errorlevel 1 exit 1
