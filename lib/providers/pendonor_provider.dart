import 'package:flutter/foundation.dart';

import '../models/user_model.dart';
import '../utils/api.dart';

class PendonorProvider with ChangeNotifier {
  Api _apiPendonor = Api(path: 'pendonor');
  Api _apiAdmin = Api(path: 'admin');

  List<UserModel> _listUserModel;

  List<UserModel> get listUserModel => _listUserModel;

  Future<List<UserModel>> fetchPendonorList() async {
    var result = await _apiPendonor.getDataCollections();
    _listUserModel =
        result.documents.map((e) => UserModel.fromFirestore(e)).toList();
    return _listUserModel;
  }

  Future<List<UserModel>> fetchAdminList() async {
    var result = await _apiAdmin.getDataCollections();
    _listUserModel =
        result.documents.map((e) => UserModel.fromFirestore(e)).toList();
    return _listUserModel;
  }
}
