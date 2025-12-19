import 'package:flutter/material.dart';
import '../model/nilai_model.dart';
import '../services/nilai_service.dart';

class NilaiController extends ChangeNotifier {
  final NilaiService _service = NilaiService();

  // ================= DATA =================
  List<NilaiModel> get daftarNilai {
    return _service.getNilaiSiswa();
  }

  // ================= LOGIKA WARNA =================
  Color getWarnaNilai(int nilai) {
    if (nilai >= 85) return Colors.green.shade600;
    if (nilai >= 70) return Colors.orange.shade600;
    return Colors.red.shade600;
  }
}
