import 'package:flutter/material.dart';
import '../services/jadwal_service.dart';
import '../model/jadwal_item_model.dart';

class JadwalController extends ChangeNotifier {
  final JadwalService _service = JadwalService();

  String selectedDay = 'Senin';

  final List<String> days = [
    'Senin',
    'Selasa',
    'Rabu',
    'Kamis',
    'Jumat',
  ];

  void changeDay(String day) {
    selectedDay = day;
    notifyListeners();
  }

  List<JadwalItem> get jadwalHariIni {
    return _service.jadwalPerHari[selectedDay] ?? [];
  }
}
