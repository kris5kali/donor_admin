import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flushbar/flushbar_helper.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

import '../models/user_model.dart';
import '../utils/api.dart';
import '../utils/constants.dart';

enum Auth {
  Unitialized,
  Authenticated,
  Unauthenticated,
  Authenticating,
}

enum AuthProblems {
  UserNotFound,
  PasswordNotValid,
  NetworkError,
  Unitialized,
}

class AuthProvider with ChangeNotifier {
  /// [API] user collection
  final _userApi = Api(path: 'admin');
  final _adminApi = Api(path: 'users');
  Api _pendonorApi = Api(path: 'pendonor');
  Api _pasienApi = Api(path: 'pasien');

  /// Firebase [Authentication] Services
  FirebaseAuth _firebaseAuth;
  FirebaseUser _firebaseUser;

  /// [Authentication] Session
  Auth _auth = Auth.Unitialized;
  AuthProblems _authProblems = AuthProblems.Unitialized;

  UserModel _userModel;
  String _errorCode;
  bool _isLoading = false;

  ///[============= L I N E - V A R I A B E L =============]
  /// [Getter] Authentication User
  Api get pendonorApi => _pendonorApi;

  Api get pasienApi => _pasienApi;

  Auth get auth => _auth;

  AuthProblems get authProblems => _authProblems;

  /// [Getter] Firebase Auth
  FirebaseAuth get firebaseAuth => _firebaseAuth;

  /// [Getter] Firebase User or Firebase Auth
  FirebaseUser get firebaseUser => _firebaseUser;

  /// [Getter] user [Model]
  UserModel get userModel => _userModel;

  /// [Getter] Error Code Authentication
  String get errorCode => _errorCode;

  bool get isLoading => _isLoading;

  set isLoading(bool isLoading) {
    _isLoading = isLoading;
    notifyListeners();
  }

  /// [Sign Up] Method with Email Address and Password
  Future<bool> signUp({
    @required String emailStr,
    @required String passwordStr,
    @required String usernameStr,
    @required BuildContext buildContext,
  }) async {
    /// [Check E-MAIL] if e-mail already exists and null
    List<String> checkUserEmailIfAlreadyExist =
        await _firebaseAuth.fetchSignInMethodsForEmail(email: emailStr);
    if (checkUserEmailIfAlreadyExist != null &&
        checkUserEmailIfAlreadyExist.length > 0) {
      showAlertDialog(context: buildContext, title: "Email Sudah digunakan");
      return false;
    }
    try {
      _auth = Auth.Authenticating;
      _isLoading = true;
      notifyListeners();
      await _firebaseAuth
          .createUserWithEmailAndPassword(
        email: emailStr,
        password: passwordStr,
      )
          .then(
        (user) async {
          notifyListeners();
          // _isLoading = false;
          setUserDocument(
            user.user.uid,
            {
              /// [ADD] here if user need more data
              "username": usernameStr,
              "email": emailStr,
              "image":
                  "https://i.pinimg.com/564x/51/f6/fb/51f6fb256629fc755b8870c801092942.jpg",
              "role": 'admin',
              "alamat": null,
              "golonganDarah": null,
              "jenisKelamin": null,
              "membutuhkanDarah": "0",
              "noHp": null,
              "tanggalMembutuhkan": null,
            },
          ).then((value) => setAdminDocument(
            user.user.uid,
            {
              /// [ADD] here if user need more data
              "username": usernameStr,
              "email": emailStr,
              "image":
              "https://i.pinimg.com/564x/51/f6/fb/51f6fb256629fc755b8870c801092942.jpg",
              "role": 'admin',
              "alamat": null,
              "golonganDarah": null,
              "jenisKelamin": null,
              "membutuhkanDarah": "0",
              "noHp": null,
              "tanggalMembutuhkan": null,
            },
          )).then(
            (_) => getUserDocumentById(user.user.uid).then((value) {
              _userModel = value;
            }).whenComplete(
              () {
                _isLoading = false;
                Get.back();
              },
            ),
          );
        },
      );
      return true;
    } on PlatformException catch (e) {
      if (e.code == 'ERROR_EMAIL_ALREADY_IN_USE') {
        _auth = Auth.Unauthenticated;
        notifyListeners();
        return false;
      } else {
        _auth = Auth.Unauthenticated;
        notifyListeners();
        return false;
      }
    }
  }

