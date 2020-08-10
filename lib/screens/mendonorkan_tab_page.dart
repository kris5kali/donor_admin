import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/user_model.dart';
import '../providers/pendonor_provider.dart';
import '../widgets/informasi_card_widget.dart';

class MendonorkanPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final pendonorProv = Provider.of<PendonorProvider>(context);
    return FutureBuilder<List<UserModel>>(
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
            itemBuilder: (BuildContext context, int index) {
              var pendonor = snapshot.data[index];
              return InformasiCard(user: pendonor);
            },
          );
        });
  }
}
