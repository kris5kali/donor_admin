import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:donoradmin/screens/add_pasien_page.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';

import '../models/user_model.dart';
import '../providers/pasien_provider.dart';
import '../utils/constants.dart';
import '../widgets/user_card_widget.dart';
import 'edit_pasien_page.dart';
import 'user_view_page.dart';

class PasienPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final pasienProv = Provider.of<PasienProvider>(context);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: kPrimaryColor,
        title: Text(
          'Data Pasien',
          style: kHeadline2.copyWith(color: kWhiteColor),
        ),
      ),
      body: FutureBuilder<List<UserModel>>(
        future: pasienProv.fetchPasienList(),
        builder: (context, snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.none:
              return Center(child: CircularProgressIndicator());
              break;
            case ConnectionState.waiting:
              return Center(child: CircularProgressIndicator());
              break;
            case ConnectionState.active:
              return Center(child: CircularProgressIndicator());
              break;
            case ConnectionState.done:
              if (snapshot.hasError) {
                return Center(child: Text('Something error'));
              }
              if (!snapshot.hasData) {
                return Center(child: Text('No Data'));
              }
              break;
            default:
          }
          return ListView.builder(
            itemCount: snapshot.data.length,
            shrinkWrap: true,
            scrollDirection: Axis.vertical,
            itemBuilder: (context, index) {
              var pasien = snapshot.data[index];
              return InkWell(
                onTap: () {
                  showPasienDialog(context: context, pasien: pasien);
                },
                child: UserCard(user: pasien),
              );
            },
          );
        },
      ),
//      floatingActionButton: FloatingActionButton(
//        backgroundColor: kPrimaryColor,
//        onPressed: () {
//          Navigator.push(
//            context,
//            MaterialPageRoute(
//              builder: (BuildContext context) => AddPasienPage(),
//            ),
//          );
//        },
//        child: Icon(Icons.add),
//      ),
    );
  }
}

void showPasienDialog({@required context, @required UserModel pasien}) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text("Pilih Tindakan"),
        content: Container(
          width: 200,
          height: 200,
          child: Column(
            children: <Widget>[
              SizedBox(
                width: 170,
                child: RaisedButton(
                  onPressed: () {
                    Get.to(
                      EditPasienPage(
                        user: pasien,
                        jenisKelamin: pasien.jenisKelamin,
                        golonganDarah: pasien.golonganDarah,
                      ),
                    );
                  },
                  child: Text("Edit Data Pasien",
                      style: TextStyle(color: Colors.white)),
                  color: Colors.red,
                ),
              ),
              SizedBox(
                width: 170,
                child: RaisedButton(
                  onPressed: () {
                    try {
                      Firestore.instance
                          .collection('pasien')
                          .document(pasien.id)
                          .delete()
                          .then(
                            (value) => Firestore.instance
                                .collection('user')
                                .document(pasien.id)
                                .delete(),
                          );
                      Navigator.pop(context);
                    } catch (e) {
                      print(e.toString());
                    }
                  },
                  child: Text("Hapus Data Pasien",
                      style: TextStyle(color: Colors.white)),
                  color: Colors.red,
                ),
              ),
              SizedBox(
                width: 170,
                child: RaisedButton(
                  onPressed: () {
                    Get.to(
                      UserViewPage(
                        user: pasien,
                      ),
                    );
                  },
                  child: Text("Lihat Data Pasien",
                      style: TextStyle(color: Colors.white)),
                  color: Colors.red,
                ),
              ),
            ],
          ),
        ),
      );
    },
  );
}
