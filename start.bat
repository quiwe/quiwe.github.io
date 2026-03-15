@echo off
echo ========================================
echo   博客本地服务器启动中...
echo   按 Ctrl+C 停止服务器
echo ========================================
echo.
echo 博客地址: http://localhost:8080
echo.

cd /d "%~dp0blog"
python -m http.server 8080
