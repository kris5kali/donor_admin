import 'package:flutter/foundation.dart';

import '../models/stok_darah_model.dart';
import '../utils/api.dart';

class StokDarahProvider with ChangeNotifier {
  Api _stokApi = Api(path: 'stokdarah');
  List<StokDarahModel> _listStokDarah;

  List<StokDarahModel> get listStokDarah => _listStokDarah;

  Future<List<StokDarahModel>> fetchListStokDarah() async {
    var result = await _stokApi.getDataCollections();
    _listStokDarah =
        result.documents.map((e) => StokDarahModel.fromFirestore(e)).toList();
    return _listStokDarah;
  }
}
