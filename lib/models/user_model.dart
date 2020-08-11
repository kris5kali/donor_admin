import 'package:cloud_firestore/cloud_firestore.dart';

class UserModel {
  final String id;
  final String username;
  final String email;
  final String alamat;
  final String golonganDarah;
  final String jenisKelamin;
  final String membutuhkanDarah;
  final String noHp;
  final String noWA;
  final String image;
  final String role;
  final String tanggalMembutuhkan;

  UserModel({
    this.alamat,
    this.golonganDarah,
    this.jenisKelamin,
    this.membutuhkanDarah,
    this.noHp,
    this.noWA,
    this.id,
    this.username,
    this.email,
    this.image,
    this.role,
    this.tanggalMembutuhkan,
  });

  factory UserModel.fromFirestore(DocumentSnapshot snapshot) {
    return UserModel(
      id: snapshot.documentID,
      email: snapshot.data["email"],
      username: snapshot.data["username"],
      alamat: snapshot.data["alamat"],
      golonganDarah: snapshot.data["golonganDarah"],
      jenisKelamin: snapshot.data["jenisKelamin"],
      membutuhkanDarah: snapshot.data["membutuhkanDarah"],
      noHp: snapshot.data["noHp"],
      noWA: snapshot.data["noWA"],
      image: snapshot.data['image'],
      role: snapshot.data['role'],
      tanggalMembutuhkan: snapshot.data['tanggalMembutuhkan'],
    );
  }
}
