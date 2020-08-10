import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';

import '../providers/auth_provider.dart';
import '../providers/profile_provider.dart';
import '../utils/constants.dart';
import '../utils/screens.dart';

class ChangeGenderDialog extends StatefulWidget {
  final String genderRole;

  const ChangeGenderDialog({Key key,@required this.genderRole}) : super(key: key);
  @override
  _ChangeGenderDialogState createState() => _ChangeGenderDialogState();
}

class _ChangeGenderDialogState extends State<ChangeGenderDialog> {
  @override
  Widget build(BuildContext context) {
    final profileProv = Provider.of<ProfileProvider>(context);
    final authProv = Provider.of<AuthProvider>(context);
    return Container(
      width: Screen.width(context),
      height: 300.0,
      color: kBackgroundColor,
      padding: EdgeInsets.all(32.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Text(
            'Ubah Jenis Kelamin',
            style: kHeadline3,
          ),
          SizedBox(height: 20.0),
          ListTile(
            title:
                Text('Laki-laki', style: kDescription.copyWith(fontSize: 12.0)),
            leading: Radio(
                value: 'Laki-laki',
                groupValue: profileProv.groupGender,
                onChanged: (value) {
                  setState(() {
                    profileProv.genderOnChanged(value);
                  });
                }),
          ),
          ListTile(
            title:
                Text('Perempuan', style: kDescription.copyWith(fontSize: 12.0)),
            leading: Radio(
                value: 'Perempuan',
                groupValue: profileProv.groupGender,
                onChanged: (value) {
                  setState(() {
                    profileProv.genderOnChanged(value);
                  });
                }),
          ),
          SizedBox(height: 25.0),
          Align(
            alignment: Alignment.bottomRight,
            child: Container(
              width: 200.0,
              child: Row(
                children: <Widget>[
                  FlatButton(
                    onPressed: () {
                      Get.back();
                    },
                    child: Text(
                      'Batal',
                      style: kText,
                    ),
                  ),
                  SizedBox(width: 12.0),
                  FlatButton(
                    onPressed: () {
                      profileProv.updateDocumentUser(authProv.userModel.id, {
                        "jenisKelamin": profileProv.groupGender,
                      }).then((value) {
                        if (widget.genderRole== 'Pendonor') {
                          profileProv
                              .updateDocumentPendonor(authProv.userModel.id, {
                            "jenisKelamin": profileProv.groupGender,
                          });
                        } else if (widget.genderRole == 'Pasien') {
                          profileProv.updateDocumentPasien(authProv.userModel.id, {
                            "jenisKelamin": profileProv.groupGender,
                          });
                        }
                      }).then((value) => Get.back());
                    },
                    child: Text('Simpan',
                        style: kText.copyWith(color: kPrimaryColor)),
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
