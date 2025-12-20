import '../models/guru_models.dart';

class GuruService {
  // --- Mengambil data Monitor Siswa ---
  static Future<List<SiswaMonitor>> getDaftarSiswa() async {
    await Future.delayed(const Duration(milliseconds: 500));
    return [
      SiswaMonitor(nama: 'Agus Wibowo', nis: '232251', avatar: 'AW', isOnline: true, terakhirOnline: 'Sekarang', progresMateri: 0.8, tugasSelesai: '4/5'),
      SiswaMonitor(nama: 'Rizaldy Aulia', nis: '232251', avatar: 'RA', isOnline: false, terakhirOnline: '3 jam yang lalu', progresMateri: 0.5, tugasSelesai: '3/5'),
      SiswaMonitor(nama: 'Kafka Putra', nis: '232251', avatar: 'KP', isOnline: true, terakhirOnline: 'Sekarang', progresMateri: 0.2, tugasSelesai: '2/5'),
    ];
  }

  // --- Mengambil data Penilaian Tugas ---
  static Future<List<TugasUntukDinilai>> getDaftarTugas() async {
    await Future.delayed(const Duration(milliseconds: 500));
    return [
      TugasUntukDinilai(judul: 'Pr Daily Activity', kelas: '7A', mataPelajaran: 'Bahasa Inggris', totalSiswa: 28, sudahSubmit: 28, belumDinilai: 6, rataRata: 8.5, status: 'Belum Dinilai'),
      TugasUntukDinilai(judul: 'Pr Daily Activity', kelas: '7B', mataPelajaran: 'Bahasa Inggris', totalSiswa: 30, sudahSubmit: 30, belumDinilai: 0, rataRata: 9.2, status: 'Sudah Dinilai'),
      TugasUntukDinilai(judul: 'Pr Daily Activity', kelas: '7C', mataPelajaran: 'Bahasa Inggris', totalSiswa: 31, sudahSubmit: 31, belumDinilai: 0, rataRata: 9.0, status: 'Sudah Dinilai'),
    ];
  }

  // --- Fungsi Upload Materi ---
  static Future<bool> uploadMateri(UploadMateriModel data) async {
    try {
      await Future.delayed(const Duration(seconds: 2));
      print("Mengunggah materi: ${data.judulController.text}");
      return true;
    } catch (e) {
      print("Gagal mengunggah materi: $e");
      return false;
    }
  }

  // --- Fungsi Publish Tugas (NEW) ---
  static Future<bool> publishTugas(UploadTugasModel data) async {
    try {
      // Simulasi API Call ke Server
      await Future.delayed(const Duration(seconds: 2));
      print("Mempublikasikan tugas: ${data.judulController.text}");
      return true;
    } catch (e) {
      print("Gagal mempublikasikan tugas: $e");
      return false;
    }
  }
}