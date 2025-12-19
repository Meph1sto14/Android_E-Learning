import 'package:flutter/material.dart';
import '../model/tugas_model.dart';
import '../services/tugas_service.dart';

class TugasController extends ChangeNotifier {
  final TugasService _service = TugasService();

  // ===================== GET =====================
  Map<String, List<TugasModel>> get tugasPerTanggal {
    return _service.getTugasPerTanggal();
  }

  // ===================== SUBMIT =====================
  void kirimTugas({
    required String id,
    required String fileName,
    String? catatan,
  }) {
    _service.submitTugas(
      id: id,
      fileName: fileName,
      catatan: catatan,
    );
    notifyListeners();
  }
}
