import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:donoradmin/screens/edit_pendonor_page.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';

import '../models/user_model.dart';
import '../providers/pendonor_provider.dart';
import '../utils/constants.dart';
import '../widgets/user_card_widget.dart';
import 'add_pendonor_page.dart';
import 'user_view_page.dart';

class PendonorPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final pendonorProv = Provider.of<PendonorProvider>(context);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: kPrimaryColor,
        title: Text(
          'Data Pendonor',
          style: kHeadline2.copyWith(color: kWhiteColor),
        ),
      ),
      body: FutureBuilder<List<UserModel>>(
        future: pendonorProv.fetchPendonorList(),
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
              var pendonor = snapshot.data[index];
              return InkWell(
                onTap: () {
                  showPendonorDialog(context: context, user: pendonor);
                },
                child: UserCard(user: pendonor),
              );
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: kPrimaryColor,
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (BuildContext context) => AddPendonorPage(),
            ),
          );
        },
        child: Icon(Icons.add),
      ),
    );
  }
}

void showPendonorDialog({UserModel user, BuildContext context}) {
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
                      EditPendonorPage(
                        user: user,
                        golonganDarah: user.golonganDarah,
                        jenisKelamin: user.jenisKelamin,
                      ),
                    );
                  },
                  child: Text("Edit Data Pendonor",
                      style: TextStyle(color: Colors.white)),
                  color: Colors.red,
                ),
              ),
              RaisedButton(
                onPressed: () {
                  try {
                    Firestore.instance
                        .collection('pendonor')
                        .document(user.id)
                        .delete()
                        .then(
                          (value) => Firestore.instance
                              .collection('users')
                              .document(user.id)
                              .delete(),
                        );
                    Navigator.pop(context);
                  } catch (e) {
                    print(e.toString());
                  }
                },
                child: Text("Hapus Data Pendonor",
                    style: TextStyle(color: Colors.white)),
                color: Colors.red,
              ),
              SizedBox(
                width: 170,
                child: RaisedButton(
                  onPressed: () {
                    Get.to(UserViewPage(user: user));
                  },
                  child: Text("Lihat Data Pendonor",
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
