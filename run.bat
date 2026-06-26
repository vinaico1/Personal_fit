@echo off
echo.
echo  ====================================
echo   FitLife - Iniciando servidor local
echo  ====================================
echo.

cd /d "%~dp0"

if not exist "node_modules" (
    echo  [1/2] Instalando dependencias...
    npm install
    echo.
)

echo  [2/2] Iniciando Next.js em http://localhost:3000
echo.
npm run dev
