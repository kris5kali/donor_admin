import 'package:cloud_firestore/cloud_firestore.dart';

class AcaraDonorModel {
  final String id;
  final String isi;
  final String tanggal;

  AcaraDonorModel({

    this.id,
    this.isi,
    this.tanggal,
  });

  factory AcaraDonorModel.fromFirestore(DocumentSnapshot snapshot) {
    return AcaraDonorModel(
      id: snapshot.documentID,
      isi: snapshot.data["isi"],
      tanggal: snapshot.data['tanggal'],
    );
  }
}
