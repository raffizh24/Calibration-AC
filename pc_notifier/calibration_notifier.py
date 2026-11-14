import sys
import time
import urllib.request
import json
import webbrowser
import tkinter as tk
from tkinter import ttk

# ==============================================================================
# KONFIGURASI APLIKASI PC NOTIFIER (WINDOWS STARTUP POPUP)
# ==============================================================================
API_URL = "http://localhost/calibration/api_reminder_check.php"
WEB_DASHBOARD_URL = "http://localhost/calibration/"
AUTO_CLOSE_SECONDS = 300      # 300 detik = 5 Menit tampil otomatis (atau tutup manual)
RETRY_ATTEMPTS = 8            # Coba ulang jika XAMPP/Apache baru menyala saat booting
RETRY_DELAY_SECONDS = 5       # Jeda antar percobaan koneksi (detik)
# ==============================================================================


def fetch_due_equipments():
    for attempt in range(RETRY_ATTEMPTS):
        try:
            req = urllib.request.Request(API_URL, headers={'User-Agent': 'CalibrationNotifier/2.0'})
            with urllib.request.urlopen(req, timeout=5) as response:
                raw = response.read().decode('utf-8')
                data = json.loads(raw)
                if data.get('success'):
                    return data
        except Exception:
            if attempt < RETRY_ATTEMPTS - 1:
                time.sleep(RETRY_DELAY_SECONDS)
    return None


def format_mm_ss(seconds):
    mins = seconds // 60
    secs = seconds % 60
    return f"{mins:02d}:{secs:02d}"


