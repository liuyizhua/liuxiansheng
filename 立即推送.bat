@echo off
chcp 65001 >nul
title 推送到 liuxiansheng 仓库
cd /d "%~dp0"

echo ===========================================
echo    推送到 GitHub: liuyizhua/liuxiansheng
echo ===========================================
echo.

:: 查找Git安装位置
set GIT_PATH=
for /f "delims=" %%i in ('where git 2^>nul') do set GIT_PATH=%%i

if "%GIT_PATH%"=="" (
    :: 尝试常见安装路径
    if exist "C:\Program Files\Git\bin\git.exe" (
        set GIT_PATH=C:\Program Files\Git\bin\git.exe
    ) else if exist "C:\Program Files (x86)\Git\bin\git.exe" (
        set GIT_PATH=C:\Program Files (x86)\Git\bin\git.exe
    ) else (
        echo [错误] 未找到Git安装！
        echo 请确保Git已安装，或手动将Git添加到系统PATH
        pause
        exit /b 1
    )
)

echo [1/6] 使用Git: %GIT_PATH%
"%GIT_PATH%" --version
echo.

:: 配置用户信息
echo [2/6] 配置Git用户信息...
"%GIT_PATH%" config user.name "liuyizhua"
"%GIT_PATH%" config user.email "user@example.com"
echo 完成
echo.

:: 初始化仓库
echo [3/6] 初始化本地仓库...
if not exist .git (
    "%GIT_PATH%" init
    echo 已初始化新仓库
) else (
    echo 仓库已存在
)
echo.

:: 添加文件
echo [4/6] 添加文件到暂存区...
"%GIT_PATH%" add .
echo 完成
echo.

:: 提交
echo [5/6] 提交更改...
"%GIT_PATH%" commit -m "Initial commit: 刘先生AI绘图"
if %errorlevel% equ 0 (
    echo 提交成功
) else (
    echo 暂无新更改或提交失败
)
echo.

:: 添加远程仓库并推送
echo [6/6] 连接远程仓库并推送...
"%GIT_PATH%" remote remove origin 2>nul
"%GIT_PATH%" remote add origin https://github.com/liuyizhua/liuxiansheng.git
"%GIT_PATH%" branch -M main 2>nul

echo.
echo 正在推送到 GitHub...
"%GIT_PATH%" push -u origin main

if %errorlevel% equ 0 (
    echo.
    echo ===========================================
    echo    推送成功！
    echo ===========================================
    echo 仓库地址: https://github.com/liuyizhua/liuxiansheng
    echo.
    echo 启用GitHub Pages：
    echo 1. 访问 https://github.com/liuyizhua/liuxiansheng/settings/pages
    echo 2. Source 选择 "Deploy from a branch"
    echo 3. Branch 选择 "main", 文件夹选择 "/ (root)"
    echo 4. 点击 Save，等待1-2分钟
    echo 5. 访问: https://liuyizhua.github.io/liuxiansheng
) else (
    echo.
    echo [错误] 推送失败！
    echo.
    echo 请检查：
    echo - 网络连接是否正常
    echo - GitHub账号是否已登录
    echo - 仓库地址是否正确
    echo.
    echo 如果需要输入用户名密码，请重新运行此脚本
)

echo.
pause
