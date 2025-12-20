import 'dart:io';
import 'package:flutter/material.dart';
import '../models/guru_models.dart';
import '../services/guru_service.dart';

class GuruController extends ChangeNotifier {
  // --- State Navigasi ---
  int _selectedIndex = 0;
  int get selectedIndex => _selectedIndex;

  // --- State Umum ---
  bool _isLoading = false;
  bool get isLoading => _isLoading;

  // --- State Monitor Siswa ---
  String _selectedKelas = 'Kelas 7B';
  List<SiswaMonitor> _daftarSiswa = [];
  
  String get selectedKelas => _selectedKelas;
  List<SiswaMonitor> get daftarSiswa => _daftarSiswa;

  // --- State Penilaian Tugas ---
  String _selectedFilter = 'Semua';
  List<TugasUntukDinilai> _allTugas = [];
  
  String get selectedFilter => _selectedFilter;

  // --- State Form (Presistensi Data) ---
  final uploadMateriData = UploadMateriModel();
  final uploadTugasData = UploadTugasModel();

  // --- Konstruktor ---
  GuruController() {
    fetchSiswa();
    fetchTugas();
  }

  // --- Method Navigasi ---
  void setSelectedIndex(int index) {
    _selectedIndex = index;
    notifyListeners();
  }

  // --- Method Monitor Siswa ---
  void updateKelas(String newKelas) {
    _selectedKelas = newKelas;
    fetchSiswa(); 
  }

  Future<void> fetchSiswa() async {
    _isLoading = true;
    notifyListeners();
    try {
      _daftarSiswa = await GuruService.getDaftarSiswa();
    } catch (e) {
      debugPrint("Error fetching siswa: $e");
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  // --- Method Penilaian Tugas ---
  List<TugasUntukDinilai> get filteredTugas {
    if (_selectedFilter == 'Semua') return _allTugas;
    return _allTugas.where((t) => t.status == _selectedFilter).toList();
  }

  void updateFilter(String newFilter) {
    _selectedFilter = newFilter;
    notifyListeners();
  }

  Future<void> fetchTugas() async {
    _isLoading = true;
    notifyListeners();
    try {
      _allTugas = await GuruService.getDaftarTugas(); 
    } catch (e) {
      debugPrint("Error fetching tugas: $e");
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  // --- Method Upload Materi ---
  void updateMateriFile(File file, String name) {
    uploadMateriData.selectedFile = file;
    uploadMateriData.fileName = name;
    notifyListeners();
  }

  void updateMateriDate(DateTime date) {
    uploadMateriData.tanggalPublikasi = date;
    notifyListeners();
  }

  Future<bool> submitUploadMateri() async {
    _isLoading = true;
    notifyListeners();
    bool success = await GuruService.uploadMateri(uploadMateriData);
    if (success) uploadMateriData.reset();
    _isLoading = false;
    notifyListeners();
    return success;
  }

  // --- Method Upload Tugas (NEW) ---

  /// Mengupdate file tugas yang dipilih
  void updateTugasFile(File file, String name) {
    uploadTugasData.selectedFile = file;
    uploadTugasData.fileName = name;
    notifyListeners();
  }

  /// Mengupdate tanggal (mulai atau deadline)
  void updateTugasDate(DateTime date, bool isDeadline) {
    if (isDeadline) {
      uploadTugasData.tanggalDeadline = date;
    } else {
      uploadTugasData.tanggalMulai = date;
    }
    notifyListeners();
  }

  /// Memproses pengiriman data tugas ke service
  Future<bool> submitPublishTugas() async {
    _isLoading = true;
    notifyListeners();

    bool success = await GuruService.publishTugas(uploadTugasData);
    
    if (success) {
      uploadTugasData.reset(); // Reset form jika berhasil
    }

    _isLoading = false;
    notifyListeners();
    return success;
  }

  // --- Lifecycle ---
  @override
  void dispose() {
    uploadMateriData.dispose();
    uploadTugasData.dispose();
    super.dispose();
  }
}