import 'dart:io';
import 'package:supabase_flutter/supabase_flutter.dart';
import '../models/guru_models.dart';

class GuruService {
  static final _supabase = Supabase.instance.client;

  static Future<String?> uploadFile(File file, String fileName, String bucket) async {
    try {
      final path = '${DateTime.now().millisecondsSinceEpoch}_$fileName';
      await _supabase.storage.from(bucket).upload(path, file);
      return _supabase.storage.from(bucket).getPublicUrl(path);
    } catch (e) { return null; }
  }

  static Future<bool> publishTugas(UploadTugasModel model, String? fileUrl) async {
    try {
      await _supabase.from('tugas').insert({
        'judul_tugas': model.judulController.text,
        'deskripsi_instruksi': model.deskripsiController.text,
        'mata_pelajaran': model.mapelController.text, 
        'kelas': model.kelasController.text,
        'file_lampiran_url': fileUrl,
        'waktu_buka': model.tanggalMulai?.toIso8601String(),
        'batas_deadline': model.tanggalDeadline?.toIso8601String(),
      });
      return true;
    } catch (e) { return false; }
  }

  static Future<bool> uploadMateri(UploadMateriModel model, String? fileUrl) async {
    try {
      await _supabase.from('materi').insert({
        'judul_materi': model.judulController.text,
        'deskripsi': model.deskripsiController.text,
        'mata_pelajaran': model.mapelController.text,
        'kelas': model.kelasController.text,
        'kategori': model.selectedKategori,
        'status': model.selectedStatus,
        'file_url': fileUrl,
      });
      return true;
    } catch (e) { return false; }
  }

  // --- MONITORING SISWA (DATA DUMMY ANDA) ---
  static Future<List<SiswaMonitor>> getDaftarSiswa() async {
    await Future.delayed(const Duration(milliseconds: 500));
    return [
      SiswaMonitor(nama: 'Agus Wibowo', nis: '232251', avatar: 'AW', isOnline: true, terakhirOnline: 'Sekarang', progresMateri: 0.8, tugasSelesai: '4/5'),
      SiswaMonitor(nama: 'Rizaldy Aulia', nis: '232251', avatar: 'RA', isOnline: false, terakhirOnline: '3 jam yang lalu', progresMateri: 0.5, tugasSelesai: '3/5'),
      SiswaMonitor(nama: 'Kafka Putra', nis: '232251', avatar: 'KP', isOnline: true, terakhirOnline: 'Sekarang', progresMateri: 0.2, tugasSelesai: '2/5'),
    ];
  }

  // --- PENILAIAN TUGAS (DATA DUMMY ANDA) ---
  static Future<List<TugasUntukDinilai>> getDaftarTugas() async {
    await Future.delayed(const Duration(milliseconds: 500));
    return [
      TugasUntukDinilai(judul: 'Pr Daily Activity', kelas: '7A', mataPelajaran: 'Bahasa Inggris', totalSiswa: 28, sudahSubmit: 28, belumDinilai: 6, rataRata: 8.5, status: 'Belum Dinilai'),
      TugasUntukDinilai(judul: 'Pr Daily Activity', kelas: '7B', mataPelajaran: 'Bahasa Inggris', totalSiswa: 30, sudahSubmit: 30, belumDinilai: 0, rataRata: 9.2, status: 'Sudah Dinilai'),
      TugasUntukDinilai(judul: 'Pr Daily Activity', kelas: '7C', mataPelajaran: 'Bahasa Inggris', totalSiswa: 31, sudahSubmit: 31, belumDinilai: 0, rataRata: 9.0, status: 'Sudah Dinilai'),
    ];
  }
}