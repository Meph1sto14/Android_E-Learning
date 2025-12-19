class TugasModel {
  final String id;
  final String mapel;
  final String judul;
  final String tanggal;

  bool isSubmitted;
  String? fileName;
  String? catatan;

  TugasModel({
    required this.id,
    required this.mapel,
    required this.judul,
    required this.tanggal,
    this.isSubmitted = false,
    this.fileName,
    this.catatan,
  });
}
