import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/auth_provider.dart';
import 'home_page.dart';
import 'sign_in_page.dart';

class SplashPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final authProv = Provider.of<AuthProvider>(context);
    switch (authProv.auth) {
      case Auth.Authenticated:
        return HomePage();
        break;
      case Auth.Unauthenticated:
        return SignInPage();
        break;
      case Auth.Authenticating:
        return SignInPage();
        break;
      default:
    }
    return Scaffold(
      body: Center(
          child: Image.asset(
        'assets/images/logo.png',
        fit: BoxFit.cover,
      )),
    );
  }
}
