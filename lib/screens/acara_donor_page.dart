import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';

import '../models/acara_donor_page.dart';
import '../providers/acara_donor_page.dart';
import '../utils/constants.dart';
import 'edit_acara_donor_page.dart';

class AcaraDonorPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final acaraProv = Provider.of<AcaraDonorProvider>(context);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: kPrimaryColor,
        title: Text(
          'Acara donor',
          style: kHeadline3.copyWith(color: Colors.white),
        ),
      ),
      body: FutureBuilder<List<AcaraDonorModel>>(
          future: acaraProv.fetchListAcaraDonor(),
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
//              physics: NeverScrollableScrollPhysics(),
              itemBuilder: (BuildContext context, int index) {
                var acara = snapshot.data[index];
                return InkWell(
                  onTap: () {
                    Get.to(EditAcaraDonor(acara: acara));
                  },
                  child: Container(
                    margin: EdgeInsets.only(top: 20),
                    child: Column(
                      children: <Widget>[
                        Container(
                          width: 200,
                          height: 50,
                          color: Colors.redAccent,
                          alignment: Alignment.center,
                          child: Text(
                            acara.tanggal,
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                                fontSize: 20),
                          ),
                        ),
                        SizedBox(height: 10),
                        Card(
                          child: Container(
                            margin: EdgeInsets.only(left: 15, right: 15),
                            padding: EdgeInsets.all(14),
                            width: MediaQuery.of(context).size.width,
                            child: Text(
                              acara.isi,
                              textAlign: TextAlign.justify,
                              style: kText.copyWith(
                                height: 1.5,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            );
          }),
    );
  }
}
