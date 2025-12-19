import '../model/materi_model.dart';
import '../../../shared/data/materi_data.dart';

class MateriService {
  List<MateriModel> getMateriByMapel(String mapel) {
    final rawData = materiData[mapel] ?? [];

    return rawData
        .map<MateriModel>((e) => MateriModel.fromMap(e))
        .toList();
  }
}
