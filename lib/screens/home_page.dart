import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';

import '../providers/auth_provider.dart';
import 'kontak_admin_page.dart';
import '../utils/constants.dart';
import 'acara_donor_page.dart';
import 'informasi_page.dart';
import 'kecocokan_darah_page.dart';
import 'pasien_page.dart';
import 'pendonor_page.dart';
import 'profile_page.dart';
import 'stok_darah_page.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final authProv = Provider.of<AuthProvider>(context);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: kPrimaryColor,
        elevation: 0.0,
      ),
      body: Container(
        child: Column(
          children: <Widget>[
            Container(
              width: MediaQuery.of(context).size.width,
              height: 200,
              decoration: BoxDecoration(
                color: kPrimaryColor,
              ),
              child: Column(
                children: <Widget>[
                  Text(
                    "DONOR DARAH",
                    style: TextStyle(
                      fontSize: 28,
                      color: Colors.white,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  Text(
                    "RSUD AGOESDJAM KETAPANG",
                    style: TextStyle(
                      fontSize: 25,
                      color: Colors.white,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  SizedBox(height: 10),
                  Image.asset(
                    'assets/images/logo.png',
                    fit: BoxFit.fitWidth,
                    height: 100.0,
                    color: kWhiteColor,
                  )
                ],
              ),
            ),
            Container(
              padding: EdgeInsets.all(10),
              width: MediaQuery.of(context).size.width,
              child: Text('Apa itu donor darah?'),
            ),
            Container(
              padding: EdgeInsets.all(10),
              width: MediaQuery.of(context).size.width,
              child: Text(
                  'Donor darah yaitu, pemindahan darah atau suatu komponen darah dari seorang yang sehat (donor) kepada orang orang yang sakit (repision).'),
            ),
            Container(
              padding: EdgeInsets.all(10),
              width: MediaQuery.of(context).size.width,
              child: Text('Manfaat donor darah'),
            ),
            Container(
              padding: EdgeInsets.all(10),
              width: MediaQuery.of(context).size.width,
              child: Text(
                  '"Manfaat donor darah tidak hanya dirasakan oleh penerima donor saja, melainkan juga untuk pendonor. Manfaat donor darah antara lain: \n1. Menurunkan resiko terkena penyakit jantung.\n2. Menurunkan resiko kanker\n3. Membantu menurunkan berat badan.\n4. Mendeteksi penyakit serius.'),
            ),
          ],
        ),
      ),
      drawer: Drawer(
        child: ListView(
          scrollDirection: Axis.vertical,
          children: <Widget>[
            DrawerHeader(
              decoration: BoxDecoration(color: kPrimaryColor),
              child: Container(
                height: 230,
                // color: Colors.redAccent,
                child: Column(
                  children: <Widget>[
                    Text(
                      "Donor Darah",
                      style: TextStyle(fontSize: 30.0, color: Colors.white),
                    ),
                    Text(
                      "RSUD AGOESDJAM",
                      style: TextStyle(fontSize: 17.0, color: Colors.white),
                    ),
                    Spacer(),
                    Container(
                      height: 80.0,
                      width: 80.0,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        color: Colors.white,
                        image: DecorationImage(
                          image: AssetImage('assets/images/logo.png'),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            //--------------------------------------//
            ListTile(
              onTap: () {
                Navigator.pop(context);
              },
              leading: Icon(
                Icons.home,
                color: Colors.red,
              ),
              title: Text("Home"),
            ),
            ListTile(
              onTap: () {
                Get.to(PendonorPage());
              },
              leading: Icon(
                Icons.account_box,
                color: Colors.red,
              ),
              title: Text("Data Pendonor"),
            ),
            ListTile(
              onTap: () {
                Get.to(PasienPage());
              },
              leading: Icon(
                Icons.account_box,
                color: Colors.red,
              ),
              title: Text("Data Pasien"),
            ),
            ListTile(
              onTap: () {
                Get.to(StokDarahPage());
              },
              leading: Icon(
                FlutterIcons.blood_bag_mco,
                color: Colors.red,
              ),
              title: Text("Stok Darah"),
            ),
            ListTile(
              onTap: () {
                Get.to(InformasiPage());
              },
              leading: Icon(
                Icons.info,
                color: Colors.red,
              ),
              title: Text("Informasi"),
            ),
            ListTile(
              onTap: () {
                Get.to(AcaraDonorPage());
              },
              leading: Icon(
                Icons.date_range,
                color: Colors.red,
              ),
              title: Text("Acara Donor"),
            ),
            ListTile(
              onTap: () {
                Get.to(KecocokanDarahPage());
              },
              leading: Icon(
                Icons.group,
                color: Colors.red,
              ),
              title: Text("Kecocokan Darah"),
            ),
            ListTile(
              onTap: () {
                Get.to(KontakAdminPage());
              },
              leading: Icon(
                Icons.contact_mail,
                color: Colors.red,
              ),
              title: Text("Kontak Admin"),
            ),
            ListTile(
              onTap: () {
                Get.to(ProfilePage());
              },
              leading: Icon(
                Icons.settings,
                color: Colors.red,
              ),
              title: Text("Setting"),
            ),
            ListTile(
              onTap: () async {
                authProv.signOut();
              },
              leading: Icon(
                Icons.exit_to_app,
                color: Colors.red,
              ),
              title: Text("Logout"),
            ),
          ],
        ),
      ),
    );
  }
}
