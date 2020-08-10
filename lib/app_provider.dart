import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';

import 'providers/acara_donor_page.dart';
import 'providers/auth_provider.dart';
import 'providers/pasien_provider.dart';
import 'providers/pendonor_provider.dart';
import 'providers/profile_provider.dart';
import 'providers/sign_in_provider.dart';
import 'providers/sign_up_provider.dart';
import 'providers/stok_darah_provider.dart';
import 'screens/splash_page.dart';
import 'utils/constants.dart';

class AppProvider extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => AuthProvider.instance()),
        ChangeNotifierProvider(create: (context) => SignUpProvider()),
        ChangeNotifierProvider(create: (context) => SignInProvider()),
        ChangeNotifierProvider(create: (context) => ProfileProvider()),
        ChangeNotifierProvider(create: (context) => PendonorProvider()),
        ChangeNotifierProvider(create: (context) => PasienProvider()),
        ChangeNotifierProvider(create: (context) => StokDarahProvider()),
        ChangeNotifierProvider(create: (context) => AcaraDonorProvider()),
      ],
      child: GetMaterialApp(
        home: MaterialApp(
          title: 'Donor',
          theme: ThemeData(
              visualDensity: VisualDensity.adaptivePlatformDensity,
              appBarTheme: AppBarTheme(
                color: kPrimaryColor,
              )),
          home: SplashPage(),
        ),
      ),
    );
  }
}
