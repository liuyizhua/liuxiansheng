@echo off
chcp 65001 >nul
title 上传刘先生AI绘图到GitHub
echo ===========================================
echo    刘先生AI绘图 - GitHub上传脚本
echo ===========================================
echo.

:: 检查Git是否安装
where git >nul 2>nul
if %errorlevel% neq 0 (
    echo [错误] 未检测到Git安装！
    echo.
    echo 请按以下步骤操作：
    echo 1. 访问 https://git-scm.com/download/win
    echo 2. 下载并安装Git for Windows
    echo 3. 安装时勾选"Git from the command line..."
    echo 4. 安装完成后，重新运行此脚本
    echo.
    pause
    exit /b 1
)

echo [1/5] Git已检测到
git --version
echo.

:: 设置Git用户信息（如果未设置）
echo [2/5] 配置Git用户信息...
git config --global user.name >nul 2>nul
if %errorlevel% neq 0 (
    set /p GIT_NAME="请输入您的GitHub用户名: "
    git config --global user.name "%GIT_NAME%"
)
git config --global user.email >nul 2>nul
if %errorlevel% neq 0 (
    set /p GIT_EMAIL="请输入您的GitHub邮箱: "
    git config --global user.email "%GIT_EMAIL%"
)
echo Git用户信息已配置
echo.

:: 初始化Git仓库
echo [3/5] 初始化Git仓库...
if not exist .git (
    git init
    echo Git仓库已初始化
) else (
    echo Git仓库已存在
)
echo.

:: 添加文件
echo [4/5] 添加文件到暂存区...
git add .
echo 文件已添加
echo.

:: 提交更改
echo [5/5] 提交更改...
git commit -m "Initial commit: 刘先生AI绘图项目"
echo 更改已提交
echo.

echo ===========================================
echo    本地Git操作完成！
echo ===========================================
echo.
echo 接下来需要连接GitHub远程仓库：
echo.
echo 1. 访问 https://github.com/new 创建新仓库
echo    - 仓库名建议: liu-ai-draw
echo    - 不要勾选 README、.gitignore 或 license
echo    - 点击 Create repository
echo.
echo 2. 创建后，复制页面上的以下命令并执行：
echo    git remote add origin https://github.com/您的用户名/仓库名.git
echo    git branch -M main
echo    git push -u origin main
echo.
echo 或者继续运行此脚本，输入您的信息：
echo.

set /p GITHUB_USER="请输入GitHub用户名: "
set /p REPO_NAME="请输入仓库名: "

echo.
echo 连接远程仓库...
git remote add origin https://github.com/%GITHUB_USER%/%REPO_NAME%.git
git branch -M main
git push -u origin main

if %errorlevel% equ 0 (
    echo.
    echo ===========================================
    echo    上传成功！
    echo ===========================================
    echo 仓库地址: https://github.com/%GITHUB_USER%/%REPO_NAME%
    echo.
    echo 启用GitHub Pages：
    echo 1. 访问 https://github.com/%GITHUB_USER%/%REPO_NAME%/settings/pages
    echo 2. Source 选择 "Deploy from a branch"
    echo 3. Branch 选择 "main", 文件夹选择 "/ (root)"
    echo 4. 点击 Save，等待1-2分钟
    echo 5. 访问: https://%GITHUB_USER%.github.io/%REPO_NAME%
) else (
    echo.
    echo [错误] 上传失败，请检查：
    echo - GitHub用户名和仓库名是否正确
    echo - 是否已在GitHub创建仓库
    echo - 网络连接是否正常
)

echo.
pause
