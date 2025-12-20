import 'dart:io';
import 'package:flutter/material.dart';
import '../models/guru_models.dart';
import '../services/guru_service.dart';

class GuruController extends ChangeNotifier {
  int _selectedIndex = 0;
  int get selectedIndex => _selectedIndex;
  bool _isLoading = false;
  bool get isLoading => _isLoading;

  String _selectedKelas = '7A';
  String get selectedKelas => _selectedKelas;
  
  List<SiswaMonitor> _daftarSiswa = [];
  List<SiswaMonitor> get daftarSiswa => _daftarSiswa;

  String _selectedFilter = 'Semua';
  String get selectedFilter => _selectedFilter;
  List<TugasUntukDinilai> _allTugas = [];

  final uploadMateriData = UploadMateriModel();
  final uploadTugasData = UploadTugasModel();

  GuruController() { initLoad(); }

  Future<void> initLoad() async {
    _isLoading = true; notifyListeners();
    try {
      await fetchSiswa();
      await fetchTugas();
    } finally {
      _isLoading = false; notifyListeners();
    }
  }

  void setSelectedIndex(int index) { _selectedIndex = index; notifyListeners(); }
  void updateFilter(String f) { _selectedFilter = f; notifyListeners(); }
  
  List<TugasUntukDinilai> get filteredTugas {
    if (_selectedFilter == 'Semua') return _allTugas;
    return _allTugas.where((t) => t.status == _selectedFilter).toList();
  }

  Future<void> fetchSiswa() async {
    _daftarSiswa = await GuruService.getDaftarSiswa();
    notifyListeners();
  }

  Future<void> fetchTugas() async {
    _allTugas = await GuruService.getDaftarTugas();
    notifyListeners();
  }

  void updateMateriFile(File f, String n) { uploadMateriData.selectedFile = f; uploadMateriData.fileName = n; notifyListeners(); }
  void updateTugasFile(File f, String n) { uploadTugasData.selectedFile = f; uploadTugasData.fileName = n; notifyListeners(); }
  void updateTugasDate(DateTime d, bool isD) { if (isD) uploadTugasData.tanggalDeadline = d; else uploadTugasData.tanggalMulai = d; notifyListeners(); }

  Future<bool> submitUploadMateri() async {
    _isLoading = true; notifyListeners();
    try {
      String? url = uploadMateriData.selectedFile != null 
          ? await GuruService.uploadFile(uploadMateriData.selectedFile!, uploadMateriData.fileName!, 'materi_files') 
          : null;
      bool res = await GuruService.uploadMateri(uploadMateriData, url);
      if (res) uploadMateriData.reset();
      return res;
    } finally { _isLoading = false; notifyListeners(); }
  }

  Future<bool> submitPublishTugas() async {
    _isLoading = true; notifyListeners();
    try {
      String? url = uploadTugasData.selectedFile != null 
          ? await GuruService.uploadFile(uploadTugasData.selectedFile!, uploadTugasData.fileName!, 'lampiran_tugas') 
          : null;
      bool res = await GuruService.publishTugas(uploadTugasData, url);
      if (res) uploadTugasData.reset();
      return res;
    } finally { _isLoading = false; notifyListeners(); }
  }

  @override
  void dispose() {
    uploadMateriData.dispose();
    uploadTugasData.dispose();
    super.dispose();
  }
}