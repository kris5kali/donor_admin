import 'package:flutter/material.dart';

import '../models/user_model.dart';

class UserViewPage extends StatelessWidget {
  final UserModel user;

  const UserViewPage({Key key, @required this.user}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Data ${user.role}"),
        centerTitle: true,
        backgroundColor: Colors.redAccent,
      ),
      body: Container(
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              Center(
                child: ListTile(
                  leading: CircleAvatar(
                    radius: 30,
                    backgroundColor: Colors.black12,
                    backgroundImage: NetworkImage(user.image),
                  ),
                  title: Text(
                    user.username ?? 'Data Kosong',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
                  ),
                  subtitle: Row(
                    children: <Widget>[
                      Icon(
                        Icons.arrow_forward_ios,
                        size: 17,
                      ),
                      Text(user.role ?? 'Data Kosong')
                    ],
                  ),
                ),
              ),
              SizedBox(height: 5),
              Center(
                child: Container(
                  width: 300,
                  child: Column(
                    children: <Widget>[
                      SizedBox(height: 30),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Text("No. Telepon/HP"),
                          Container(
                            width: 150,
                            padding: EdgeInsets.all(10),
                            decoration: BoxDecoration(
                              border: Border.all(),
                              borderRadius: BorderRadius.circular(15),
                            ),
                            child: Text(user.noHp ?? 'Data Kosong'),
                          )
                        ],
                      ),
                      SizedBox(height: 10),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Text("Golongan Darah"),
                          Container(
                              width: 150,
                              padding: EdgeInsets.all(10),
                              decoration: BoxDecoration(
                                border: Border.all(),
                                borderRadius: BorderRadius.circular(15),
                              ),
                              child: Text(user.golonganDarah ?? 'Data Kosong'))
                        ],
                      ),
                      SizedBox(height: 10),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Text("Alamat"),
                          Container(
                              width: 150,
                              padding: EdgeInsets.all(10),
                              decoration: BoxDecoration(
                                border: Border.all(),
                                borderRadius: BorderRadius.circular(15),
                              ),
                              child: Text(user.alamat ?? 'Data Kosong'))
                        ],
                      ),
                      SizedBox(height: 10),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Text("Tanggal Terakhir Donor"),
                          Container(
                              width: 150,
                              padding: EdgeInsets.all(10),
                              decoration: BoxDecoration(
                                border: Border.all(),
                                borderRadius: BorderRadius.circular(15),
                              ),
                              child: Text(
                                  user.tanggalMembutuhkan ?? 'Data Kosong'))
                        ],
                      ),
                      SizedBox(height: 50),
                      SizedBox(height: 50),
                      Text(
                        "Pengguna aplikasi bisa menghubungi admin \nuntuk keperluan lebih lanjut",
                        textAlign: TextAlign.center,
                        style: TextStyle(fontSize: 15.0),
                      )
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
