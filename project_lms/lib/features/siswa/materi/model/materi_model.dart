class MateriModel {
  final String judul;
  final String isi;

  MateriModel({
    required this.judul,
    required this.isi,
  });

  factory MateriModel.fromMap(Map<String, dynamic> map) {
    return MateriModel(
      judul: map['judul'] ?? '',
      isi: map['isi'] ?? '',
    );
  }
}
