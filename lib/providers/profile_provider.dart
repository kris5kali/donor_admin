import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';

import '../models/user_model.dart';
import '../utils/api.dart';

class ProfileProvider with ChangeNotifier {
  final formKey = GlobalKey<FormState>();
  Api _api = Api(path: 'users');
  Api _pendonorApi = Api(path: 'pendonor');
  Api _pasienApi = Api(path: 'pasien');
  Api _adminApi = Api(path: 'admin');
  UserModel _userModel;
  bool _autoValidate = false;
  bool _isUploading = false;
  String _username;
  String _email;
  String _groupGender;
  String _noHp;
  String _noWA;
  String _golonganDarah;
  String _alamat;
  String _jenisKelamin;

  String _tanggalMembutuhkan;
  String _membutuhkanDarah;
  String _urlImage;
  String _role;
  File _imageFile;
  FirebaseStorage _firebaseStorage =
      FirebaseStorage(storageBucket: 'gs://donor-ce9fb.appspot.com');
  StorageUploadTask _storageUploadTask;
  Firestore _firestore = Firestore.instance;

  Api get pendonorApi => _pendonorApi;

  Api get pasienApi => _pasienApi;

  UserModel get userModel => _userModel;

  bool get autoValidate => _autoValidate;

  String get username => _username;

  String get email => _email;

  String get groupGender => _groupGender;

  String get noHp => _noHp;
  String get noWA =>_noWA;

  String get golonganDarah => _golonganDarah;

  String get alamat => _alamat;

  String get jenisKelamin => _jenisKelamin;

  String get tanggalMembutuhkan => _tanggalMembutuhkan;

  String get membutuhkanDarah => _membutuhkanDarah;

  String get urlImage => _urlImage;

  String get role => _role;

  bool get isUploading => _isUploading;

  File get imageFile => _imageFile;

  FirebaseStorage get firebaseStorage => _firebaseStorage;

  StorageUploadTask get storageUploadTask => _storageUploadTask;

  Firestore get firestore => _firestore;

  set autoValidate(bool value) {
    _autoValidate = value;
    notifyListeners();
  }

  set username(String value) {
    _username = value;
    notifyListeners();
  }

  set email(String value) {
    _email = value;
    notifyListeners();
  }

//  String _groupGender;
  set groupGender(String value) {
    _groupGender = value;
    notifyListeners();
  }

//  String _noHp;
  set noHp(String value) {
    _noHp = value;
    notifyListeners();
  }

//  String _golonganDarah;
  set golonganDarah(String value) {
    _golonganDarah = value;
    notifyListeners();
  }

//  String _alamat;
  set alamat(String value) {
    _alamat = value;
    notifyListeners();
  }

  set jenisKelamin(String value) {
    _jenisKelamin = value;
    notifyListeners();
  }

//  String _tanggalMembutuhkan;
  set tanggalMembutuhkan(String value) {
    _tanggalMembutuhkan = value;
    notifyListeners();
  }

//  String _membutuhkanDarah;
  set membutuhkanDarah(String value) {
    _membutuhkanDarah = value;
    notifyListeners();
  }

//  String _urlImage;
  set urlImage(String value) {
    _urlImage = value;
    notifyListeners();
  }

  set role(String value) {
    _role = value;
    notifyListeners();
  }

   set isUploading(bool isLoading) {
    _isUploading = isLoading;
    notifyListeners();
  }

  void genderOnChanged(String value) {
    _groupGender = value;
    notifyListeners();
  }

  void noHpChanged(String value) {
    _noHp = value;
    notifyListeners();
  }
  void noWAChanged(String value) {
    _noWA = value;
    notifyListeners();
  }


  void usernameChanged(String value) {
    _username = value;
    notifyListeners();
  }

  void golonganDarahChanged(String value) {
    _golonganDarah = value;
    notifyListeners();
  }

  void alamatChanged(String value) {
    _alamat = value;
    notifyListeners();
  }

  void tanggalMembutuhkanChanged(String value) {
    _tanggalMembutuhkan = value;
    notifyListeners();
  }

  void membutuhkanDarahChanged(String value) {
    _membutuhkanDarah = value;
    notifyListeners();
  }

  set userModel(UserModel value) {
//    _userModel = value.;
    notifyListeners();
  }

  String validateNoHp(String value) {
    String patttern = r'(^[0-9]*$)';

    RegExp regExp = new RegExp(patttern);
    if (value.length == 0) {
      return "Harap isi no hp";
    } else if (value.length <= 10) {
      return "No Hp tidak valid";
    } else if (!regExp.hasMatch(value)) {
      return "No Hp tidak valid";
    }
    return null;
  }

  String validateText(String value) {
    if (value.length == 0) {
      return "Data tidak boleh kosong";
    }
    return null;
  }

  // Clear image path
  void clear() {
    _imageFile = null;
    notifyListeners();
  }

  Future updateDocumentUser(String id, Map<String, dynamic> data) async {
    await _api.updateDocumentById(id, data);
    notifyListeners();
    return;
  }

  Future updateDocumentPendonor(String id, Map<String, dynamic> data) async {
    await _pendonorApi.updateDocumentById(id, data);
    notifyListeners();
    return;
  }

  Future updateDocumentPasien(String id, Map<String, dynamic> data) async {
    await _pasienApi.updateDocumentById(id, data);
    notifyListeners();
    return;
  }
  Future updateDocumentAdmin(String id, Map<String, dynamic> data) async {
    await _adminApi.updateDocumentById(id, data);
    notifyListeners();
    return;
  }


  Future removeDocumentPasien(String id) async {
    await _pasienApi.removeDocumentById(id);
    return;
  }
  Future removeDocumentPendonor(String id) async {
    await _pendonorApi.removeDocumentById(id);
    return;
  }

  Stream getDocumentById(String id) {
    return _api.getDocumentByIdUsingStream(id);
  }
  Stream getDocumentAdminById(String id) {
    return _adminApi.getDocumentByIdUsingStream(id);
  }

  // Select an image via gallery or camera
  Future<void> selectImage() async {
    final _picker = ImagePicker();
    final selected = await _picker.getImage(source: ImageSource.gallery);
    notifyListeners();
    _imageFile = File(selected.path);
    return cropImage();
  }

  // Cropper depedencies
  Future<void> cropImage() async {
    File cropped = await ImageCropper.cropImage(
      sourcePath: _imageFile.path,
      androidUiSettings: AndroidUiSettings(
        toolbarColor: Colors.blue,
        toolbarWidgetColor: Colors.white,
        toolbarTitle: 'Crop Gambar',
      ),
    );
    _imageFile = cropped ?? _imageFile;
    notifyListeners();
  }

  Future uploadImage({
    @required File imageToUpload,
    @required String title,
  }) async {
    var imageFileName =
        title + DateTime.now().millisecondsSinceEpoch.toString();

    final StorageReference firebaseStorageRef =
        FirebaseStorage.instance.ref().child("users/$imageFileName");

    StorageUploadTask uploadTask = firebaseStorageRef.putFile(imageToUpload);

    StorageTaskSnapshot storageSnapshot = await uploadTask.onComplete;

    var downloadUrl = await storageSnapshot.ref.getDownloadURL();
    _urlImage = downloadUrl;
    print(_urlImage);

    if (uploadTask.isComplete) {
      var url = downloadUrl.toString();
      clear();
    }

    return null;
  }
}