  /// [Sign In] Method with Email Address and Password
  Future<bool> signIn({
    @required String emailStr,
    @required String passwordStr,
    @required BuildContext buildContext,
  }) async {
    try {
      _auth = Auth.Authenticating;
      _isLoading = true;
      notifyListeners();
      await _firebaseAuth
          .signInWithEmailAndPassword(
            email: emailStr,
            password: passwordStr,
          )
          .whenComplete(() => _isLoading = false);
      return true;
    } on PlatformException catch (e) {
      AuthProblems errorType;
      if (Platform.isAndroid) {
        switch (e.message) {
          case 'There is no user record corresponding to this identifier. The user may have been deleted.':
            errorType = AuthProblems.UserNotFound;
            FlushbarHelper.createError(message: 'User tidak ditemukan')
                .show(buildContext);
            _isLoading = false;
            notifyListeners();
            return false;
            break;
          case 'The password is invalid or the user does not have a password.':
            errorType = AuthProblems.PasswordNotValid;
            FlushbarHelper.createError(
                    message: 'Kombinasi email dan password salah')
                .show(buildContext);
            _isLoading = false;
            notifyListeners();

            return false;
            break;
          case 'A network error (such as timeout, interrupted connection or unreachable host) has occurred.':
            errorType = AuthProblems.NetworkError;
            FlushbarHelper.createError(
                    message: 'Terjadi kesalahan pada jaringan')
                .show(buildContext);
            _isLoading = false;
            notifyListeners();

            return false;
            break;
          // ...
          default:
            print('Case ${e.message} is not jet implemented');
        }
      } else if (Platform.isIOS) {
        switch (e.code) {
          case 'Error 17011':
            errorType = AuthProblems.UserNotFound;
            _isLoading = false;
            notifyListeners();

            return false;
            break;
          case 'Error 17009':
            errorType = AuthProblems.PasswordNotValid;
            _isLoading = false;
            notifyListeners();

            return false;
            break;
          case 'Error 17020':
            errorType = AuthProblems.NetworkError;
            _isLoading = false;
            notifyListeners();

            return false;
            break;
          // ...
          default:
            print('Case ${e.message} is not jet implemented');
        }
      }
      print('The error is $errorType');
      return false;
    }
  }

// Account Logout
  Future signOut() async {
    _firebaseAuth.signOut();
    // _googleSignIn.signOut();
    _auth = Auth.Unauthenticated;
    notifyListeners();
    return Future.delayed(Duration.zero);
  }

  AuthProvider.instance() : _firebaseAuth = FirebaseAuth.instance {
    try {
// _googleSignIn = GoogleSignIn();
      _firebaseAuth.onAuthStateChanged.listen(_onAuthStateChanged);
    } on PlatformException catch (e) {
      if (e.code == 'error') {
        _auth = Auth.Unauthenticated;
      }
    }
  }

  Future<void> _onAuthStateChanged(FirebaseUser firebaseUser) async {
    if (firebaseUser == null) {
      _auth = Auth.Unauthenticated;
    } else {
      _firebaseUser = firebaseUser;
      // tiap login/buka app,getdata detail user, lalu disimpan di Accountservice:AccountDetail; dak jadi ak boros mana wkwkw
      // AccountService().getDocumentById(firebaseUser.uid);
      await checkUserDocument(firebaseUser.uid, <String, dynamic>{
//        "username": _firebaseUser.displayName,
//        "image": "https://bit.ly/38RVDAf"
      }).then((user) async {
        _userModel = user;
        print('login sukses');
        _auth = Auth.Authenticated;
      });
    }
    notifyListeners();
  }

  Future<UserModel> checkUserDocument(String id, Map data) async {
    var result = await getUserDocumentById(id);
    if (result == null) {
      var setNewUserThenData = await setUserDocument(id, data)
          .then((value) => getUserDocumentById(id));
      return setNewUserThenData;
    } else {
      return result;
    }
  }

  /// [GET] data user / user document by [ID]
  Future<UserModel> getUserDocumentById(String id) async {
    var documentResult = await _userApi.getDocumentById(id);
    if (!documentResult.exists) {
      return null;
    }
    _userModel = UserModel.fromFirestore(documentResult);
    return _userModel;
  }

  Future setUserDocument(String id, Map<String, dynamic> data) async {
    return await _userApi.createDocumentById(id, data);
  }

  Future setPendonorDocument(String id, Map<String, dynamic> data) async {
    return await _pendonorApi.createDocumentById(id, data);
  }

  Future setPasienDocument(String id, Map<String, dynamic> data) async {
    return await _pasienApi.createDocumentById(id, data);
  }
  Future setAdminDocument(String id, Map<String, dynamic> data) async {
    return await _adminApi.createDocumentById(id, data);
  }

// Show Alert Dialog Loading
// When user try to Sign Up or Sign In
  void showAlertDialog({BuildContext context, String title}) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(25.0),
          ),
          content: Container(
            width: 150.0,
            height: 150.0,
            padding: EdgeInsets.symmetric(vertical: 25.0),
            child: Column(
              children: <Widget>[
                Icon(
                  Icons.close,
                  color: Colors.red,
                  size: 50.0,
                ),
                Spacer(),
                Text(title, style: kText)
              ],
            ),
          ),
          actions: <Widget>[
            FlatButton(
              onPressed: () => Get.back(),
              child: Text(
                'Tutup',
                style: kDescription,
              ),
            ),
          ],
        );
      },
    );
  }
}
