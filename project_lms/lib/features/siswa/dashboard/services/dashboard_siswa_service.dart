import 'package:flutter/material.dart';
import '../model/materi_item_model.dart';
import '../model/progress_pelajaran_model.dart';
import '../model/jadwal_item_model.dart';

class DashboardSiswaService {
  // ================= Materi =================
  final List<MateriItem> mataPelajaran = const [
    MateriItem(
      title: 'Matematika',
      description: 'Mengembangkan kemampuan berhitung dan logika.',
      icon: Icons.calculate_outlined,
      color: Colors.blueAccent,
    ),
    MateriItem(
      title: 'Bahasa Indonesia',
      description: 'Meningkatkan kemampuan berbahasa.',
      icon: Icons.book_outlined,
      color: Colors.green,
    ),
    MateriItem(
      title: 'Ilmu Pengetahuan Alam',
      description: 'Mempelajari gejala alam dan lingkungan.',
      icon: Icons.science_outlined,
      color: Colors.deepOrange,
    ),
    MateriItem(
      title: 'Pendidikan Pancasila',
      description: 'Menanamkan nilai kebangsaan.',
      icon: Icons.gavel_outlined,
      color: Colors.purple,
    ),
  ];

  // ================= Progress =================
  final List<ProgressPelajaranItem> progressPelajaran = const [
    ProgressPelajaranItem(
      title: 'Ilmu Pengetahuan Alam',
      siswa: 'Lina',
      lesson: 3,
      totalLesson: 7,
      imageUrl: 'assets/images/science.jpg',
    ),
    ProgressPelajaranItem(
      title: 'Ilmu Pengetahuan Sosial',
      siswa: 'Lina',
      lesson: 6,
      totalLesson: 7,
      imageUrl: 'assets/images/social.jpg',
    ),
    ProgressPelajaranItem(
      title: 'Informatika',
      siswa: 'Lina',
      lesson: 1,
      totalLesson: 7,
      imageUrl: 'assets/images/informatika.jpg',
    ),
  ];

  // ================= Jadwal =================
  final List<JadwalItem> allJadwal = const [
    JadwalItem(
      mapel: 'Matematika',
      hari: 'Senin',
      mulai: '07:00',
      selesai: '08:30',
    ),
    JadwalItem(
      mapel: 'Bahasa Indonesia',
      hari: 'Senin',
      mulai: '08:30',
      selesai: '10:00',
    ),
    JadwalItem(
      mapel: 'IPA',
      hari: 'Selasa',
      mulai: '07:00',
      selesai: '08:30',
    ),
    JadwalItem(
      mapel: 'IPS',
      hari: 'Rabu',
      mulai: '08:30',
      selesai: '10:00',
    ),
  ];
}
