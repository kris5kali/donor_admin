import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:donoradmin/utils/constants.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';

class AddPasienPage extends StatefulWidget {
  @override
  _AddPasienPageState createState() => _AddPasienPageState();
}

class _AddPasienPageState extends State<AddPasienPage> {
  String _email;
  String _password;
  String _nama;
  String _jenisKelamin;
  String _alamat;
  String _riwayat;
  String _noHp;
  String _golonganDarah;

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
//    final pendonorProv = Provider.of<PendonorService>(context);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: kPrimaryColor,
        title: Text("Tambah Pasien"),
        centerTitle: true,
      ),
      body: Center(
        child: Container(
          padding: EdgeInsets.all(25),
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                ListTile(
                  leading: Icon(Icons.email),
                  title: TextField(
                    decoration: InputDecoration(hintText: "email"),
                    onChanged: (val) {
                      setState(() {
                        _email = val;
                      });
                    },
                  ),
                ),
                SizedBox(height: 15),
                ListTile(
                  leading: Icon(Icons.security),
                  title: TextField(
                    decoration: InputDecoration(hintText: "password"),
                    onChanged: (val) {
                      setState(() {
                        _password = val;
                      });
                    },
                  ),
                ),
                SizedBox(height: 15),
                ListTile(
                  leading: Icon(Icons.person),
                  title: TextField(
                    decoration: InputDecoration(hintText: "nama"),
                    onChanged: (val) {
                      setState(() {
                        _nama = val;
                      });
                    },
                  ),
                ),
                SizedBox(height: 15),
                Center(
                  child: ListTile(
                    leading: Image.asset(
                      'assets/images/gender.png',
                      width: 30,
                      height: 30,
                    ),
                    title: DropdownButton(
                      items: jenisKelaminItems,
                      hint: Text("Jenis Kelamin"),
                      value: _jenisKelamin,
                      onChanged: (val) {
                        setState(() {
                          _jenisKelamin = val;
                        });
                      },
                    ),
                  ),
                ),
                SizedBox(height: 15),
                ListTile(
                  leading: Icon(Icons.location_on),
                  title: TextField(
                    decoration: InputDecoration(hintText: "alamat"),
                    onChanged: (val) {
                      setState(() {
                        _alamat = val;
                      });
                    },
                  ),
                ),
                SizedBox(height: 15),
                ListTile(
                  leading: Icon(Icons.date_range),
                  title: TextField(
                    decoration: InputDecoration(hintText: "tanggal membutuhkan"),
                    onChanged: (val) {
                      setState(() {
                        _riwayat = val;
                      });
                    },
                  ),
                ),
                SizedBox(height: 15),
                ListTile(
                  leading: Icon(Icons.phone),
                  title: TextField(
                    decoration: InputDecoration(hintText: "noHp"),
                    onChanged: (val) {
                      setState(() {
                        _noHp = val;
                      });
                    },
                  ),
                ),
                SizedBox(height: 15),
                ListTile(
                  leading: Image.asset(
                    'assets/images/blood.png',
                    width: 30,
                    height: 30,
                  ),
                  title: DropdownButton(
                    items: golDarahItems,
                    hint: Text("Golongan Darah"),
                    value: _golonganDarah,
                    onChanged: (val) {
                      setState(() {
                        _golonganDarah = val;
                      });
                    },
                  ),
                ),
                SizedBox(height: 15),
                SizedBox(height: 20),
                RaisedButton(
                  child: Text("Tambah Pasien"),
                  onPressed: () {
                    FirebaseAuth.instance
                        .createUserWithEmailAndPassword(
                      email: _email,
                      password: _password,
                    )
                        .then((value) async {
                      FirebaseAuth.instance.currentUser().then((user) {
                        Firestore.instance
                            .collection('pasien')
                            .document(user.uid)
                            .setData({
                          "email": user.email,
                          "username": _nama,
                          "jenisKelamin": _jenisKelamin,
                          "alamat": _alamat,
                          "tanggalMembutuhkan": _riwayat,
                          "noHp": _noHp,
                          "golonganDarah": _golonganDarah,
                          "image": "https://i.pinimg.com/564x/51/f6/fb/51f6fb256629fc755b8870c801092942.jpg",
                          "role": "Pasien",
                          "membutuhkanDarah": '0',
                        }).then((value) {
                          Firestore.instance
                              .collection('users')
                              .document(user.uid)
                              .setData({
                            "email": user.email,
                            "username": _nama,
                            "jenisKelamin": _jenisKelamin,
                            "alamat": _alamat,
                            "tanggalMembutuhkan": _riwayat,
                            "noHp": _noHp,
                            "golonganDarah": _golonganDarah,
                            "image": "https://i.pinimg.com/564x/51/f6/fb/51f6fb256629fc755b8870c801092942.jpg",
                            "role": "pendonor",
                            "membutuhkanDarah": '0',
                          });
                          Navigator.pop(context);
                        }).catchError((e) {
                          print(e.toString());
                          print("Service error");
                        });
                      });
                    }).catchError((e) {
                      print(e.toString());
                      print("erroruck");
                    });
                  },
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
