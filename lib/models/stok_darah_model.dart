import 'package:cloud_firestore/cloud_firestore.dart';

class StokDarahModel {
  final String id;
  final String golonganDarah;
  final String stok;

  StokDarahModel({

    this.id,
    this.golonganDarah,
    this.stok,
  });

  factory StokDarahModel.fromFirestore(DocumentSnapshot snapshot) {
    return StokDarahModel(
      id: snapshot.documentID,
      golonganDarah: snapshot.data["golonganDarah"],
      stok: snapshot.data['stok'],
    );
  }
}
