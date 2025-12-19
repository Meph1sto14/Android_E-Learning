import 'package:flutter/material.dart';
import '../model/materi_model.dart';
import '../services/materi_service.dart';

class MateriController extends ChangeNotifier {
  final MateriService _service = MateriService();

  int selectedBab = 0;
  List<MateriModel> materiList = [];

  // ================= LOAD DATA =================
  void loadMateri(String mapel) {
    materiList = _service.getMateriByMapel(mapel);
    selectedBab = 0;
    notifyListeners();
  }

  // ================= GANTI BAB =================
  void pilihBab(int index) {
    selectedBab = index;
    notifyListeners();
  }

  // ================= GETTER =================
  String get judulBabAktif => materiList[selectedBab].judul;
  String get isiBabAktif => materiList[selectedBab].isi;
}
