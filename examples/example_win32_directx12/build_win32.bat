call "C:\Program Files\Microsoft Visual Studio\2022\Professional\VC\Auxiliary\Build\vcvars64.bat" x64 >NUL
if ERRORLEVEL 1 (
	echo Failed to find vcvars. Please update the path in %0
	exit /b 1
)

taskkill /im example_win32_directx12.exe 2>NUL

@cd %~dp0

@set OUT_DIR=Debug
@set OUT_EXE=example_win32_directx12
@set INCLUDES=/I..\.. /I..\..\backends /I "%WindowsSdkDir%Include\um" /I "%WindowsSdkDir%Include\shared"
@set SOURCES=main.cpp ..\..\backends\imgui_impl_dx12.cpp ..\..\backends\imgui_impl_win32.cpp ..\..\imgui*.cpp
@set LIBS=d3d12.lib d3dcompiler.lib dxgi.lib
mkdir Debug 2>NUL
cl /nologo /Zi /MD /utf-8 %INCLUDES% /D UNICODE /D _UNICODE %SOURCES% /Fe%OUT_DIR%/%OUT_EXE%.exe /Fo%OUT_DIR%/ /link %LIBS%
call Debug\example_win32_directx12.exe
