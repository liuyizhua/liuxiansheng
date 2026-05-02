@echo off
chcp 65001 >nul
title 检查Git安装状态
echo ===========================================
echo    检查Git安装状态
echo ===========================================
echo.

echo [1] 检查系统PATH中的Git...
where git 2>nul
if %errorlevel% equ 0 (
    echo    找到Git！
    git --version
) else (
    echo    未在PATH中找到Git
)
echo.

echo [2] 检查常见安装位置...
set FOUND=
if exist "C:\Program Files\Git\bin\git.exe" (
    echo    找到: C:\Program Files\Git\bin\git.exe
    "C:\Program Files\Git\bin\git.exe" --version
    set FOUND=1
)
if exist "C:\Program Files (x86)\Git\bin\git.exe" (
    echo    找到: C:\Program Files (x86)\Git\bin\git.exe
    "C:\Program Files (x86)\Git\bin\git.exe" --version
    set FOUND=1
)
if exist "%LOCALAPPDATA%\Programs\Git\bin\git.exe" (
    echo    找到: %LOCALAPPDATA%\Programs\Git\bin\git.exe
    "%LOCALAPPDATA%\Programs\Git\bin\git.exe" --version
    set FOUND=1
)
if exist "%USERPROFILE%\AppData\Local\Programs\Git\bin\git.exe" (
    echo    找到: %USERPROFILE%\AppData\Local\Programs\Git\bin\git.exe
    "%USERPROFILE%\AppData\Local\Programs\Git\bin\git.exe" --version
    set FOUND=1
)

if "%FOUND%"=="" (
    echo    未在常见位置找到Git
)
echo.

echo [3] 检查环境变量...
echo    PATH包含Git: 
set PATH | findstr /i "git" >nul && echo    是 || echo    否
echo.

echo ===========================================
if "%FOUND%"=="" (
    echo    未检测到Git安装！
    echo.
    echo 解决方案：
    echo 1. 访问 https://git-scm.com/download/win 下载Git
    echo 2. 运行安装程序
    echo 3. 安装时务必勾选：
    echo    ☑ "Git from the command line and also from 3rd-party software"
    echo 4. 完成安装后，重新打开命令行窗口
    echo 5. 再次运行此脚本检查
) else (
    echo    Git已安装！
    echo.
    echo 如果仍然无法使用，请尝试：
    echo 1. 重新打开命令行窗口
    echo 2. 重启电脑
    echo 3. 手动将Git路径添加到系统PATH
)
echo ===========================================

pause
