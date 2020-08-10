import 'package:flutter/material.dart';

import '../utils/constants.dart';
import 'membutuhkan_tab_page.dart';
import 'mendonorkan_tab_page.dart';

class InformasiPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: kPrimaryColor,
          title: Text("Informasi"),
          centerTitle: true,
          bottom: TabBar(
            tabs: <Widget>[
              Tab(text: "Membutuhkan Darah"),
              Tab(text: "Mendonorkan Darah"),
            ],
          ),
        ),
        body: TabBarView(
          children: <Widget>[
            MembutuhkanPage(),
            MendonorkanPage(),
          ],
        ),
      ),
    );
  }
}
