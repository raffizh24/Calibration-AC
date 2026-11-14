<?php
require_once __DIR__ . '/config.php';

header('Content-Type: application/json; charset=utf-8');
header('Access-Control-Allow-Origin: *');

try {
    $pdo = getDB();
    $sql = "SELECT id, control_no, name, location, brand, type_model, serial_no, cal_date, due_date, cal_by, loc_cal,
                   DATEDIFF(due_date, CURDATE()) AS days_left
            FROM equipments
            WHERE DATEDIFF(due_date, CURDATE()) <= :days
            ORDER BY due_date ASC, control_no ASC";
    $stmt = $pdo->prepare($sql);
    $stmt->execute([':days' => REMINDER_DAYS]);
    $items = $stmt->fetchAll();

    $overdueCount = 0;
    $warningCount = 0;
    foreach ($items as $item) {
        if ((int)$item['days_left'] < 0) $overdueCount++;
        else $warningCount++;
    }

    echo json_encode([
        'success' => true,
        'checked_at' => date('Y-m-d H:i:s'),
        'reminder_days' => REMINDER_DAYS,
        'total_due' => count($items),
        'overdue_count' => $overdueCount,
        'warning_count' => $warningCount,
        'items' => $items
    ]);
} catch (Exception $e) {
    http_response_code(500);
    echo json_encode([
        'success' => false,
        'message' => $e->getMessage()
    ]);
}
