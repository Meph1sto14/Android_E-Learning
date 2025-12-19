class NilaiModel {
  final String mapel;
  final int nilai;

  NilaiModel({
    required this.mapel,
    required this.nilai,
  });

  // ===== Helper =====
  String get grade {
    if (nilai >= 85) return 'A';
    if (nilai >= 70) return 'B';
    return 'C';
  }
}
