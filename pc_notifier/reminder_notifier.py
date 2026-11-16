import tkinter as tk
from tkinter import ttk
import urllib.request
import json
import sys

# Endpoint API PHP untuk pengecekan reminder kalibrasi equipment
API_URL = "http://192.168.180.181/Calibration-AC/api_reminder_check.php"

def fetch_reminders():
    try:
        req = urllib.request.Request(API_URL, headers={'User-Agent': 'Mozilla/5.0'})
        with urllib.request.urlopen(req, timeout=5) as response:
            data = json.loads(response.read().decode('utf-8'))
            if data.get('success'):
                return data.get('items', [])
    except Exception as e:
        print("Gagal mengambil data reminder:", e)
    return []

class ReminderApp:
    def __init__(self, root, items):
        self.root = root
        self.items = items
        self.time_left = 300  # 5 menit dalam detik (300 detik)
        self.is_paused = False

        self.root.title("⚠️ Peringatan Kalibrasi Equipment - AC PE")
        self.root.geometry("680x450")
        self.root.attributes("-topmost", True)  # Selalu di atas jendela lain
        self.root.configure(bg="#f8fafc")

        self.center_window()

        # Header Warning
        header_frame = tk.Frame(root, bg="#dc2626", padx=15, pady=12)
        header_frame.pack(fill=tk.X)
        
        title_lbl = tk.Label(header_frame, text="PERINGATAN JADWAL KALIBRASI EQUIPMENT", fg="white", bg="#dc2626", font=("Arial", 11, "bold"))
        title_lbl.pack(side=tk.LEFT)

        self.timer_lbl = tk.Label(header_frame, text="Auto-close: 05:00", fg="#fef08a", bg="#dc2626", font=("Arial", 10, "bold"))
        self.timer_lbl.pack(side=tk.RIGHT)

        # Konten Info
        info_frame = tk.Frame(root, bg="#f8fafc", padx=15, pady=10)
        info_frame.pack(fill=tk.X)
        
        desc = tk.Label(info_frame, text=f"Ditemukan {len(items)} equipment yang telah LEWAT (Overdue) atau Mendekati Due Date (≤ 90 Hari):", 
                        fg="#334155", bg="#f8fafc", font=("Arial", 9), anchor="w")
        desc.pack(fill=tk.X)

        # Tabel / Listbox dengan Scrollbar
        table_frame = tk.Frame(root, padx=15, pady=5)
        table_frame.pack(fill=tk.BOTH, expand=True)

        columns = ("Control No", "Equipment Name", "Location", "Due Date", "Status")
        self.tree = ttk.Treeview(table_frame, columns=columns, show="headings", height=10)
        
        self.tree.heading("Control No", text="Control No")
        self.tree.heading("Equipment Name", text="Equipment Name")
        self.tree.heading("Location", text="Location")
        self.tree.heading("Due Date", text="Due Date")
        self.tree.heading("Status", text="Status")

        self.tree.column("Control No", width=100, anchor="w")
        self.tree.column("Equipment Name", width=200, anchor="w")
        self.tree.column("Location", width=90, anchor="center")
        self.tree.column("Due Date", width=90, anchor="center")
        self.tree.column("Status", width=90, anchor="center")

        scrollbar = ttk.Scrollbar(table_frame, orient=tk.VERTICAL, command=self.tree.yview)
        self.tree.configure(yscrollcommand=scrollbar.set)

        self.tree.pack(side=tk.LEFT, fill=tk.BOTH, expand=True)
        scrollbar.pack(side=tk.RIGHT, fill=tk.Y)

        for item in items:
            days = int(item.get('days_left', 0))
            if days < 0:
                status_text = f"OVERDUE ({abs(days)}h)"
            else:
                status_text = f"H-{days} Hari"
            
            self.tree.insert("", tk.END, values=(
                item.get('control_no'),
                item.get('name'),
                item.get('location', '-'),
                item.get('due_date'),
                status_text
            ))

        # Footer & Tombol Tutup Manual
        footer_frame = tk.Frame(root, bg="#e2e8f0", padx=15, pady=10)
        footer_frame.pack(fill=tk.X)

        note_lbl = tk.Label(footer_frame, text="💡 Tips: Arahkan kursor ke jendela ini untuk menjeda timer otomatis.", fg="#64748b", bg="#e2e8f0", font=("Arial", 8, "italic"))
        note_lbl.pack(side=tk.LEFT)

        close_btn = tk.Button(footer_frame, text="Tutup Notifikasi", command=root.destroy, bg="#0f172a", fg="white", font=("Arial", 9, "bold"), padx=10, pady=4, relief=tk.FLAT)
        close_btn.pack(side=tk.RIGHT)

        root.bind("<Enter>", self.on_enter)
        root.bind("<Leave>", self.on_leave)

        self.update_timer()

    def center_window(self):
        self.root.update_idletasks()
        w = self.root.winfo_width()
        h = self.root.winfo_height()
        x = (self.root.winfo_screenwidth() // 2) - (w // 2)
        y = (self.root.winfo_screenheight() // 2) - (h // 2)
        self.root.geometry(f"{w}x{h}+{x}+{y}")

    def on_enter(self, event):
        self.is_paused = True
        self.timer_lbl.config(text="Auto-close: [PAUSED]")

    def on_leave(self, event):
        self.is_paused = False

    def update_timer(self):
        if not self.is_paused:
            if self.time_left > 0:
                mins, secs = divmod(self.time_left, 60)
                self.timer_lbl.config(text=f"Auto-close: {mins:02d}:{secs:02d}")
                self.time_left -= 1
            else:
                self.root.destroy()
                return
        self.root.after(1000, self.update_timer)

if __name__ == "__main__":
    urgent_data = fetch_reminders()
    if urgent_data:
        root = tk.Tk()
        app = ReminderApp(root, urgent_data)
        root.mainloop()
