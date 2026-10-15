@echo off
chcp 65001 >nul
title MapartCraft 開發伺服器
cd /d "%~dp0"

where node >nul 2>nul
if errorlevel 1 (
  echo.
  echo [錯誤] 找不到 Node.js
  echo.
  echo 請先開啟 PowerShell 執行這行安裝:
  echo     winget install OpenJS.NodeJS.LTS
  echo.
  echo 安裝完成後「關掉所有終端機視窗」再重新執行本檔案。
  echo.
  pause
  exit /b 1
)

rem 舊版 react-scripts 4.0.3 搭配新版 Node 必須加這個參數,
rem 否則會出現 error:0308010C digital envelope routines::unsupported
set "NODE_OPTIONS=--openssl-legacy-provider"

if not exist "node_modules" (
  echo 偵測到缺少套件, 正在安裝 ^(第一次會比較久^)...
  echo.
  call npm install
  if errorlevel 1 (
    echo.
    echo [錯誤] npm install 失敗
    pause
    exit /b 1
  )
)

echo.
echo ============================================
echo   MapartCraft 伺服器啟動中...
echo.
echo   編譯完成後瀏覽器會自動開啟
echo   網址: http://localhost:3000/mapartcraft
echo.
echo   停止請按 Ctrl+C
echo ============================================
echo.

call npm start

echo.
echo 伺服器已停止。
pause
