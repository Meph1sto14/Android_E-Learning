import 'package:flutter/material.dart';

class JadwalItem {
  final String mataPelajaran;
  final String kodeKelas;
  final String ruangan;
  final String waktuMulai;
  final String waktuSelesai;
  final Color color;

  JadwalItem({
    required this.mataPelajaran,
    required this.kodeKelas,
    required this.ruangan,
    required this.waktuMulai,
    required this.waktuSelesai,
    required this.color,
  });
}
