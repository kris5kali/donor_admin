import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';

import '../providers/auth_provider.dart';
import '../providers/sign_up_provider.dart';
import '../utils/constants.dart';
import '../widgets/custom_alert_dialog_widget.dart';
import '../widgets/raised_button_widget.dart';
import '../widgets/text_form_field_widget.dart';

class SignUpPage extends StatefulWidget {
  @override
  _SignUpPageState createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  @override
  Widget build(BuildContext context) {
    final signUpProv = Provider.of<SignUpProvider>(context);
    final authProv = Provider.of<AuthProvider>(context);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: kBackgroundColor,
        elevation: 0.0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          color: kBlackColor,
          onPressed: () {
            Get.back();
          },
        ),
      ),
      body: authProv.isLoading
          ? CustomAlertDialogWidget(
              title: 'Sedang membuat akun',
            )
          : Container(
              child: SingleChildScrollView(
                padding: EdgeInsets.symmetric(horizontal: 25.0),
                child: Form(
                  key: signUpProv.formKey,
                  autovalidate: signUpProv.autoValidate,
                  child: Column(
                    children: <Widget>[
                      SizedBox(height: 18.0),
                      Text(
                        'ADMIN DONOR',
                        style: kHeadline3,
                        textAlign: TextAlign.center,
                      ),
                      SizedBox(height: 12.0),
                      Text('Buat akun baru',
                          style: kDescription.copyWith(color: kGreyColor)),
                      SizedBox(height: 35.0),
                      TextFormFieldWidget(
                        obscureText: false,
                        hintText: 'Nama Lengkap',
                        keyboardType: TextInputType.text,
                        prefixIcon: Icon(FlutterIcons.user_fea),
                        validator: signUpProv.validateUsername,
                        onChanged: (value) => signUpProv.onSavedUsername(value),
                      ),
                      SizedBox(height: 15.0),
                      TextFormFieldWidget(
                        obscureText: false,
                        hintText: 'Alamat Email',
                        keyboardType: TextInputType.emailAddress,
                        prefixIcon: Icon(FlutterIcons.mail_fea),
                        validator: signUpProv.validateEmail,
                        onChanged: (value) => signUpProv.onSavedEmail(value),
                      ),
                      SizedBox(height: 15.0),
                      TextFormFieldWidget(
                        obscureText: true,
                        hintText: 'Password',
                        keyboardType: TextInputType.text,
                        prefixIcon: Icon(FlutterIcons.lock_fea),
                        validator: signUpProv.validatePassword,
                        onChanged: (value) => signUpProv.onSavedPassword(value),
                      ),
                      SizedBox(height: 20.0),
                      RaisedButtonWidget(
                        title: 'Sign Up',
                        onPressed: () {
                          signUpProv.signUpPressed(authProv, context);
                        },
                      ),
                      SizedBox(height: 15.0),
                      Center(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Text(
                              'Sudah punya akun?',
                              style: kDescription.copyWith(color: kGreyColor),
                            ),
                            SizedBox(width: 7.0),
                            GestureDetector(
                              onTap: () {
                                Get.back();
                              },
                              child: Text(
                                'Sign In',
                                style:
                                    kDescription.copyWith(color: kPrimaryColor),
                              ),
                            )
                          ],
                        ),
                      ),
                      SizedBox(height: 15.0),
                    ],
                  ),
                ),
              ),
            ),
    );
  }
}
