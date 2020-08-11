import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/user_model.dart';
import '../utils/constants.dart';
import '../providers/pendonor_provider.dart';

class KontakAdminPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final pendonorProv = Provider.of<PendonorProvider>(context);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: kPrimaryColor,
        title: Text(
          'Kontak Admin',
          style: kHeadline3.copyWith(
            color: Colors.white,
          ),
        ),
      ),
      body: StreamBuilder(
        stream: pendonorProv.getDocumentAdminById('gByywwWZiZP5QDxGWlFhTVVzQFC2'),
        builder: (context, snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.none:
              return Center(child: CircularProgressIndicator());
              break;
            case ConnectionState.waiting:
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
          var dataAdmin = snapshot.data;
          return Container(
            child: Center(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  SizedBox(height: 30),
                  CircleAvatar(
                    radius: 70,
                    backgroundImage: NetworkImage(dataAdmin['image']),
                    backgroundColor: Colors.black12,
                  ),
                  SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Text(
                        "Nama :",
                        style: TextStyle(fontSize: 20),
                      ),
                      Container(
                          width: 220,
                          padding: EdgeInsets.all(10),
                          decoration: BoxDecoration(
                            border: Border.all(),
                          ),
                          child: new Text(
//                                  admin.username ?? 'Data Kosong',
                            dataAdmin['username'] ?? 'Data Kosong',
                            style: TextStyle(fontSize: 20),
                          )),
                    ],
                  ),
                  SizedBox(height: 14),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Text(
                        "No. Telepon :",
                        style: TextStyle(fontSize: 20),
                      ),
                      Container(
                          width: 220,
                          padding: EdgeInsets.all(10),
                          decoration: BoxDecoration(
                            border: Border.all(),
                          ),
                          child: new Text(
                            dataAdmin['noHp'] ?? 'Data Kosong',
                            style: TextStyle(fontSize: 20),
                          )),
                    ],
                  ),
                  SizedBox(height: 14),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Text(
                        "WhatsApp :",
                        style: TextStyle(fontSize: 20),
                      ),
                      Container(
                          width: 220,
                          padding: EdgeInsets.all(10),
                          decoration: BoxDecoration(
                            border: Border.all(),
                          ),
                          child: new Text(
                            dataAdmin['noWA']?? 'Data Kosong',
                            style: TextStyle(fontSize: 20),
                          )),
                    ],
                  ),
                  SizedBox(height: 14),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Text(
                        "E-Mail",
                        style: TextStyle(fontSize: 20),
                      ),
                      Container(
                          width: 220,
                          padding: EdgeInsets.all(10),
                          decoration: BoxDecoration(
                            border: Border.all(),
                          ),
                          child: new Text(
                            dataAdmin['email'] ?? 'Data Kosong',
                            style: TextStyle(fontSize: 20),
                          )),
                    ],
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
