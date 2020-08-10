import 'package:flutter/foundation.dart';

import '../models/acara_donor_page.dart';
import '../utils/api.dart';

class AcaraDonorProvider with ChangeNotifier {
  Api _acaraDonorApi = Api(path: 'acaradonor');
  List<AcaraDonorModel> _listAcaraDonor;

  List<AcaraDonorModel> get listAcaraDonor => _listAcaraDonor;

  Future<List<AcaraDonorModel>> fetchListAcaraDonor() async {
    var result = await _acaraDonorApi.getDataCollections();
    _listAcaraDonor =
        result.documents.map((e) => AcaraDonorModel.fromFirestore(e)).toList();
    return _listAcaraDonor;
  }
}
