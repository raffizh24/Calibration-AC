<?php require_once __DIR__ . '/config.php'; ?>
<!DOCTYPE html>
<html lang="id">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Calibration Due Date Reminder & Excel Sync - AC PE</title>
    <script src="https://cdn.tailwindcss.com"></script>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.1/css/all.min.css">
    <!-- SheetJS untuk membaca langsung file Excel (.xlsx / .xls) di browser dengan akurat -->
    <script src="https://cdn.sheetjs.com/xlsx-0.20.2/package/dist/xlsx.full.min.js"></script>
    <style>
        body {
            font-family: 'Inter', system-ui, -apple-system, sans-serif;
        }

        .table-container {
            max-height: calc(100vh - 360px);
            min-height: 360px;
            overflow: auto;
        }

        thead th {
            position: sticky;
            top: 0;
            z-index: 10;
        }

        .drop-active {
            border-color: #2563eb !important;
            background-color: #eff6ff !important;
        }
    </style>
</head>

<body class="bg-slate-100 text-slate-800">

    <!-- Top Navbar (Full Width) -->
    <header class="bg-slate-900 text-white shadow-md">
        <div class="w-full px-4 sm:px-6 py-3.5 flex flex-wrap items-center justify-between gap-4">
            <div class="flex items-center gap-3">
                <div class="bg-red-600 text-white font-bold px-3 py-1.5 rounded text-sm tracking-wider">SHARP</div>
                <div>
                    <h1 class="text-base sm:text-lg font-bold leading-tight">Equipment Calibration Reminder & Database Sync</h1>
                    <p class="text-xs text-slate-400">AC Production Engineering (PE) &bull; Target Notifikasi PC &amp; Web: <span class="text-amber-400 font-semibold">H-90 Hari (3 Bulan)</span></p>
                </div>
            </div>
            <div class="flex items-center gap-2">
                <button onclick="toggleUploadPanel()" id="btnToggleUpload" class="bg-emerald-600 hover:bg-emerald-500 text-white text-xs font-semibold px-3.5 py-2 rounded-lg shadow flex items-center gap-2 transition">
                    <i class="fa-solid fa-file-excel"></i> Upload &amp; Update Excel
                </button>
            </div>
        </div>
    </header>

    <main class="w-full px-4 sm:px-6 py-5 space-y-5">

        <!-- PANEL UPLOAD EXCEL (DEFAULT COLLAPSE / TERSEMBUNYI) -->
        <section id="uploadSection" class="bg-white rounded-xl shadow-sm border border-slate-200 overflow-hidden">
            <div class="bg-slate-800 text-white px-4 py-2.5 flex items-center justify-between">
                <div class="flex items-center gap-2 text-xs font-bold uppercase tracking-wider">
                    <i class="fa-solid fa-cloud-arrow-up text-emerald-400"></i>
                    <span>Upload File Excel Equipment List (Hapus Data Lama &rarr; Insert Data Baru)</span>
                </div>
                <button onclick="toggleUploadPanel()" class="text-slate-400 hover:text-white text-xs">
                    <!-- Ikon diubah ke chevron-down secara default karena tertutup -->
                    <i class="fa-solid fa-chevron-down" id="uploadChevron"></i>
                </button>
            </div>

            <div id="uploadBody" class="hidden p-4">
                <div class="grid grid-cols-1 lg:grid-cols-12 gap-4 items-center">
                    <!-- Dropzone -->
                    <div class="lg:col-span-7">
                        <div id="dropZone" onclick="document.getElementById('excelFileInput').click()"
                            ondragover="handleDragOver(event)" ondragleave="handleDragLeave(event)" ondrop="handleDrop(event)"
                            class="border-2 border-dashed border-slate-300 hover:border-blue-500 rounded-xl p-5 text-center cursor-pointer transition bg-slate-50/70">
                            <input type="file" id="excelFileInput" accept=".xlsx,.xls,.csv" class="hidden" onchange="handleFileSelect(event)">
                            <div class="flex flex-col sm:flex-row items-center justify-center gap-3">
                                <div class="w-11 h-11 rounded-full bg-emerald-100 text-emerald-700 flex items-center justify-center text-xl shrink-0">
                                    <i class="fa-solid fa-file-excel"></i>
                                </div>
                                <div class="text-left">
                                    <p class="text-sm font-bold text-slate-800" id="selectedFileName">Klik untuk pilih file Excel (.xlsx / .xls) atau seret ke sini</p>
                                    <p class="text-xs text-slate-500 mt-0.5">Otomatis membaca struktur template pabrik mulai baris <strong>C17</strong> (Control No. s/d Certification Link).</p>
                                </div>
                            </div>
                        </div>
                    </div>

                    <!-- Preview & Action Box -->
                    <div class="lg:col-span-5 bg-slate-50 border border-slate-200 rounded-xl p-4 space-y-3">
                        <div class="flex items-center justify-between text-xs">
                            <span class="text-slate-600 font-medium">Status File:</span>
                            <span id="parseStatusBadge" class="px-2 py-0.5 rounded bg-slate-200 text-slate-700 font-semibold">Belum ada file dipilih</span>
                        </div>
                        <div id="previewInfoBox" class="hidden text-xs text-slate-600 bg-white p-2.5 rounded border border-slate-200 space-y-1">
                            <div>Sheet terbaca: <strong id="prevSheetName" class="text-slate-800">-</strong></div>
                            <div>Total baris valid siap import: <strong id="prevValidCount" class="text-emerald-600 text-sm">0</strong> unit</div>
                            <div class="text-[11px] text-amber-700"><i class="fa-solid fa-triangle-exclamation"></i> Data lama di database akan dihapus &amp; diganti seluruhnya dengan data baru ini.</div>
                        </div>

                        <!-- Input Password Upload -->
                        <div class="hidden" id="uploadPasswordContainer">
                            <label class="block text-[11px] font-semibold text-slate-700 mb-1">Masukkan Password Upload:</label>
                            <input type="password" id="excelUploadPassword" placeholder="Password admin..." class="w-full text-xs border border-slate-300 rounded px-2.5 py-1.5 focus:outline-none focus:ring-2 focus:ring-emerald-500">
                        </div>

                        <div class="flex items-center gap-2">
                            <button id="btnSyncDb" onclick="confirmAndUploadSync()" disabled
                                class="flex-1 bg-emerald-600 disabled:bg-slate-300 disabled:cursor-not-allowed hover:bg-emerald-500 text-white text-xs font-bold py-2.5 px-4 rounded-lg shadow transition flex items-center justify-center gap-2">
                                <i class="fa-solid fa-database"></i> Ganti Data Lama &amp; Simpan ke Database
                            </button>
                            <button id="btnResetUpload" onclick="resetUploadState()" class="hidden bg-slate-200 hover:bg-slate-300 text-slate-700 text-xs font-semibold py-2.5 px-3 rounded-lg">
                                Batal
                            </button>
                        </div>
                    </div>
                </div>
            </div>
        </section>

        <!-- KPI CARDS -->
        <div class="grid grid-cols-2 lg:grid-cols-4 gap-4">
            <div onclick="setStatusFilter('ALL')" class="cursor-pointer bg-white p-4 rounded-xl shadow-sm border-l-4 border-slate-700 hover:shadow transition">
                <div class="flex justify-between items-center">
                    <div>
                        <p class="text-xs font-semibold text-slate-500 uppercase">Total Equipment</p>
                        <p id="statTotal" class="text-2xl font-bold text-slate-800 mt-1">0</p>
                    </div>
                    <div class="w-10 h-10 rounded-lg bg-slate-100 flex items-center justify-center text-slate-700">
                        <i class="fa-solid fa-microscope text-lg"></i>
                    </div>
                </div>
            </div>

            <div onclick="setStatusFilter('OVERDUE')" class="cursor-pointer bg-white p-4 rounded-xl shadow-sm border-l-4 border-red-600 hover:shadow transition">
                <div class="flex justify-between items-center">
                    <div>
                        <p class="text-xs font-semibold text-red-600 uppercase">Overdue (Lewat Due Date)</p>
                        <p id="statOverdue" class="text-2xl font-bold text-red-600 mt-1">0</p>
                    </div>
                    <div class="w-10 h-10 rounded-lg bg-red-50 flex items-center justify-center text-red-600">
                        <i class="fa-solid fa-triangle-exclamation text-lg"></i>
                    </div>
                </div>
            </div>

            <div onclick="setStatusFilter('WARNING')" class="cursor-pointer bg-white p-4 rounded-xl shadow-sm border-l-4 border-amber-500 hover:shadow transition">
                <div class="flex justify-between items-center">
                    <div>
                        <p class="text-xs font-semibold text-amber-600 uppercase">Warning (&le; 90 Hari)</p>
                        <p id="statWarning" class="text-2xl font-bold text-amber-600 mt-1">0</p>
                    </div>
                    <div class="w-10 h-10 rounded-lg bg-amber-50 flex items-center justify-center text-amber-600">
                        <i class="fa-solid fa-bell text-lg"></i>
                    </div>
                </div>
            </div>

            <div onclick="setStatusFilter('SAFE')" class="cursor-pointer bg-white p-4 rounded-xl shadow-sm border-l-4 border-emerald-600 hover:shadow transition">
                <div class="flex justify-between items-center">
                    <div>
                        <p class="text-xs font-semibold text-emerald-600 uppercase">Aman (&gt; 90 Hari)</p>
                        <p id="statSafe" class="text-2xl font-bold text-emerald-600 mt-1">0</p>
                    </div>
                    <div class="w-10 h-10 rounded-lg bg-emerald-50 flex items-center justify-center text-emerald-600">
                        <i class="fa-solid fa-circle-check text-lg"></i>
                    </div>
                </div>
            </div>
        </div>

        <!-- FILTER & SEARCH BAR -->
        <div class="bg-white p-3.5 rounded-xl shadow-sm flex flex-wrap items-center justify-between gap-3">
            <div class="flex flex-wrap items-center gap-3 flex-1">
                <div class="relative flex-1 min-w-[230px] max-w-md">
                    <i class="fa-solid fa-magnifying-glass absolute left-3 top-2.5 text-slate-400 text-sm"></i>
                    <input type="text" id="searchInput" onkeyup="renderTable()" placeholder="Cari Control No, Nama, Brand, Serial No..." class="w-full pl-9 pr-3 py-1.5 text-sm border border-slate-300 rounded-lg focus:outline-none focus:ring-2 focus:ring-blue-500">
                </div>
                <select id="locationFilter" onchange="renderTable()" class="text-sm border border-slate-300 rounded-lg px-3 py-1.5 bg-white focus:outline-none focus:ring-2 focus:ring-blue-500">
                    <option value="ALL">Semua Location</option>
                </select>
                <select id="statusFilter" onchange="renderTable()" class="text-sm border border-slate-300 rounded-lg px-3 py-1.5 bg-white focus:outline-none focus:ring-2 focus:ring-blue-500">
                    <option value="ALL">Semua Status Reminder</option>
                    <option value="OVERDUE">Overdue (&lt; 0 Hari)</option>
                    <option value="WARNING">Warning H-90 Hari (0 - 90 Hari)</option>
                    <option value="SAFE">Aman (&gt; 90 Hari)</option>
                </select>
            </div>
            <div class="text-xs text-slate-500">
                Menampilkan <span id="showingCount" class="font-bold text-slate-800">0</span> equipment
            </div>
        </div>

        <!-- DATA TABLE -->
        <div class="bg-white rounded-xl shadow-sm overflow-hidden border border-slate-200">
            <div class="table-container">
                <table class="w-full text-left border-collapse text-xs">
                    <thead>
                        <tr class="bg-slate-800 text-white uppercase tracking-wider text-[11px]">
                            <th class="py-3 px-3">Control No.</th>
                            <th class="py-3 px-3">Name &amp; Function</th>
                            <th class="py-3 px-3">Loc</th>
                            <th class="py-3 px-3">Brand / Type</th>
                            <th class="py-3 px-3">Serial No</th>
                            <th class="py-3 px-3 text-center">Cal. Date</th>
                            <th class="py-3 px-3 text-center">Due Date</th>
                            <th class="py-3 px-3 text-center">Status Reminder</th>
                            <th class="py-3 px-3">Cal. By / LOC</th>
                            <th class="py-3 px-3 text-center">Cert</th>
                            <th class="py-3 px-3 text-center">Aksi</th>
                        </tr>
                    </thead>
                    <tbody id="tableBody" class="divide-y divide-slate-200">
                        <tr>
                            <td colspan="11" class="text-center py-8 text-slate-400">Memuat data equipment...</td>
                        </tr>
                    </tbody>
                </table>
            </div>
        </div>
    </main>

    <!-- Modal Add / Edit Satuan -->
    <div id="formModal" class="fixed inset-0 bg-black/50 hidden items-center justify-center z-50 p-4">
        <div class="bg-white rounded-xl shadow-xl max-w-2xl w-full overflow-hidden">
            <div class="bg-slate-900 text-white px-5 py-3.5 flex justify-between items-center">
                <h3 id="modalTitle" class="font-bold text-sm">Tambah / Edit Equipment</h3>
                <button onclick="closeFormModal()" class="text-slate-400 hover:text-white"><i class="fa-solid fa-xmark text-lg"></i></button>
            </div>
            <form id="equipForm" onsubmit="saveEquipment(event)" class="p-5 space-y-3 text-xs max-h-[80vh] overflow-y-auto">
                <input type="hidden" id="eq_id">
                <div class="grid grid-cols-1 sm:grid-cols-3 gap-3">
                    <div>
                        <label class="block font-semibold text-slate-700 mb-1">Control No. *</label>
                        <input type="text" id="eq_control_no" required class="w-full border border-slate-300 rounded px-2.5 py-1.5">
                    </div>
                    <div class="sm:col-span-2">
                        <label class="block font-semibold text-slate-700 mb-1">Equipment Name *</label>
                        <input type="text" id="eq_name" required class="w-full border border-slate-300 rounded px-2.5 py-1.5">
                    </div>
                </div>
                <div class="grid grid-cols-1 sm:grid-cols-3 gap-3">
                    <div>
                        <label class="block font-semibold text-slate-700 mb-1">Location</label>
                        <input type="text" id="eq_location" class="w-full border border-slate-300 rounded px-2.5 py-1.5">
                    </div>
                    <div class="sm:col-span-2">
                        <label class="block font-semibold text-slate-700 mb-1">Function</label>
                        <input type="text" id="eq_function_desc" class="w-full border border-slate-300 rounded px-2.5 py-1.5">
                    </div>
                </div>
                <div class="grid grid-cols-1 sm:grid-cols-3 gap-3">
                    <div>
                        <label class="block font-semibold text-slate-700 mb-1">Brand</label>
                        <input type="text" id="eq_brand" class="w-full border border-slate-300 rounded px-2.5 py-1.5">
                    </div>
                    <div>
                        <label class="block font-semibold text-slate-700 mb-1">Type / Model</label>
                        <input type="text" id="eq_type_model" class="w-full border border-slate-300 rounded px-2.5 py-1.5">
                    </div>
                    <div>
                        <label class="block font-semibold text-slate-700 mb-1">Serial No</label>
                        <input type="text" id="eq_serial_no" class="w-full border border-slate-300 rounded px-2.5 py-1.5">
                    </div>
                </div>
                <div class="grid grid-cols-1 sm:grid-cols-3 gap-3">
                    <div>
                        <label class="block font-semibold text-slate-700 mb-1">Cal. Date *</label>
                        <input type="date" id="eq_cal_date" required class="w-full border border-slate-300 rounded px-2.5 py-1.5">
                    </div>
                    <div>
                        <label class="block font-semibold text-slate-700 mb-1">Due Date *</label>
                        <input type="date" id="eq_due_date" required class="w-full border border-slate-300 rounded px-2.5 py-1.5">
                    </div>
                    <div>
                        <label class="block font-semibold text-slate-700 mb-1">Cal. By (Vendor/Internal)</label>
                        <input type="text" id="eq_cal_by" class="w-full border border-slate-300 rounded px-2.5 py-1.5">
                    </div>
                </div>
                <div class="grid grid-cols-1 sm:grid-cols-3 gap-3">
                    <div>
                        <label class="block font-semibold text-slate-700 mb-1">Cal. Decision</label>
                        <input type="text" id="eq_cal_decision" value="OK" class="w-full border border-slate-300 rounded px-2.5 py-1.5">
                    </div>
                    <div>
                        <label class="block font-semibold text-slate-700 mb-1">Certificate (KAN / NON KAN)</label>
                        <input type="text" id="eq_certificate" class="w-full border border-slate-300 rounded px-2.5 py-1.5">
                    </div>
                    <div>
                        <label class="block font-semibold text-slate-700 mb-1">LOC Cal. (ONSITE / INLAB)</label>
                        <input type="text" id="eq_loc_cal" class="w-full border border-slate-300 rounded px-2.5 py-1.5">
                    </div>
                </div>
                <div>
                    <label class="block font-semibold text-slate-700 mb-1">Certification Link (Google Drive URL)</label>
                    <input type="url" id="eq_certification_url" placeholder="https://drive.google.com/..." class="w-full border border-slate-300 rounded px-2.5 py-1.5">
                </div>
                <div class="flex justify-end gap-2 pt-3 border-t border-slate-200">
                    <button type="button" onclick="closeFormModal()" class="px-4 py-2 rounded-lg bg-slate-200 hover:bg-slate-300 font-semibold">Batal</button>
                    <button type="submit" class="px-4 py-2 rounded-lg bg-blue-600 hover:bg-blue-500 text-white font-semibold">Simpan Data</button>
                </div>
            </form>
        </div>
    </div>

    <script>
        let allData = [];
        let parsedExcelItems = [];

        function toggleUploadPanel() {
            const body = document.getElementById('uploadBody');
            const icon = document.getElementById('uploadChevron');
            body.classList.toggle('hidden');
            icon.classList.toggle('fa-chevron-up');
            icon.classList.toggle('fa-chevron-down');
        }

        // Drag & Drop Handlers
        function handleDragOver(e) {
            e.preventDefault();
            document.getElementById('dropZone').classList.add('drop-active');
        }

        function handleDragLeave(e) {
            e.preventDefault();
            document.getElementById('dropZone').classList.remove('drop-active');
        }

        function handleDrop(e) {
            e.preventDefault();
            document.getElementById('dropZone').classList.remove('drop-active');
            if (e.dataTransfer.files && e.dataTransfer.files.length > 0) {
                processExcelFile(e.dataTransfer.files[0]);
            }
        }

        function handleFileSelect(e) {
            if (e.target.files && e.target.files.length > 0) {
                processExcelFile(e.target.files[0]);
            }
        }

        // Konversi serial tanggal Excel atau string tanggal ke YYYY-MM-DD
        function formatExcelDate(val) {
            if (val === null || val === undefined || val === '') return '';
            if (typeof val === 'number') {
                const parsed = XLSX.SSF.parse_date_code(val);
                if (parsed) {
                    const y = String(parsed.y).padStart(4, '0');
                    const m = String(parsed.m).padStart(2, '0');
                    const d = String(parsed.d).padStart(2, '0');
                    return `${y}-${m}-${d}`;
                }
            }
            if (val instanceof Date && !isNaN(val)) {
                const y = val.getFullYear();
                const m = String(val.getMonth() + 1).padStart(2, '0');
                const d = String(val.getDate()).padStart(2, '0');
                return `${y}-${m}-${d}`;
            }
            const str = String(val).trim();
            if (/^\d{4}-\d{2}-\d{2}/.test(str)) {
                return str.substring(0, 10);
            }
            const m1 = str.match(/^(\d{1,2})[\/\-](\d{1,2})[\/\-](\d{4})$/);
            if (m1) {
                return `${m1[3]}-${m1[2].padStart(2, '0')}-${m1[1].padStart(2, '0')}`;
            }
            return '';
        }

        function processExcelFile(file) {
            document.getElementById('selectedFileName').textContent = file.name;
            const badge = document.getElementById('parseStatusBadge');
            badge.className = 'px-2 py-0.5 rounded bg-blue-100 text-blue-700 font-semibold';
            badge.textContent = 'Membaca file...';

            const reader = new FileReader();
            reader.onload = function(e) {
                try {
                    const data = new Uint8Array(e.target.result);
                    const workbook = XLSX.read(data, {
                        type: 'array',
                        cellDates: true
                    });
                    const sheetName = workbook.SheetNames.includes('Equipment List') ? 'Equipment List' : workbook.SheetNames[0];
                    const sheet = workbook.Sheets[sheetName];

                    const rows = XLSX.utils.sheet_to_json(sheet, {
                        header: 1,
                        defval: ''
                    });

                    let startRowIdx = 16;
                    let colMap = {
                        control_no: 2,
                        name: 3,
                        location: 4,
                        function_desc: 5,
                        brand: 6,
                        type_model: 7,
                        serial_no: 8,
                        cal_date: 14,
                        due_date: 15,
                        cal_by: 16,
                        cal_decision: 17,
                        certificate: 18,
                        loc_cal: 19,
                        certification_url: 20
                    };

                    for (let r = 0; r < Math.min(rows.length, 25); r++) {
                        const rowArr = rows[r].map(c => String(c).trim().toLowerCase());
                        const cIdx = rowArr.findIndex(c => c === 'control no.' || c === 'control no');
                        if (cIdx !== -1) {
                            startRowIdx = r + 1;
                            colMap.control_no = cIdx;
                            const findCol = (keywords, fallback) => {
                                const found = rowArr.findIndex(c => keywords.some(k => c === k));
                                return found !== -1 ? found : fallback;
                            };
                            colMap.name = findCol(['name', 'equipment name'], cIdx + 1);
                            colMap.location = findCol(['location'], cIdx + 2);
                            colMap.function_desc = findCol(['function'], cIdx + 3);
                            colMap.brand = findCol(['brand'], cIdx + 4);
                            colMap.type_model = findCol(['type', 'type/model'], cIdx + 5);
                            colMap.serial_no = findCol(['serial no', 'serial no.'], cIdx + 6);
                            colMap.cal_date = findCol(['cal. date', 'cal date'], 14);
                            colMap.due_date = findCol(['due date'], 15);
                            colMap.cal_by = findCol(['cal. by', 'cal by'], 16);
                            colMap.cal_decision = findCol(['cal. decision', 'cal decision'], 17);
                            colMap.certificate = findCol(['certificate'], 18);
                            colMap.loc_cal = findCol(['loc cal.', 'loc cal'], 19);
                            colMap.certification_url = findCol(['certification', 'certification link'], 20);
                            break;
                        }
                    }

                    const extracted = [];
                    for (let r = startRowIdx; r < rows.length; r++) {
                        const row = rows[r];
                        if (!row || row.length === 0) continue;

                        const ctrl = String(row[colMap.control_no] ?? '').trim();
                        const name = String(row[colMap.name] ?? '').trim();
                        const calD = formatExcelDate(row[colMap.cal_date]);
                        const dueD = formatExcelDate(row[colMap.due_date]);

                        if (!ctrl || ctrl.toLowerCase().startsWith('note') || !name || !calD || !dueD) {
                            continue;
                        }

                        extracted.push({
                            control_no: ctrl,
                            name: name,
                            location: String(row[colMap.location] ?? '').trim(),
                            function_desc: String(row[colMap.function_desc] ?? '').trim(),
                            brand: String(row[colMap.brand] ?? '').trim(),
                            type_model: String(row[colMap.type_model] ?? '').trim(),
                            serial_no: String(row[colMap.serial_no] ?? '').trim(),
                            cal_date: calD,
                            due_date: dueD,
                            cal_by: String(row[colMap.cal_by] ?? '').trim(),
                            cal_decision: String(row[colMap.cal_decision] ?? '').trim() || 'OK',
                            certificate: String(row[colMap.certificate] ?? '').trim(),
                            loc_cal: String(row[colMap.loc_cal] ?? '').trim(),
                            certification_url: String(row[colMap.certification_url] ?? '').trim()
                        });
                    }

                    if (extracted.length === 0) {
                        throw new Error("Tidak ada data valid yang terbaca. Pastikan kolom Control No., Name, Cal. Date, dan Due Date terisi.");
                    }

                    parsedExcelItems = extracted;
                    badge.className = 'px-2 py-0.5 rounded bg-emerald-100 text-emerald-700 font-semibold';
                    badge.textContent = 'Siap Di-import';
                    document.getElementById('prevSheetName').textContent = sheetName;
                    document.getElementById('prevValidCount').textContent = extracted.length;
                    document.getElementById('previewInfoBox').classList.remove('hidden');
                    document.getElementById('uploadPasswordContainer').classList.remove('hidden');
                    document.getElementById('btnSyncDb').disabled = false;
                    document.getElementById('btnResetUpload').classList.remove('hidden');

                } catch (err) {
                    parsedExcelItems = [];
                    badge.className = 'px-2 py-0.5 rounded bg-red-100 text-red-700 font-semibold';
                    badge.textContent = 'Gagal Membaca';
                    document.getElementById('previewInfoBox').classList.add('hidden');
                    document.getElementById('uploadPasswordContainer').classList.add('hidden');
                    document.getElementById('btnSyncDb').disabled = true;
                    alert("Error membaca Excel: " + err.message);
                }
            };
            reader.readAsArrayBuffer(file);
        }

        function resetUploadState() {
            parsedExcelItems = [];
            document.getElementById('excelFileInput').value = '';
            document.getElementById('excelUploadPassword').value = '';
            document.getElementById('selectedFileName').textContent = 'Klik untuk pilih file Excel (.xlsx / .xls) atau seret ke sini';
            document.getElementById('parseStatusBadge').className = 'px-2 py-0.5 rounded bg-slate-200 text-slate-700 font-semibold';
            document.getElementById('parseStatusBadge').textContent = 'Belum ada file dipilih';
            document.getElementById('previewInfoBox').classList.add('hidden');
            document.getElementById('uploadPasswordContainer').classList.add('hidden');
            document.getElementById('btnSyncDb').disabled = true;
            document.getElementById('btnResetUpload').classList.add('hidden');
        }

        async function confirmAndUploadSync() {
            if (parsedExcelItems.length === 0) return;

            const passwordVal = document.getElementById('excelUploadPassword').value;
            if (!passwordVal) {
                alert('Mohon masukkan password upload terlebih dahulu.');
                document.getElementById('excelUploadPassword').focus();
                return;
            }

            const ok = confirm(
                `KONFIRMASI UPDATE DATABASE:\n\n` +
                `• Seluruh data equipment lama akan DIHAPUS.\n` +
                `• Akan diganti dengan ${parsedExcelItems.length} data equipment baru dari file Excel.\n\n` +
                `Lanjutkan proses ini?`
            );
            if (!ok) return;

            const btn = document.getElementById('btnSyncDb');
            btn.disabled = true;
            btn.innerHTML = '<i class="fa-solid fa-spinner fa-spin"></i> Memverifikasi & Menyimpan...';

            try {
                const res = await fetch('api.php?action=upload_sync', {
                    method: 'POST',
                    headers: {
                        'Content-Type': 'application/json'
                    },
                    body: JSON.stringify({
                        items: parsedExcelItems,
                        password: passwordVal
                    })
                });
                const json = await res.json();
                if (json.success) {
                    alert(json.message);
                    resetUploadState();
                    loadData();
                } else {
                    alert('Gagal: ' + json.message);
                    btn.disabled = false;
                }
            } catch (err) {
                alert('Terjadi kesalahan koneksi ke server.');
                btn.disabled = false;
            } finally {
                btn.innerHTML = '<i class="fa-solid fa-database"></i> Ganti Data Lama &amp; Simpan ke Database';
            }
        }

        // ==============================================================================
        // LOAD & RENDER DATA TABLE
        // ==============================================================================
        async function loadData() {
            const res = await fetch('api.php?action=list');
            const json = await res.json();
            if (!json.success) {
                alert('Gagal memuat data: ' + json.message);
                return;
            }
            allData = json.data;
            populateLocationDropdown();
            updateStats();
            renderTable();
        }

        function populateLocationDropdown() {
            const sel = document.getElementById('locationFilter');
            const current = sel.value;
            const locs = [...new Set(allData.map(x => x.location).filter(Boolean))].sort();
            sel.innerHTML = '<option value="ALL">Semua Location</option>' + locs.map(l => `<option value="${l}">${l}</option>`).join('');
            if (locs.includes(current)) sel.value = current;
        }

        function updateStats() {
            let overdue = 0,
                warning = 0,
                safe = 0;
            allData.forEach(item => {
                const d = parseInt(item.days_left, 10);
                if (d < 0) overdue++;
                else if (d <= 90) warning++;
                else safe++;
            });
            document.getElementById('statTotal').textContent = allData.length;
            document.getElementById('statOverdue').textContent = overdue;
            document.getElementById('statWarning').textContent = warning;
            document.getElementById('statSafe').textContent = safe;
        }

        function setStatusFilter(val) {
            document.getElementById('statusFilter').value = val;
            renderTable();
        }

        function renderTable() {
            const q = document.getElementById('searchInput').value.toLowerCase();
            const loc = document.getElementById('locationFilter').value;
            const st = document.getElementById('statusFilter').value;

            const filtered = allData.filter(item => {
                const d = parseInt(item.days_left, 10);
                if (st === 'OVERDUE' && d >= 0) return false;
                if (st === 'WARNING' && (d < 0 || d > 90)) return false;
                if (st === 'SAFE' && d <= 90) return false;
                if (loc !== 'ALL' && item.location !== loc) return false;
                if (q) {
                    const hay = `${item.control_no} ${item.name} ${item.function_desc} ${item.brand} ${item.type_model} ${item.serial_no} ${item.cal_by}`.toLowerCase();
                    if (!hay.includes(q)) return false;
                }
                return true;
            });

            document.getElementById('showingCount').textContent = filtered.length;
            const tbody = document.getElementById('tableBody');

            if (filtered.length === 0) {
                tbody.innerHTML = '<tr><td colspan="11" class="text-center py-8 text-slate-400">Tidak ada data equipment yang sesuai filter.</td></tr>';
                return;
            }

            tbody.innerHTML = filtered.map(item => {
                const d = parseInt(item.days_left, 10);
                let badge = '';
                let rowBg = 'hover:bg-slate-50';
                if (d < 0) {
                    badge = `<span class="px-2 py-0.5 rounded-full bg-red-100 text-red-700 font-bold">OVERDUE (${Math.abs(d)}h)</span>`;
                    rowBg = 'bg-red-50/40 hover:bg-red-50';
                } else if (d <= 90) {
                    badge = `<span class="px-2 py-0.5 rounded-full bg-amber-100 text-amber-800 font-bold">H-${d} Hari</span>`;
                    rowBg = 'bg-amber-50/40 hover:bg-amber-50';
                } else {
                    badge = `<span class="px-2 py-0.5 rounded-full bg-emerald-100 text-emerald-700 font-semibold">${d} Hari</span>`;
                }

                const certBtn = item.certification_url ?
                    `<a href="${item.certification_url}" target="_blank" class="text-blue-600 hover:underline font-semibold"><i class="fa-solid fa-file-pdf"></i> ${item.certificate || 'PDF'}</a>` :
                    `<span class="text-slate-400">${item.certificate || '-'}</span>`;

                return `
        <tr class="${rowBg}">
            <td class="py-2.5 px-3 font-bold text-slate-900 whitespace-nowrap">${item.control_no}</td>
            <td class="py-2.5 px-3">
                <div class="font-semibold text-slate-800">${item.name}</div>
                <div class="text-[11px] text-slate-500">${item.function_desc || ''}</div>
            </td>
            <td class="py-2.5 px-3"><span class="px-2 py-0.5 bg-slate-200 rounded font-medium">${item.location || '-'}</span></td>
            <td class="py-2.5 px-3">
                <div>${item.brand || '-'}</div>
                <div class="text-[11px] text-slate-500">${item.type_model || ''}</div>
            </td>
            <td class="py-2.5 px-3 font-mono text-[11px]">${item.serial_no || '-'}</td>
            <td class="py-2.5 px-3 text-center whitespace-nowrap">${item.cal_date}</td>
            <td class="py-2.5 px-3 text-center font-semibold whitespace-nowrap">${item.due_date}</td>
            <td class="py-2.5 px-3 text-center whitespace-nowrap">${badge}</td>
            <td class="py-2.5 px-3">
                <div>${item.cal_by || '-'}</div>
                <div class="text-[10px] text-slate-500">${item.loc_cal || ''} &bull; ${item.cal_decision || ''}</div>
            </td>
            <td class="py-2.5 px-3 text-center whitespace-nowrap">${certBtn}</td>
            <td class="py-2.5 px-3 text-center whitespace-nowrap">
                <button onclick='editItem(${JSON.stringify(item).replace(/'/g, "&#39;")})' class="text-blue-600 hover:text-blue-800 px-1.5" title="Edit"><i class="fa-solid fa-pen-to-square"></i></button>
                <button onclick="deleteItem(${item.id}, '${item.control_no}')" class="text-red-500 hover:text-red-700 px-1.5" title="Hapus"><i class="fa-solid fa-trash"></i></button>
            </td>
        </tr>`;
            }).join('');
        }

        function editItem(item) {
            document.getElementById('eq_id').value = item.id;
            document.getElementById('eq_control_no').value = item.control_no;
            document.getElementById('eq_name').value = item.name;
            document.getElementById('eq_location').value = item.location || '';
            document.getElementById('eq_function_desc').value = item.function_desc || '';
            document.getElementById('eq_brand').value = item.brand || '';
            document.getElementById('eq_type_model').value = item.type_model || '';
            document.getElementById('eq_serial_no').value = item.serial_no || '';
            document.getElementById('eq_cal_date').value = item.cal_date;
            document.getElementById('eq_due_date').value = item.due_date;
            document.getElementById('eq_cal_by').value = item.cal_by || '';
            document.getElementById('eq_cal_decision').value = item.cal_decision || 'OK';
            document.getElementById('eq_certificate').value = item.certificate || '';
            document.getElementById('eq_loc_cal').value = item.loc_cal || '';
            document.getElementById('eq_certification_url').value = item.certification_url || '';
            document.getElementById('modalTitle').textContent = 'Edit Equipment: ' + item.control_no;
            document.getElementById('formModal').classList.remove('hidden');
            document.getElementById('formModal').classList.add('flex');
        }

        function closeFormModal() {
            document.getElementById('formModal').classList.add('hidden');
            document.getElementById('formModal').classList.remove('flex');
        }

        async function saveEquipment(e) {
            e.preventDefault();
            const payload = {
                id: document.getElementById('eq_id').value,
                control_no: document.getElementById('eq_control_no').value,
                name: document.getElementById('eq_name').value,
                location: document.getElementById('eq_location').value,
                function_desc: document.getElementById('eq_function_desc').value,
                brand: document.getElementById('eq_brand').value,
                type_model: document.getElementById('eq_type_model').value,
                serial_no: document.getElementById('eq_serial_no').value,
                cal_date: document.getElementById('eq_cal_date').value,
                due_date: document.getElementById('eq_due_date').value,
                cal_by: document.getElementById('eq_cal_by').value,
                cal_decision: document.getElementById('eq_cal_decision').value,
                certificate: document.getElementById('eq_certificate').value,
                loc_cal: document.getElementById('eq_loc_cal').value,
                certification_url: document.getElementById('eq_certification_url').value
            };

            const res = await fetch('api.php?action=save', {
                method: 'POST',
                headers: {
                    'Content-Type': 'application/json'
                },
                body: JSON.stringify(payload)
            });
            const json = await res.json();
            if (json.success) {
                closeFormModal();
                loadData();
            } else {
                alert('Error: ' + json.message);
            }
        }

        async function deleteItem(id, controlNo) {
            if (!confirm(`Hapus equipment ${controlNo}?`)) return;
            const res = await fetch(`api.php?action=delete&id=${id}`);
            const json = await res.json();
            if (json.success) loadData();
            else alert('Error: ' + json.message);
        }

        loadData();
    </script>
</body>

</html>