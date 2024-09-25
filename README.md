# Tugas Pertemuan 3

Nama : Zaki Jamali Arafi
NIM : H1D022048
Shift Baru : D

# Penjelasan Program

## 1.login_page.dart
Widget LoginPage adalah stateful widget yang menggunakan TextEditingController untuk mengelola input username dan password. Fungsi _saveUsername() menyimpan username ke local storage menggunakan SharedPreferences. Untuk menampilkan input, fungsi _showInput() digunakan, sementara fungsi _showDialog() menampilkan dialog pop-up ketika login berhasil atau gagal. Pada saat tombol login ditekan, program memvalidasi username dan password (dalam contoh ini username harus 'arafi' dan password '12345678'). Jika sesuai, username disimpan dan pengguna diarahkan ke halaman HomePage. Jika tidak, pengguna tetap di halaman login dengan pesan kesalahan.

## 2.home_page.dart
Terdapat kelas Jadwal yang merepresentasikan data jadwal dengan atribut seperti mata kuliah, hari, jam mulai, jam berakhir, dan ruangan. Pada kelas HomePage, data jadwal disimpan dan diambil dari local storage menggunakan SharedPreferences. Fungsi _loadUsername() memuat username yang tersimpan, sedangkan _loadJadwal() memuat daftar jadwal dari local storage. Ada beberapa fungsi utama seperti _saveJadwal() untuk menyimpan jadwal, _tambahJadwal() untuk menambah jadwal baru, _editJadwal() untuk mengedit jadwal yang sudah ada, dan _hapusJadwal() untuk menghapus jadwal.

## 3.sidemenu.dart
Menggunakan Drawer untuk menampilkan menu samping dengan opsi navigasi. Di dalam Drawer, terdapat DrawerHeader yang menampilkan judul "Sidemenu", dan dua ListTile untuk navigasi. ListTile pertama menavigasi pengguna ke halaman HomePage yang berisi jadwal kuliah, sedangkan ListTile kedua menavigasi pengguna ke halaman AboutPage yang menampilkan informasi tentang aplikasi. Ketika masing-masing item menu ditekan, Navigator.push digunakan untuk memindahkan pengguna ke halaman yang sesuai, dengan membuat instance baru dari halaman tersebut.

## 4.aboutpage.dart
Halaman ini menampilkan informasi sederhana tentang aplikasi, yaitu "Aplikasi untuk mencatat jadwal perkuliahan".
