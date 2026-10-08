# Inventaris Kelas

Aplikasi inventaris pemeriksaan ruang kelas untuk Android dan iPhone.

## Konsep V1
- Offline-first
- 1 Ketua + 5 Anggota
- Login dengan PIN
- Semua pengguna boleh mengedit data pada tahap awal
- Dashboard modern bergaya card
- Rencana berikutnya: SQLite, ruangan, inventaris, QR, foto, jadwal pemeriksaan, Excel dengan foto, backup, dan berbagi WhatsApp

## PIN Demo
- Ketua: `1234`
- Anggota 01: `1101`
- Anggota 02: `1102`
- Anggota 03: `1103`
- Anggota 04: `1104`
- Anggota 05: `1105`

PIN ini hanya untuk prototipe dan nanti akan dipindahkan ke database lokal dengan penyimpanan yang lebih aman.

## Menjalankan
1. Install Flutter SDK.
2. Buat project Flutter baru dengan:
   `flutter create .`
3. Ganti folder `lib/` dan file `pubspec.yaml` dengan isi repository ini.
4. Jalankan:
   `flutter pub get`
5. Jalankan:
   `flutter run`

## Roadmap
V1.1 - Database SQLite dan master ruangan
V1.2 - Inventaris + kondisi
V1.3 - Kamera/foto
V1.4 - QR Code
V1.5 - Jadwal pemeriksaan
V1.6 - Excel dengan foto tertanam
V1.7 - Backup/restore + ZIP
V1.8 - Berbagi file melalui WhatsApp/share sheet
V2 - Role/approval/locking/audit yang lebih ketat
