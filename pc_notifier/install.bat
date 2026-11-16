@echo off
TITLE Instalasi Kalibrasi Reminder Notifier (Python Source)
color 0A
echo ========================================================
echo   INSTALASI SYSTEM REMINDER KALIBRASI EQUIPMENT (AC PE)
echo ========================================================
echo.

REM Cek apakah Python terinstal
python --version >nul 2>&1
if %errorlevel% neq 0 (
    echo [!] Python belum terinstal di komputer ini!
    echo Sedang mengunduh dan menginstal Python secara otomatis...
    
    REM Unduh dan instal Python installer silent
    powershell -Command "Invoke-WebRequest -Uri 'https://www.python.org/ftp/python/3.11.5/python-3.11.5-amd64.exe' -OutFile '%TEMP%\python_installer.exe'"
    echo Menginstal Python (Mohon tunggu beberapa saat)...
    start /wait %TEMP%\python_installer.exe /quiet InstallAllUsers=1 PrependPath=1 Include_test=0
    
    echo Python berhasil diinstal!
) else (
    echo [+] Python sudah terinstal di komputer ini.
)

echo.
echo [+] Menyiapkan direktori aplikasi...
REM Tentukan folder instalasi permanen (misal di C:\SEID_Calibration_Notifier)
set "INSTALL_DIR=C:\AC_Calibration_Notifier"
if not exist "%INSTALL_DIR%" mkdir "%INSTALL_DIR%"

REM Salin file skrip python ke folder instalasi
copy /y "%~dp0reminder_notifier.py" "%INSTALL_DIR%\reminder_notifier.py" >nul

echo [+] Membuat launcher script (run.bat)...
(
echo @echo off
echo cd /d "%INSTALL_DIR%"
echo python reminder_notifier.py
) > "%INSTALL_DIR%\run.bat"

echo.
echo [+] Mendaftarkan aplikasi ke Startup Windows (shell:startup)...
REM Buat file vbs atau shortcut di folder startup agar otomatis berjalan saat PC menyala tanpa jendela CMD hitam menumpuk
set "STARTUP_FOLDER=%APPDATA%\Microsoft\Windows\Start Menu\Programs\Startup"
(
echo Set WshShell = CreateObject("WScript.Shell")
echo WshShell.Run chr(34) ^& "%INSTALL_DIR%\run.bat" ^& chr(34), 0
echo Set WshShell = Nothing
) > "%STARTUP_FOLDER%\CalibrationReminder.vbs"

echo.
echo ========================================================
echo   INSTALASI SELESAI DENGAN SUKSES!
echo ========================================================
echo - Aplikasi terinstal di: %INSTALL_DIR%
echo - Berjalan otomatis setiap PC dinyalakan via Windows Startup.
echo.
pause
