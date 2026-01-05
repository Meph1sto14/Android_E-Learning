import 'package:flutter/material.dart';
import '../services/dashboard_siswa_service.dart';
import '../model/jadwal_item_model.dart';
import '../../materi/model/materi_item_model.dart';
import '../model/progress_pelajaran_model.dart';

class DashboardSiswaController extends ChangeNotifier {
  final DashboardSiswaService _service = DashboardSiswaService();

  // ================= Scroll Controller =================
  final ScrollController progressScrollController = ScrollController();
  final ScrollController dayScrollController = ScrollController();

  // ================= Hari =================
  final List<String> days = const [
    'Senin',
    'Selasa',
    'Rabu',
    'Kamis',
    'Jumat',
    'Sabtu',
    'Minggu',
  ];

  String selectedDay = 'Senin';

  // ================= Data dari Service =================
  List<MateriItem> get mataPelajaran => _service.mataPelajaran;
  List<ProgressPelajaranItem> get progressPelajaran =>
      _service.progressPelajaran;
  List<JadwalItem> get allJadwal => _service.allJadwal;

  // ================= Filter Jadwal =================
  List<JadwalItem> get filteredJadwal {
    return allJadwal.where((e) => e.hari == selectedDay).toList();
  }

  int get currentDayIndex => days.indexOf(selectedDay);

  // ================= Change Day =================
  void changeDay(int index) {
    if (index < 0 || index >= days.length) return;

    selectedDay = days[index];
    notifyListeners();
    _scrollToDay(index);
  }

  // ================= Scroll otomatis tombol hari =================
  void _scrollToDay(int index) {
    if (!dayScrollController.hasClients) return;

    double offset = index * 85.0;
    double max = dayScrollController.position.maxScrollExtent;
    if (offset > max) offset = max;

    dayScrollController.animateTo(
      offset,
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeOut,
    );
  }

  // ================= Progress Carousel =================
  void scrollProgressLeft() {
    progressScrollController.animateTo(
      progressScrollController.offset - 268,
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
    );
  }

  void scrollProgressRight() {
    progressScrollController.animateTo(
      progressScrollController.offset + 268,
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
    );
  }

  @override
  void dispose() {
    progressScrollController.dispose();
    dayScrollController.dispose();
    super.dispose();
  }
}
