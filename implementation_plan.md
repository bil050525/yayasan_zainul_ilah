# Rencana Implementasi - Aplikasi Yayasan Zainul Ilah

Aplikasi mobile berbasis Flutter untuk **Yayasan Zainul Ilah**, yang dirancang untuk memberikan informasi tentang program yayasan, berita terbaru, dan memfasilitasi donasi.

## Perlu Tinjauan Pengguna

> [!IMPORTANT]
> Rencana ini mengikuti ketentuan blueprint yang diberikan:
> - **Tema**: Yayasan Sosial/Religius.
> - **Layout**: Elegan, profesional, dan modern.
> - **Integrasi Git**: Commit rutin dan dokumentasi lengkap.

## Pertanyaan Terbuka

1. **Fokus Utama**: Apakah yayasan berfokus pada bidang tertentu (misal: Pendidikan, Panti Asuhan, Pesantren)? Ini akan membantu menyesuaikan ikon dan ilustrasi.
2. **Sistem Donasi**: Apakah ingin mengimplementasikan payment gateway (seperti Midtrans) atau cukup menampilkan detail rekening bank untuk transfer manual?
3. **Palet Warna**: Apakah ada warna branding khusus? Saya merekomendasikan perpaduan **Hijau Emerald** dan **Putih Lembut** untuk tampilan yang bersih dan profesional.

## Usulan Perubahan

### Fase 1: Inisialisasi Proyek & Struktur Inti (Selesai)
- Inisialisasi proyek Flutter dengan `flutter create`.
- Setup repositori Git.
- Membuat struktur folder (models, views, providers, widgets).

#### [MODIFIKASI] [pubspec.yaml](file:///c:/Users/User/Desktop/yayasan/pubspec.yaml)
- Menambahkan dependensi: `google_fonts`, `provider`, `intl`, `flutter_svg`, `cached_network_image`.

### Fase 2: Sistem Desain & Tema (Selesai)
#### [BARU] [app_theme.dart](file:///c:/Users/User/Desktop/yayasan/lib/core/app_theme.dart)
- Mendefinisikan `ThemeData` kustom dengan palet warna modern dan tipografi bersih.

### Fase 3: Pengembangan Fitur Utama
#### [MODIFIKASI] [home_screen.dart](file:///c:/Users/User/Desktop/yayasan/lib/screens/home/home_screen.dart)
- Slider program unggulan.
- Kartu berita terbaru.
- Tombol aksi cepat (Donasi, Daftar Program, Tentang Kami).

#### [BARU] [program_list_screen.dart](file:///c:/Users/User/Desktop/yayasan/lib/screens/programs/program_list_screen.dart)
- Daftar program aktif berdasarkan kategori.

#### [BARU] [news_detail_screen.dart](file:///c:/Users/User/Desktop/yayasan/lib/screens/news/news_detail_screen.dart)
- Tampilan detail untuk artikel/berita yayasan.

#### [BARU] [donation_screen.dart](file:///c:/Users/User/Desktop/yayasan/lib/screens/donation/donation_screen.dart)
- Pilihan program donasi.
- Instruksi pembayaran/transfer.

### Fase 4: Dokumentasi & Pemolesan Akhir
#### [BARU] [README.md](file:///c:/Users/User/Desktop/yayasan/README.md)
- Dokumentasi lengkap sesuai persyaratan tugas.

## Rencana Verifikasi

### Tes Otomatis
- Menjalankan `flutter test` untuk logika inti dan pengecekan widget.

### Verifikasi Manual
- Memastikan responsivitas UI di berbagai ukuran layar.
- Memastikan alur navigasi lancar di antara semua layar.
- Mengecek tampilan font dan kontras warna.
