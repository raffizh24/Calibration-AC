<?php
require_once __DIR__ . '/config.php';

header('Content-Type: application/json; charset=utf-8');

try {
    $pdo = getDB();
} catch (Exception $e) {
    http_response_code(500);
    echo json_encode(['success' => false, 'message' => 'Koneksi database gagal: ' . $e->getMessage()]);
    exit;
}

$action = $_GET['action'] ?? '';

try {
    if ($action === 'list') {
        $sql = "SELECT *, DATEDIFF(due_date, CURDATE()) AS days_left FROM equipments ORDER BY due_date ASC, id ASC";
        $rows = $pdo->query($sql)->fetchAll();
        echo json_encode([
            'success' => true,
            'data' => $rows,
            'reminder_days' => REMINDER_DAYS
        ]);
    } elseif ($action === 'upload_sync') {
        $input = json_decode(file_get_contents('php://input'), true);

        // ======================================================================
        // VALIDASI PASSWORD UPLOAD
        // ======================================================================
        $inputPassword = trim((string)($input['password'] ?? ''));
        $adminPassword = 'SeidMail01@@'; // <-- Ubah password sesuai keinginan Anda di sini

        if ($inputPassword !== $adminPassword) {
            throw new Exception("Password upload salah! Akses ditolak.");
        }

        if (!$input || !isset($input['items']) || !is_array($input['items']) || count($input['items']) === 0) {
            throw new Exception("Data Excel kosong atau format tidak valid. Pastikan data dimulai dari sel C17.");
        }

        $items = $input['items'];
        $validRows = [];

        foreach ($items as $row) {
            $controlNo = trim((string)($row['control_no'] ?? ''));
            $name      = trim((string)($row['name'] ?? ''));
            $calDate   = trim((string)($row['cal_date'] ?? ''));
            $dueDate   = trim((string)($row['due_date'] ?? ''));

            if ($controlNo === '' || stripos($controlNo, 'Note') === 0 || $name === '' || $calDate === '' || $dueDate === '') {
                continue;
            }

            if (!preg_match('/^\d{4}-\d{2}-\d{2}$/', $calDate) || !preg_match('/^\d{4}-\d{2}-\d{2}$/', $dueDate)) {
                throw new Exception("Format tanggal tidak valid pada Control No '{$controlNo}' (Cal: {$calDate}, Due: {$dueDate}).");
            }

            $validRows[] = [
                'control_no'        => $controlNo,
                'name'              => $name,
                'location'          => trim((string)($row['location'] ?? '')),
                'function_desc'     => trim((string)($row['function_desc'] ?? '')),
                'brand'             => trim((string)($row['brand'] ?? '')),
                'type_model'        => trim((string)($row['type_model'] ?? '')),
                'serial_no'         => trim((string)($row['serial_no'] ?? '')),
                'cal_date'          => $calDate,
                'due_date'          => $dueDate,
                'cal_by'            => trim((string)($row['cal_by'] ?? '')),
                'cal_decision'      => trim((string)($row['cal_decision'] ?? 'OK')) ?: 'OK',
                'certificate'       => trim((string)($row['certificate'] ?? '')),
                'loc_cal'           => trim((string)($row['loc_cal'] ?? '')),
                'certification_url' => trim((string)($row['certification_url'] ?? '')),
            ];
        }

        if (count($validRows) === 0) {
            throw new Exception("Tidak ditemukan baris equipment yang valid (wajib memiliki Control No, Name, Cal. Date, dan Due Date).");
        }

        $pdo->exec("SET FOREIGN_KEY_CHECKS = 0");
        $pdo->exec("TRUNCATE TABLE reminder_logs");
        $pdo->exec("TRUNCATE TABLE equipments");
        $pdo->exec("SET FOREIGN_KEY_CHECKS = 1");

        $sql = "INSERT INTO equipments (
                    control_no, name, location, function_desc, brand, type_model,
                    serial_no, cal_date, due_date, cal_by, cal_decision,
                    certificate, loc_cal, certification_url
                ) VALUES (
                    :control_no, :name, :location, :function_desc, :brand, :type_model,
                    :serial_no, :cal_date, :due_date, :cal_by, :cal_decision,
                    :certificate, :loc_cal, :certification_url
                )";
        $stmt = $pdo->prepare($sql);

        $pdo->beginTransaction();
        try {
            $inserted = 0;
            foreach ($validRows as $r) {
                $stmt->execute([
                    ':control_no'        => $r['control_no'],
                    ':name'              => $r['name'],
                    ':location'          => $r['location'] !== '' ? $r['location'] : null,
                    ':function_desc'     => $r['function_desc'] !== '' ? $r['function_desc'] : null,
                    ':brand'             => $r['brand'] !== '' ? $r['brand'] : null,
                    ':type_model'        => $r['type_model'] !== '' ? $r['type_model'] : null,
                    ':serial_no'         => $r['serial_no'] !== '' ? $r['serial_no'] : null,
                    ':cal_date'          => $r['cal_date'],
                    ':due_date'          => $r['due_date'],
                    ':cal_by'            => $r['cal_by'] !== '' ? $r['cal_by'] : null,
                    ':cal_decision'      => $r['cal_decision'],
                    ':certificate'       => $r['certificate'] !== '' ? $r['certificate'] : null,
                    ':loc_cal'           => $r['loc_cal'] !== '' ? $r['loc_cal'] : null,
                    ':certification_url' => $r['certification_url'] !== '' ? $r['certification_url'] : null,
                ]);
                $inserted++;
            }
            $pdo->commit();
        } catch (Exception $ex) {
            if ($pdo->inTransaction()) $pdo->rollBack();
            throw $ex;
        }

        echo json_encode([
            'success' => true,
            'inserted' => $inserted,
            'message' => "Berhasil mengganti database dengan {$inserted} data equipment terbaru dari Excel!"
        ]);
    } elseif ($action === 'save') {
        $input = json_decode(file_get_contents('php://input'), true);
        if (!$input || empty($input['control_no']) || empty($input['name']) || empty($input['cal_date']) || empty($input['due_date'])) {
            throw new Exception("Control No, Name, Cal. Date, dan Due Date wajib diisi.");
        }

        $id = !empty($input['id']) ? (int)$input['id'] : null;

        if ($id) {
            $sql = "UPDATE equipments SET
                        control_no = :control_no, name = :name, location = :location, function_desc = :function_desc,
                        brand = :brand, type_model = :type_model, serial_no = :serial_no, cal_date = :cal_date,
                        due_date = :due_date, cal_by = :cal_by, cal_decision = :cal_decision, certificate = :certificate,
                        loc_cal = :loc_cal, certification_url = :certification_url
                    WHERE id = :id";
            $stmt = $pdo->prepare($sql);
            $stmt->execute([
                ':control_no'        => trim($input['control_no']),
                ':name'              => trim($input['name']),
                ':location'          => trim($input['location'] ?? ''),
                ':function_desc'     => trim($input['function_desc'] ?? ''),
                ':brand'             => trim($input['brand'] ?? ''),
                ':type_model'        => trim($input['type_model'] ?? ''),
                ':serial_no'         => trim($input['serial_no'] ?? ''),
                ':cal_date'          => $input['cal_date'],
                ':due_date'          => $input['due_date'],
                ':cal_by'            => trim($input['cal_by'] ?? ''),
                ':cal_decision'      => trim($input['cal_decision'] ?? 'OK'),
                ':certificate'       => trim($input['certificate'] ?? ''),
                ':loc_cal'           => trim($input['loc_cal'] ?? ''),
                ':certification_url' => trim($input['certification_url'] ?? ''),
                ':id'                => $id
            ]);
            echo json_encode(['success' => true, 'message' => 'Data equipment berhasil diperbarui.']);
        } else {
            $sql = "INSERT INTO equipments (
                        control_no, name, location, function_desc, brand, type_model,
                        serial_no, cal_date, due_date, cal_by, cal_decision,
                        certificate, loc_cal, certification_url
                    ) VALUES (
                        :control_no, :name, :location, :function_desc, :brand, :type_model,
                        :serial_no, :cal_date, :due_date, :cal_by, :cal_decision,
                        :certificate, :loc_cal, :certification_url
                    )";
            $stmt = $pdo->prepare($sql);
            $stmt->execute([
                ':control_no'        => trim($input['control_no']),
                ':name'              => trim($input['name']),
                ':location'          => trim($input['location'] ?? ''),
                ':function_desc'     => trim($input['function_desc'] ?? ''),
                ':brand'             => trim($input['brand'] ?? ''),
                ':type_model'        => trim($input['type_model'] ?? ''),
                ':serial_no'         => trim($input['serial_no'] ?? ''),
                ':cal_date'          => $input['cal_date'],
                ':due_date'          => $input['due_date'],
                ':cal_by'            => trim($input['cal_by'] ?? ''),
                ':cal_decision'      => trim($input['cal_decision'] ?? 'OK'),
                ':certificate'       => trim($input['certificate'] ?? ''),
                ':loc_cal'           => trim($input['loc_cal'] ?? ''),
                ':certification_url' => trim($input['certification_url'] ?? '')
            ]);
            echo json_encode(['success' => true, 'message' => 'Equipment baru berhasil ditambahkan.']);
        }
    } elseif ($action === 'delete') {
        $id = (int)($_GET['id'] ?? 0);
        $stmt = $pdo->prepare("DELETE FROM equipments WHERE id = ?");
        $stmt->execute([$id]);
        echo json_encode(['success' => true, 'message' => 'Data equipment dihapus.']);
    } else {
        throw new Exception("Action tidak dikenali.");
    }
} catch (Exception $e) {
    http_response_code(400);
    echo json_encode(['success' => false, 'message' => $e->getMessage()]);
}
