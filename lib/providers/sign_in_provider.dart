import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import '../utils/api.dart';
import 'auth_provider.dart';

class SignInProvider with ChangeNotifier {
  final formKey = GlobalKey<FormState>();
  Api _userApi = Api(path: 'users');
  String _email;
  String _password;

  bool _autoValidate = false;
  Api get userApi => _userApi;
  String get email => _email;
  String get password => _password;
  bool get autoValidate => _autoValidate;

  set email(String email) {
    _email = email;
    notifyListeners();
  }

  set autoValidate(bool autoValidate) {
    _autoValidate = autoValidate;
    notifyListeners();
  }

  void onSavedEmail(String email) {
    _email = email;
    notifyListeners();
  }

  void onSavedPassword(String password) {
    _password = password;
    notifyListeners();
  }

  /// [RegExp] non symbol
  // String patttern = r'(^[a-zA-Z ]*$)';
  String validateEmail(String value) {
    String pattern =
        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
    RegExp regExp = new RegExp(pattern);

    if (value.length == 0) {
      return "Harap isi email kamu";
    } else if (!regExp.hasMatch(value)) {
      return "Email salah";
    } else {
      return null;
    }
  }

  String validatePassword(String value) {
    if (value.length == 0) {
      return "Harap isi password kamu";
    } else if (value.length < 6) {
      return "Password harus lebih dari 6 karakter";
    } else {
      return null;
    }
  }

  void signInPressed(AuthProvider authProv, BuildContext context) async {
    if (formKey.currentState.validate()) {
      formKey.currentState.save();
      _autoValidate = false;
      authProv.signIn(
        emailStr: email,
        passwordStr: _password,
        buildContext: context,
      );
    } else {
      _autoValidate = true;
    }
  }
}
