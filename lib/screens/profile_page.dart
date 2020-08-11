import 'package:donoradmin/widgets/gender_admin_change_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';

import '../providers/auth_provider.dart';
import '../providers/profile_provider.dart';
import '../utils/constants.dart';
import '../widgets/change_gender_dialog_widget.dart';
import '../widgets/text_form_field_widget.dart';

class ProfilePage extends StatefulWidget {
  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  var _dataAccount;
  String genderRole;

  @override
  Widget build(BuildContext context) {
    final authProv = Provider.of<AuthProvider>(context);
    final profileProv = Provider.of<ProfileProvider>(context);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: kPrimaryColor,
        title: Text("Profil"),
      ),
      body: StreamBuilder(
        stream: profileProv.getDocumentAdminById('gByywwWZiZP5QDxGWlFhTVVzQFC2'),
        builder: (context, snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.none:
              return Center(child: CircularProgressIndicator());
              break;
            case ConnectionState.waiting:
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
            case ConnectionState.active:
              var user = snapshot.data;
              _dataAccount = user;
              break;

            default:
          }
          var user = snapshot.data;
          return Container(
            child: SingleChildScrollView(
              child: Column(
                children: <Widget>[
                  Center(
                    child: ListTile(
                      leading: GestureDetector(
                        onTap: () {
                          profileProv
                              .selectImage()
                              .then((value) => profileProv.uploadImage(
                                  imageToUpload: profileProv.imageFile,
                                  title: profileProv.imageFile.toString()))
                              .then((value) {
                            profileProv.updateDocumentUser(
                                'gByywwWZiZP5QDxGWlFhTVVzQFC2',
                                {"image": profileProv.urlImage});
                            profileProv.updateDocumentAdmin(
                                'gByywwWZiZP5QDxGWlFhTVVzQFC2',
                                {"image": profileProv.urlImage});
                            profileProv.clear();
                          });
                        },
                        child: profileProv.imageFile != null
                            ? CircleAvatar(
                                radius: 30.0,
                                backgroundImage:
                                    FileImage(profileProv.imageFile),
                              )
                            : CircleAvatar(
                                radius: 30,
                                backgroundColor: Colors.black12,
                                backgroundImage: NetworkImage(
                                  user['image'] ??
                                      'https://i.pinimg.com/564x/51/f6/fb/51f6fb256629fc755b8870c801092942.jpg',
                                ),
                              ),
                      ),
                      title: GestureDetector(
                        onTap: () {
                          changeNameDialog(
                            context: context,
                            profileProv: profileProv,
                            user: user,
                            authProv: authProv,
                          );
                        },
                        child: Text(
                          user['username'] ?? '',
                          style: TextStyle(
                              fontSize: 18, fontWeight: FontWeight.w600),
                        ),
                      ),
                      subtitle: Row(
                        children: <Widget>[
                          Icon(
                            Icons.arrow_forward_ios,
                            size: 17,
                          ),
                          Text(
                            'Admin',
                            style: kText,
                          )
                        ],
                      ),
                    ),
                  ),

                  SizedBox(height: 5),
                  Center(
                    child: Container(
                      width: 300,
                      child: Column(
                        children: <Widget>[
                          SizedBox(height: 30),
                          profileItem(
                            title: 'No. WA',
                            value: user['noWA'],
                            onTap: () {
                              changeNoWADialog(
                                context: context,
                                profileProv: profileProv,
                                user: user,
                                authProv: authProv,
                              );
                            },
                          ),
                          SizedBox(height: 10),
                          profileItem(
                            title: 'No. HP',
                            value: user['noHp'],
                            onTap: () {
                              changeNoHpDialog(
                                context: context,
                                profileProv: profileProv,
                                user: user,
                                authProv: authProv,
                              );
                            },
                          ),
                          SizedBox(height: 10),
                          profileItem(
                            title: 'Alamat',
                            value: user['alamat'],
                            onTap: () {
                              changeAlamatDialog(
                                context: context,
                                profileProv: profileProv,
                                user: user,
                                authProv: authProv,
                              );
                            },
                          ),
                          SizedBox(height: 10),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  Future changeAlamatDialog({context, profileProv, user, authProv}) {
    return showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Ganti Alamat'),
          content: Form(
            key: profileProv.formKey,
            autovalidate: profileProv.autoValidate,
            child: TextFormFieldWidget(
              validator: profileProv.validateText,
              obscureText: false,
              initialValue: user['alamat'],
              keyboardType: TextInputType.text,
              prefixIcon: Icon(Icons.phone),
              hintText: 'Masukkan Alamat Lengkap',
              onChanged: (value) => profileProv.alamatChanged(value),
            ),
          ),
          actions: <Widget>[
            FlatButton(
              child: Text('Batal'),
              onPressed: () {
                Get.back();
              },
              color: kGreyColor,
            ),
            FlatButton(
              child: Text('Simpan'),
              onPressed: () {
                if (profileProv.formKey.currentState.validate()) {
                  profileProv.formKey.currentState.save();
                  profileProv.updateDocumentUser('gByywwWZiZP5QDxGWlFhTVVzQFC2', {
                    "alamat": profileProv.alamat,
                  }).then((value) {
                    profileProv.updateDocumentAdmin('gByywwWZiZP5QDxGWlFhTVVzQFC2', {
                      "alamat": profileProv.alamat,
                    });
                  }).then((value) => Get.back());
                  profileProv.autoValidate = false;
                } else {
                  profileProv.autoValidate = true;
                }
              },
              color: kPrimaryColor,
            ),
          ],
        );
      },
    );
  }


  Future changeNoWADialog({context, profileProv, user, AuthProvider authProv}) {
    return showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Ganti No. WA'),
          content: Form(
            key: profileProv.formKey,
            autovalidate: profileProv.autoValidate,
            child: TextFormFieldWidget(
              validator: profileProv.validateNoHp,
              obscureText: false,
              initialValue: user['noWA'],
              keyboardType: TextInputType.number,
              prefixIcon: Icon(Icons.phone),
              hintText: 'Masukkan No. WA',
              onChanged: (value) => profileProv.noWAChanged(value),
            ),
          ),
          actions: <Widget>[
            FlatButton(
              child: Text('Batal'),
              onPressed: () {
                Get.back();
              },
              color: kGreyColor,
            ),
            FlatButton(
              child: Text('Simpan'),
              onPressed: () {
                if (profileProv.formKey.currentState.validate()) {
                  profileProv.formKey.currentState.save();
                  profileProv.updateDocumentUser('gByywwWZiZP5QDxGWlFhTVVzQFC2', {
                    "noWA": profileProv.noWA,
                  }).then((value) {
                    profileProv.updateDocumentAdmin('gByywwWZiZP5QDxGWlFhTVVzQFC2', {
                      "noWA": profileProv.noWA,
                    });
                  }).then((value) => Get.back());
                  profileProv.autoValidate = false;
                } else {
                  profileProv.autoValidate = true;
                }
              },
              color: kPrimaryColor,
            ),
          ],
        );
      },
    );
  }


  Future changeNoHpDialog({context, profileProv, user, AuthProvider authProv}) {
    return showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Ganti No. Hp'),
          content: Form(
            key: profileProv.formKey,
            autovalidate: profileProv.autoValidate,
            child: TextFormFieldWidget(
              validator: profileProv.validateNoHp,
              obscureText: false,
              initialValue: user['noHp'],
              keyboardType: TextInputType.number,
              prefixIcon: Icon(Icons.phone),
              hintText: 'Masukkan No. Hp',
              onChanged: (value) => profileProv.noHpChanged(value),
            ),
          ),
          actions: <Widget>[
            FlatButton(
              child: Text('Batal'),
              onPressed: () {
                Get.back();
              },
              color: kGreyColor,
            ),
            FlatButton(
              child: Text('Simpan'),
              onPressed: () {
                if (profileProv.formKey.currentState.validate()) {
                  profileProv.formKey.currentState.save();
                  profileProv.updateDocumentUser('gByywwWZiZP5QDxGWlFhTVVzQFC2', {
                    "noHp": profileProv.noHp,
                  }).then((value) {
                    profileProv.updateDocumentAdmin('gByywwWZiZP5QDxGWlFhTVVzQFC2', {
                      "noHp": profileProv.noHp,
                    });
                  }).then((value) => Get.back());
                  profileProv.autoValidate = false;
                } else {
                  profileProv.autoValidate = true;
                }
              },
              color: kPrimaryColor,
            ),
          ],
        );
      },
    );
  }

