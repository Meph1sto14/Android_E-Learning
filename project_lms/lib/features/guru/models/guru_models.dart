import 'dart:io';
import 'package:flutter/material.dart';

// --- MODEL MONITOR SISWA ---
class SiswaMonitor {
  final String nama;
  final String nis;
  final String avatar;
  final bool isOnline;
  final String terakhirOnline;
  final double progresMateri;
  final String tugasSelesai;

  SiswaMonitor({
    required this.nama,
    required this.nis,
    required this.avatar,
    required this.isOnline,
    required this.terakhirOnline,
    required this.progresMateri,
    required this.tugasSelesai,
  });
}

// --- MODEL PENILAIAN TUGAS ---
class TugasUntukDinilai {
  final String judul;
  final String kelas;
  final String mataPelajaran;
  final int totalSiswa;
  final int sudahSubmit;
  final int belumDinilai;
  final double rataRata;
  final String status;

  TugasUntukDinilai({
    required this.judul,
    required this.kelas,
    required this.mataPelajaran,
    required this.totalSiswa,
    required this.sudahSubmit,
    required this.belumDinilai,
    required this.rataRata,
    required this.status,
  });
}

// --- MODEL UPLOAD MATERI ---
class UploadMateriModel {
  final formKey = GlobalKey<FormState>(); 
  
  final judulController = TextEditingController();
  final deskripsiController = TextEditingController();
  String? selectedMapel;
  String? selectedKelas;
  String? selectedKategori;
  String? selectedStatus = 'Aktif';
  DateTime? tanggalPublikasi;
  File? selectedFile;
  String? fileName;

  void dispose() {
    judulController.dispose();
    deskripsiController.dispose();
  }

  void reset() {
    judulController.clear();
    deskripsiController.clear();
    selectedMapel = null;
    selectedKelas = null;
    selectedKategori = null;
    tanggalPublikasi = null;
    selectedFile = null;
    fileName = null;
  }
}

// --- MODEL UPLOAD TUGAS (UPDATED) ---
class UploadTugasModel {
  final formKey = GlobalKey<FormState>();

  final judulController = TextEditingController();
  final deskripsiController = TextEditingController();
  String? selectedMapel;
  String? selectedKelas;
  DateTime? tanggalMulai;
  DateTime? tanggalDeadline;
  File? selectedFile;
  String? fileName;

  void dispose() {
    judulController.dispose();
    deskripsiController.dispose();
  }

  void reset() {
    judulController.clear();
    deskripsiController.clear();
    selectedMapel = null;
    selectedKelas = null;
    tanggalMulai = null;
    tanggalDeadline = null;
    selectedFile = null;
    fileName = null;
  }
}