class CalibrationToastApp:
    def __init__(self, data):
        self.data = data
        self.remaining = AUTO_CLOSE_SECONDS
        self.paused = False

        self.root = tk.Tk()
        self.root.title("Calibration Due Date Reminder")
        self.root.overrideredirect(True)
        self.root.attributes("-topmost", True)
        self.root.configure(bg="#0f172a")

        win_w = 470
        win_h = 360
        screen_w = self.root.winfo_screenwidth()
        screen_h = self.root.winfo_screenheight()
        pos_x = screen_w - win_w - 20
        pos_y = screen_h - win_h - 60
        self.root.geometry(f"{win_w}x{win_h}+{pos_x}+{pos_y}")

        # Jeda countdown saat kursor berada di atas popup agar mudah dibaca/di-scroll
        self.root.bind("<Enter>", self.on_mouse_enter)
        self.root.bind("<Leave>", self.on_mouse_leave)

        self._build_ui()
        self._tick_timer()

    def _build_ui(self):
        outer = tk.Frame(self.root, bg="#334155", padx=1, pady=1)
        outer.pack(fill="both", expand=True)

        container = tk.Frame(outer, bg="#0f172a")
        container.pack(fill="both", expand=True)

        # Header
        header_bg = "#dc2626" if self.data['overdue_count'] > 0 else "#d97706"
        header = tk.Frame(container, bg=header_bg, pady=9, padx=12)
        header.pack(fill="x")

        tk.Label(
            header,
            text="REMINDER KALIBRASI EQUIPMENT (H-90 HARI)",
            font=("Segoe UI", 10, "bold"),
            fg="#ffffff",
            bg=header_bg
        ).pack(side="left")

        close_x = tk.Button(
            header,
            text=" X ",
            font=("Segoe UI", 9, "bold"),
            fg="#ffffff",
            bg=header_bg,
            activebackground="#991b1b",
            activeforeground="#ffffff",
            bd=0,
            cursor="hand2",
            command=self.root.destroy
        )
        close_x.pack(side="right")

        # Summary Bar
        summary_frame = tk.Frame(container, bg="#1e293b", padx=12, pady=8)
        summary_frame.pack(fill="x")

        total = self.data['total_due']
        overdue = self.data['overdue_count']
        warning = self.data['warning_count']

        tk.Label(
            summary_frame,
            text=f"Ditemukan {total} equipment mendekati / lewat due date kalibrasi:",
            font=("Segoe UI", 9, "bold"),
            fg="#f8fafc",
            bg="#1e293b"
        ).pack(anchor="w")

        tk.Label(
            summary_frame,
            text=f"Overdue: {overdue} unit   |   Warning (<= 90 hari): {warning} unit",
            font=("Segoe UI", 8.5, "bold"),
            fg="#fbbf24",
            bg="#1e293b"
        ).pack(anchor="w", pady=(2, 0))

        # Scrollable List Equipment
        list_frame = tk.Frame(container, bg="#0f172a", padx=12, pady=6)
        list_frame.pack(fill="both", expand=True)

        canvas = tk.Canvas(list_frame, bg="#0f172a", highlightthickness=0)
        scrollbar = ttk.Scrollbar(list_frame, orient="vertical", command=canvas.yview)
        scrollable = tk.Frame(canvas, bg="#0f172a")

        scrollable.bind("<Configure>", lambda e: canvas.configure(scrollregion=canvas.bbox("all")))
        canvas.create_window((0, 0), window=scrollable, anchor="nw", width=425)
        canvas.configure(yscrollcommand=scrollbar.set)

        canvas.pack(side="left", fill="both", expand=True)
        scrollbar.pack(side="right", fill="y")

        for eq in self.data['items']:
            days = int(eq['days_left'])
            row = tk.Frame(scrollable, bg="#1e293b", pady=5, padx=8)
            row.pack(fill="x", pady=2)

            status_str = f"OVERDUE ({abs(days)}h)" if days < 0 else f"H-{days} hari"
            status_fg = "#f87171" if days < 0 else "#fbbf24"

            top_row = tk.Frame(row, bg="#1e293b")
            top_row.pack(fill="x")
            tk.Label(
                top_row,
                text=f"{eq['control_no']} - {eq['name']}",
                font=("Segoe UI", 8.5, "bold"),
                fg="#ffffff",
                bg="#1e293b"
            ).pack(side="left")
            tk.Label(
                top_row,
                text=status_str,
                font=("Segoe UI", 8, "bold"),
                fg=status_fg,
                bg="#1e293b"
            ).pack(side="right")

            sub_str = f"Loc: {eq.get('location') or '-'} | Due: {eq['due_date']} | Cal: {eq.get('cal_by') or '-'}"
            tk.Label(row, text=sub_str, font=("Segoe UI", 7.5), fg="#94a3b8", bg="#1e293b").pack(anchor="w")

        # Footer (Timer 5 Menit + Tombol Buka Web & Tutup Manual)
        footer = tk.Frame(container, bg="#0f172a", padx=12, pady=10)
        footer.pack(fill="x")

        self.timer_lbl = tk.Label(
            footer,
            text=f"Tutup otomatis: {format_mm_ss(self.remaining)}",
            font=("Segoe UI", 8),
            fg="#94a3b8",
            bg="#0f172a"
        )
        self.timer_lbl.pack(side="left")

        btn_group = tk.Frame(footer, bg="#0f172a")
        btn_group.pack(side="right")

        close_manual_btn = tk.Button(
            btn_group,
            text="Tutup",
            font=("Segoe UI", 8, "bold"),
            fg="#e2e8f0",
            bg="#334155",
            activebackground="#475569",
            activeforeground="#ffffff",
            bd=0,
            padx=10,
            pady=4,
            cursor="hand2",
            command=self.root.destroy
        )
        close_manual_btn.pack(side="right", padx=(6, 0))

        open_btn = tk.Button(
            btn_group,
            text="Buka Web Data",
            font=("Segoe UI", 8, "bold"),
            fg="#ffffff",
            bg="#2563eb",
            activebackground="#1d4ed8",
            activeforeground="#ffffff",
            bd=0,
            padx=10,
            pady=4,
            cursor="hand2",
            command=self.open_web
        )
        open_btn.pack(side="right")

    def on_mouse_enter(self, _event):
        self.paused = True
        self.timer_lbl.config(text="Timer dijeda (kursor di atas popup)", fg="#38bdf8")

    def on_mouse_leave(self, _event):
        self.paused = False
        self.timer_lbl.config(text=f"Tutup otomatis: {format_mm_ss(self.remaining)}", fg="#94a3b8")

    def open_web(self):
        webbrowser.open(WEB_DASHBOARD_URL)
        self.root.destroy()

    def _tick_timer(self):
        if not self.paused:
            if self.remaining <= 0:
                self.root.destroy()
                return
            self.timer_lbl.config(text=f"Tutup otomatis: {format_mm_ss(self.remaining)}")
            self.remaining -= 1
        self.root.after(1000, self._tick_timer)

    def run(self):
        self.root.mainloop()


if __name__ == "__main__":
    result = fetch_due_equipments()
    if not result or result.get('total_due', 0) == 0:
        sys.exit(0)

    app = CalibrationToastApp(result)
    app.run()