  Future changeNameDialog(
      {BuildContext context,
      ProfileProvider profileProv,
      user,
      AuthProvider authProv}) {
    return showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Ganti Nama'),
          content: Form(
            key: profileProv.formKey,
            autovalidate: profileProv.autoValidate,
            child: TextFormFieldWidget(
              validator: profileProv.validateText,
              obscureText: false,
              initialValue: user['username'],
              keyboardType: TextInputType.text,
              prefixIcon: Icon(Icons.account_circle),
              hintText: 'Masukkan Nama Lengkap',
              onChanged: (value) => profileProv.usernameChanged(value),
            ),
          ),
          actions: <Widget>[
            FlatButton(
              child: Text('Batal'),
              onPressed: () {
                Get.back();
              },
              color: kGreyColor,
            ),
            FlatButton(
              child: Text('Simpan'),
              onPressed: () {
                if (profileProv.formKey.currentState.validate()) {
                  profileProv.formKey.currentState.save();

                  profileProv.updateDocumentUser('gByywwWZiZP5QDxGWlFhTVVzQFC2', {
                    "username": profileProv.username,
                  }).then((value) {
                    profileProv.updateDocumentAdmin('gByywwWZiZP5QDxGWlFhTVVzQFC2', {
                      "username": profileProv.username,
                    });
                  }).then((value) => Get.back());

                  profileProv.autoValidate = false;
                } else {
                  profileProv.autoValidate = true;
                }
              },
              color: kPrimaryColor,
            ),
          ],
        );
      },
    );
  }

  profileItem({String title, String value, Function onTap}) {
    return GestureDetector(
      onTap: onTap,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Text(
            title,
            style: kDescription,
          ),
          Container(
            width: 150,
            padding: EdgeInsets.all(10),
            decoration: BoxDecoration(
              border: Border.all(),
              borderRadius: BorderRadius.circular(15),
            ),
            child: Text(value ?? '-'),
          )
        ],
      ),
    );
  }
}
