import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:donoradmin/models/user_model.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart' as Path;

class EditPasienPage extends StatefulWidget {
  final UserModel user;
  String jenisKelamin;
  String golonganDarah;

  EditPasienPage(
      {Key key, @required this.user, this.golonganDarah, this.jenisKelamin})
      : super(key: key);

  @override
  _EditPasienPageState createState() => _EditPasienPageState();
}

class _EditPasienPageState extends State<EditPasienPage> {
  final _formKey = GlobalKey<FormState>();

  File _image;
  final picker = ImagePicker();

  Future getImage() async {
    final pickedFile = await picker.getImage(source: ImageSource.gallery);

    setState(() {
      _image = File(pickedFile.path);
    });
  }

  List<DropdownMenuItem<String>> golDarahItems = [
    new DropdownMenuItem(
      child: Text("A"),
      value: "A",
    ),
    new DropdownMenuItem(
      child: Text("AB"),
      value: "AB",
    ),
    new DropdownMenuItem(
      child: Text("B"),
      value: "B",
    ),
    new DropdownMenuItem(
      child: Text("O"),
      value: "O",
    ),
  ];

  List<DropdownMenuItem<String>> jenisKelaminItems = [
    new DropdownMenuItem(
      child: Text("Laki-laki"),
      value: "Laki-laki",
    ),
    new DropdownMenuItem(
      child: Text("Perempuan"),
      value: "Perempuan",
    ),
  ];

  @override
  Widget build(BuildContext context) {
    TextEditingController namaController =
    TextEditingController(text: widget.user.username);
    TextEditingController alamatController =
    TextEditingController(text: widget.user.alamat);
    TextEditingController riwayatController =
    TextEditingController(text: widget.user.tanggalMembutuhkan);
    TextEditingController noHpController =
    TextEditingController(text: widget.user.noHp);
    return Scaffold(
      appBar: AppBar(
        title: Text("Edit Pasien"),
        centerTitle: true,
      ),
      body: Center(
        child: Container(
          padding: EdgeInsets.all(10),
          child: SingleChildScrollView(
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  SizedBox(height: 15),
                  ListTile(
                    leading: Icon(Icons.person),
                    title: TextFormField(
                      decoration: InputDecoration(hintText: "nama"),
                      controller: namaController,
                      validator: (val) =>
                      val.isEmpty ? "Kolom tidak boleh kosong!" : null,
                    ),
                  ),
                  SizedBox(height: 15),
                  ListTile(
                    leading: Icon(FlutterIcons.gender_transgender_mco),
                    title: DropdownButton(
                      items: jenisKelaminItems,
                      hint: Text("Jenis Kelamin"),
                      value: widget.jenisKelamin,
                      onChanged: (val) {
                        setState(() {
                          widget.jenisKelamin = val;
                        });
                      },
                    ),
                  ),
                  SizedBox(height: 15),
                  ListTile(
                    leading: Icon(Icons.location_on),
                    title: TextFormField(
                      decoration: InputDecoration(hintText: "alamat"),
                      controller: alamatController,
                      validator: (val) =>
                      val.isEmpty ? "Kolom tidak boleh kosong!" : null,
                    ),
                  ),
                  SizedBox(height: 15),
                  ListTile(
                    leading: Icon(Icons.history),
                    title: TextFormField(
                      decoration: InputDecoration(hintText: "riwayat"),
                      controller: riwayatController,
                      validator: (val) =>
                      val.isEmpty ? "Kolom tidak boleh kosong!" : null,
                    ),
                  ),
                  SizedBox(height: 15),
                  ListTile(
                    leading: Icon(Icons.phone),
                    title: TextFormField(
                      decoration: InputDecoration(hintText: "noHp"),
                      controller: noHpController,
                      validator: (val) =>
                      val.isEmpty ? "Kolom tidak boleh kosong!" : null,
                    ),
                  ),
                  SizedBox(height: 15),
                  ListTile(
                    leading: Icon(FlutterIcons.blood_bag_mco),
                    title: DropdownButton(
                      items: golDarahItems,
                      hint: Text("Golongan Darah"),
                      value: widget.golonganDarah,
                      onChanged: (val) {
                        setState(() {
                          widget.golonganDarah = val;
                          print(val);
                        });
                      },
                    ),
                  ),
                  SizedBox(height: 15),
                  // Text(widget.id),
                  ListTile(
                    leading: InkWell(
                      onTap: () => getImage(),
                      child: Icon(Icons.image),
                    ),
                    title: Center(
                      child: _image == null
                          ? Image.network(widget.user.image)
                          : Image.file(_image),
                    ),
                  ),
                  SizedBox(height: 20),
                  RaisedButton(
                    child: Text("Ubah Pasien"),
                    onPressed: () async {
                      StorageReference storageReference = FirebaseStorage
                          .instance
                          .ref()
                          .child('pendonor/${Path.basename(_image.path)}');
                      StorageUploadTask uploadTask =
                      storageReference.putFile(_image);
                      var imageUrl = await (await uploadTask.onComplete)
                          .ref
                          .getDownloadURL();

                      Firestore.instance
                          .collection('pasien')
                          .document(widget.user.id)
                          .updateData({
                        "username": namaController.text,
                        "jenisKelamin": widget.jenisKelamin,
                        "alamat": alamatController.text,
                        "tanggalMembutuhkan": riwayatController.text,
                        "noHp": noHpController.text,
                        "golonganDarah": widget.golonganDarah,
                        "image": imageUrl,
                      })
                          .then((value) => Firestore.instance
                          .collection('users')
                          .document(widget.user.id)
                          .updateData({
                        "username": namaController.text,
                        "jenisKelamin": widget.jenisKelamin,
                        "alamat": alamatController.text,
                        "tanggalMembutuhkan": riwayatController.text,
                        "noHp": noHpController.text,
                        "golonganDarah": widget.golonganDarah,
                        "image": imageUrl,
                      }))
                          .then((onValue) {
                        Navigator.pop(context);
                      });
                    },
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
