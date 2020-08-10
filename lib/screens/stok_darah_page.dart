import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';

import '../models/stok_darah_model.dart';
import '../providers/stok_darah_provider.dart';
import '../utils/constants.dart';
import 'edit_stok_darah_page.dart';

class StokDarahPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final stokDarahProv = Provider.of<StokDarahProvider>(context);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: kPrimaryColor,
        title: Text(
          'Stok Darah',
          style: kHeadline3.copyWith(
            color: Colors.white,
          ),
        ),
      ),
      body: FutureBuilder<List<StokDarahModel>>(
        future: stokDarahProv.fetchListStokDarah(),
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
            scrollDirection: Axis.vertical,
            shrinkWrap: true,
            itemBuilder: (context, index) {
              var stok = snapshot.data[index];
              return InkWell(
                onTap: () {
                  Get.to(UbahStokDarah(stok: stok));
                },
                child: Container(
                  margin: EdgeInsets.all(10),
                  padding:
                      EdgeInsets.only(left: 40, right: 40, top: 10, bottom: 10),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    color: Colors.black12,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Container(
                          child: Text("Golongan darah: ${stok.golonganDarah}")),
                      Container(child: Text("${stok.stok} Stok")),
                    ],
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
