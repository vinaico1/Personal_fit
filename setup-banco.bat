@echo off
chcp 65001 >nul
echo.
echo  ================================================
echo   FitLife - Setup do Banco de Dados (Supabase)
echo  ================================================
echo.
echo  Voce vai precisar da senha do banco Supabase.
echo  Encontre em: supabase.com ^> seu projeto ^> Settings ^> Database ^> Password
echo.

REM -------------------------------------------------------
REM  Preencha os dados do seu projeto Supabase abaixo:
REM  Encontre em: Settings > Database > Connection string
REM -------------------------------------------------------
set SUPABASE_HOST=aws-0-sa-east-1.pooler.supabase.com
set SUPABASE_PORT=6543
set SUPABASE_DB=postgres
set SUPABASE_USER=postgres.zrvqtucsjogafnnwvosi

echo  Host:     %SUPABASE_HOST%
echo  Database: %SUPABASE_DB%
echo  Usuario:  %SUPABASE_USER%
echo.

REM Verificar se psql esta instalado
where psql >nul 2>&1
if errorlevel 1 (
    echo  [AVISO] psql nao encontrado no PATH.
    echo  Instale o PostgreSQL: https://www.postgresql.org/download/windows/
    echo  Ou rode o setup.sql manualmente no SQL Editor do Supabase.
    echo.
    echo  Abrindo o SQL Editor do Supabase no navegador...
    start https://supabase.com/dashboard/project/zrvqtucsjogafnnwvosi/sql/new
    pause
    exit /b 1
)

echo  [1/2] Executando setup.sql (schema + dados)...
psql "host=%SUPABASE_HOST% port=%SUPABASE_PORT% dbname=%SUPABASE_DB% user=%SUPABASE_USER% sslmode=require" -f "%~dp0supabase\setup.sql"

if errorlevel 1 (
    echo.
    echo  [ERRO] Falha ao executar setup.sql
    pause
    exit /b 1
)

echo.
echo  [2/2] Configurando usuario admin...
psql "host=%SUPABASE_HOST% port=%SUPABASE_PORT% dbname=%SUPABASE_DB% user=%SUPABASE_USER% sslmode=require" -f "%~dp0supabase\criar-admin.sql"

echo.
echo  ================================================
echo   Banco configurado com sucesso!
echo   Agora execute run.bat para iniciar o app.
echo  ================================================
echo.
pause
