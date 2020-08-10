import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:meta/meta.dart';

class Api {
  final Firestore _firestore = Firestore.instance;

  final String path;
  CollectionReference collectionReference;

  /// [Constructor] Firebase Helper
  Api({@required this.path}) {
    collectionReference = _firestore.collection(path);
  }

  /// [GET] list document in [Collection]
  Future<QuerySnapshot> getDataCollections() async {
    return await collectionReference.getDocuments();
  }

  /// [GET] document by [ID]
  Future<DocumentSnapshot> getDocumentById(String id) {
    return collectionReference.document(id).get();
  }

  /// [UPDATE] document by [ID]
  Future<void> updateDocumentById(String id, Map<String, dynamic> data) async {
    return await collectionReference.document(id).updateData(data);
  }

  /// [CREATE] document by [ID]
  Future<void> createDocumentById(String id, Map<String, dynamic> data) async {
    return await collectionReference.document(id).setData(data);
  }

  Future<void> createNewDocument(Map<String, dynamic> data) async {
    return await collectionReference.document().setData(data);
  }

  /// [DELETE] document by [ID]
  Future<void> removeDocumentById(String id) async {
    return await collectionReference.document(id).delete();
  }

  /// [GET] document by [ID]
  Stream<DocumentSnapshot> getDocumentByIdUsingStream(String id) {
    return collectionReference.document(id).snapshots();
  }
}
