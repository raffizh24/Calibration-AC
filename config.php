<?php
// Konfigurasi Database MySQL
define('DB_HOST', '192.168.180.181');
define('DB_USER', 'pcs_ac');
define('DB_PASS', 'SeidMail01');
define('DB_NAME', 'seid_ac_kalibrasi');
define('DB_PORT', 3307); // Port kustom MySQL

// Batas Pengingat Kalibrasi (3 Bulan / 90 Hari Sebelum Due Date)
define('REMINDER_DAYS', 90);

date_default_timezone_set('Asia/Jakarta');

function getDB()
{
    static $pdo = null;
    if ($pdo === null) {
        // Menambahkan parameter port ke dalam DSN PDO
        $dsn = "mysql:host=" . DB_HOST . ";port=" . DB_PORT . ";dbname=" . DB_NAME . ";charset=utf8mb4";
        $options = [
            PDO::ATTR_ERRMODE => PDO::ERRMODE_EXCEPTION,
            PDO::ATTR_DEFAULT_FETCH_MODE => PDO::FETCH_ASSOC,
            PDO::ATTR_EMULATE_PREPARES => false,
        ];
        $pdo = new PDO($dsn, DB_USER, DB_PASS, $options);
    }
    return $pdo;
}
