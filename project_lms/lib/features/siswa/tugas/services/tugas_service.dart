import '../model/tugas_model.dart';

class TugasService {
  final List<TugasModel> _tugasList = [
    // ===================== 14 Mei 2025 =====================
    TugasModel(
      id: '1',
      mapel: 'Matematika',
      judul: 'Pengumpulan Tugas Minggu ke-2',
      tanggal: 'Senin, 14 Mei 2025',
    ),
    TugasModel(
      id: '2',
      mapel: 'Seni Budaya',
      judul: 'Pengumpulan Tugas Minggu ke-2',
      tanggal: 'Senin, 14 Mei 2025',
    ),
    TugasModel(
      id: '3',
      mapel: 'Bahasa Jawa',
      judul: 'Pengumpulan Tugas Minggu ke-2',
      tanggal: 'Senin, 14 Mei 2025',
    ),

    // ===================== 21 Mei 2025 =====================
    TugasModel(
      id: '4',
      mapel: 'Bahasa Inggris',
      judul: 'Pengumpulan Tugas Minggu ke-3',
      tanggal: 'Senin, 21 Mei 2025',
    ),
    TugasModel(
      id: '5',
      mapel: 'Ilmu Pengetahuan Sosial',
      judul: 'Pengumpulan Tugas Minggu ke-3',
      tanggal: 'Senin, 21 Mei 2025',
    ),
  ];

  // ===================== GET DATA =====================
  List<TugasModel> getAllTugas() {
    return _tugasList;
  }

  // ===================== GROUP BY TANGGAL =====================
  Map<String, List<TugasModel>> getTugasPerTanggal() {
    final Map<String, List<TugasModel>> grouped = {};

    for (var tugas in _tugasList) {
      grouped.putIfAbsent(tugas.tanggal, () => []);
      grouped[tugas.tanggal]!.add(tugas);
    }

    return grouped;
  }

  // ===================== SUBMIT TUGAS =====================
  void submitTugas({
    required String id,
    required String fileName,
    String? catatan,
  }) {
    final tugas = _tugasList.firstWhere((t) => t.id == id);
    tugas.isSubmitted = true;
    tugas.fileName = fileName;
    tugas.catatan = catatan;
  }
}
