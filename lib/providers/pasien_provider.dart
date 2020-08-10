import 'package:flutter/foundation.dart';

import '../models/user_model.dart';
import '../utils/api.dart';

class PasienProvider with ChangeNotifier {
  Api _apiPasien = Api(path: 'pasien');
  List<UserModel> _listUserModel;

  List<UserModel> get listUserModel => _listUserModel;

  Future<List<UserModel>> fetchPasienList() async {
    var result = await _apiPasien.getDataCollections();
    _listUserModel =
        result.documents.map((e) => UserModel.fromFirestore(e)).toList();
    return _listUserModel;
  }
}
