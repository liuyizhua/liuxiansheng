@echo off
chcp 65001 >nul
title 推送到 liuxiansheng 仓库
echo ===========================================
echo    推送到 GitHub: liuyizhua/liuxiansheng
echo ===========================================
echo.

:: 检查Git
where git >nul 2>nul
if %errorlevel% neq 0 (
    echo [错误] 未检测到Git！请确保Git已正确安装并添加到系统PATH
    echo 安装时请勾选 "Git from the command line and also from 3rd-party software"
    pause
    exit /b 1
)

echo [1/6] Git版本:
git --version
echo.

:: 配置用户信息
echo [2/6] 配置Git用户信息...
git config user.name "liuyizhua" 2>nul
git config user.email "user@example.com" 2>nul
echo 完成
echo.

:: 初始化仓库（如果不存在）
echo [3/6] 初始化本地仓库...
if not exist .git (
    git init
    echo 已初始化新仓库
) else (
    echo 仓库已存在
)
echo.

:: 添加所有文件
echo [4/6] 添加文件到暂存区...
git add .
echo 完成
echo.

:: 提交
echo [5/6] 提交更改...
git commit -m "Initial commit: 刘先生AI绘图" 2>nul
if %errorlevel% equ 0 (
    echo 提交成功
) else (
    echo 暂无新更改需要提交
)
echo.

:: 添加远程仓库并推送
echo [6/6] 连接远程仓库并推送...
git remote remove origin 2>nul
git remote add origin https://github.com/liuyizhua/liuxiansheng.git
git branch -M main 2>nul

echo.
echo 正在推送到 GitHub...
git push -u origin main

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
    echo 可能原因：
    echo - 网络连接问题
    echo - 需要登录GitHub账号
    echo - 仓库权限问题
    echo.
    echo 尝试使用SSH方式：
    echo git remote set-url origin git@github.com:liuyizhua/liuxiansheng.git
)

echo.
pause
