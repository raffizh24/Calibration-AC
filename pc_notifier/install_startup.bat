@echo off
title Setup Calibration PC Notifier (Auto-Start)
echo ====================================================================
echo   SETUP CALIBRATION DESKTOP NOTIFIER (AUTO POPUP ^& AUTO CLOSE 5 MENIT)
echo ====================================================================
echo.
python --version >nul 2>&1
if %errorlevel% neq 0 (
    echo [ERROR] Python tidak ditemukan di PATH Windows.
    echo Pastikan Python sudah terinstall atau gunakan file .EXE hasil compile PyInstaller.
    pause
    exit /b 1
)
set "SCRIPT_DIR=%~dp0"
set "STARTUP_DIR=%APPDATA%\Microsoft\Windows\Start Menu\Programs\Startup"
set "VBS_FILE=%STARTUP_DIR%\CalibrationReminderNotifier.vbs"
echo Set WshShell = CreateObject("WScript.Shell") > "%VBS_FILE%"
echo WshShell.Run "pythonw ""%SCRIPT_DIR%calibration_notifier.py""", 0, False >> "%VBS_FILE%"
echo [OK] Berhasil mendaftarkan notifier ke Windows Startup!
echo Lokasi Launcher: %VBS_FILE%
echo.
echo Menjalankan test popup notifikasi sekarang...
start "" pythonw "%SCRIPT_DIR%calibration_notifier.py"
echo Selesai.
pause
