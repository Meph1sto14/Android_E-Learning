import 'dart:io';
import 'package:flutter/material.dart';

class OptionModel {
  final String id, nama;
  OptionModel({required this.id, required this.nama});
}

class SiswaMonitor {
  final String nama, nis, avatar, terakhirOnline, tugasSelesai;
  final bool isOnline;
  final double progresMateri;
  SiswaMonitor({required this.nama, required this.nis, required this.avatar, required this.isOnline, required this.terakhirOnline, required this.progresMateri, required this.tugasSelesai});
}

class TugasUntukDinilai {
  final String judul, kelas, mataPelajaran, status;
  final int totalSiswa, sudahSubmit, belumDinilai;
  final double rataRata;
  TugasUntukDinilai({required this.judul, required this.kelas, required this.mataPelajaran, required this.totalSiswa, required this.sudahSubmit, required this.belumDinilai, required this.rataRata, required this.status});
}

class UploadMateriModel {
  final formKey = GlobalKey<FormState>();
  final judulController = TextEditingController();
  final deskripsiController = TextEditingController();
  final mapelController = TextEditingController(); // Ketik Manual
  final kelasController = TextEditingController(); // Ketik Manual
  
  String? selectedKategori;
  String? selectedStatus = 'Aktif';
  DateTime? tanggalPublikasi;
  File? selectedFile;
  String? fileName;

  void dispose() {
    judulController.dispose();
    deskripsiController.dispose();
    mapelController.dispose();
    kelasController.dispose();
  }

  void reset() {
    judulController.clear();
    deskripsiController.clear();
    mapelController.clear();
    kelasController.clear();
    selectedKategori = null;
    tanggalPublikasi = null;
    selectedFile = null;
    fileName = null;
  }
}

class UploadTugasModel {
  final formKey = GlobalKey<FormState>();
  final judulController = TextEditingController();
  final deskripsiController = TextEditingController();
  final mapelController = TextEditingController(); // Ketik Manual
  final kelasController = TextEditingController(); // Ketik Manual
  DateTime? tanggalMulai, tanggalDeadline;
  File? selectedFile;
  String? fileName;

  void dispose() {
    judulController.dispose();
    deskripsiController.dispose();
    mapelController.dispose();
    kelasController.dispose();
  }

  void reset() {
    judulController.clear();
    deskripsiController.clear();
    mapelController.clear();
    kelasController.clear();
    tanggalMulai = null;
    tanggalDeadline = null;
    selectedFile = null;
    fileName = null;
  }
}