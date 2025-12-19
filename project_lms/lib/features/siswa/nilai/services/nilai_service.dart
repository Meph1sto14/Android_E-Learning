import '../model/nilai_model.dart';

class NilaiService {
  List<NilaiModel> getNilaiSiswa() {
    return [
      NilaiModel(mapel: 'Matematika', nilai: 92),
      NilaiModel(mapel: 'Bahasa Indonesia', nilai: 78),
      NilaiModel(mapel: 'Ilmu Pengetahuan Alam', nilai: 85),
      NilaiModel(mapel: 'Bahasa Inggris', nilai: 88),
      NilaiModel(mapel: 'Pendidikan Pancasila', nilai: 70),
    ];
  }
}
