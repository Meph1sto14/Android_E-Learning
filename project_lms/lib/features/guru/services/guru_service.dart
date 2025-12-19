import '../models/guru_models.dart';

class GuruService {
  // Mengambil data Monitor Siswa
  static List<SiswaMonitor> getDaftarSiswa() {
    return [
      SiswaMonitor(nama: 'Agus Wibowo', nis: '232251', avatar: 'AW', isOnline: true, terakhirOnline: 'Sekarang', progresMateri: 0.8, tugasSelesai: '4/5'),
      SiswaMonitor(nama: 'Rizaldy Aulia', nis: '232251', avatar: 'RA', isOnline: false, terakhirOnline: '3 jam yang lalu', progresMateri: 0.5, tugasSelesai: '3/5'),
      SiswaMonitor(nama: 'Kafka Putra', nis: '232251', avatar: 'KP', isOnline: true, terakhirOnline: 'Sekarang', progresMateri: 0.2, tugasSelesai: '2/5'),
    ];
  }

  // Mengambil data Penilaian Tugas
  static List<TugasUntukDinilai> getDaftarTugas() {
    return [
      TugasUntukDinilai(judul: 'Pr Daily Activity', kelas: '7A', mataPelajaran: 'Bahasa Inggris', totalSiswa: 28, sudahSubmit: 28, belumDinilai: 6, rataRata: 8.5, status: 'Belum Dinilai'),
      TugasUntukDinilai(judul: 'Pr Daily Activity', kelas: '7B', mataPelajaran: 'Bahasa Inggris', totalSiswa: 30, sudahSubmit: 30, belumDinilai: 0, rataRata: 9.2, status: 'Sudah Dinilai'),
      TugasUntukDinilai(judul: 'Pr Daily Activity', kelas: '7C', mataPelajaran: 'Bahasa Inggris', totalSiswa: 31, sudahSubmit: 31, belumDinilai: 0, rataRata: 9.0, status: 'Sudah Dinilai'),
    ];
  }
}