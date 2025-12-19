import 'package:flutter/material.dart';
import '../models/guru_models.dart';

class GuruController extends ChangeNotifier {
  int _selectedIndex = 0;
  int get selectedIndex => _selectedIndex;

  // Inisialisasi Model Form agar data tidak hilang saat pindah tab
  final uploadMateriData = UploadMateriModel();
  final uploadTugasData = UploadTugasModel();

  void setSelectedIndex(int index) {
    _selectedIndex = index;
    notifyListeners();
  }

  @override
  void dispose() {
    uploadMateriData.dispose();
    uploadTugasData.dispose();
    super.dispose();
  }
}