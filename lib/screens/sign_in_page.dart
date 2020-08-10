import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';

import '../providers/auth_provider.dart';
import '../providers/sign_in_provider.dart';
import '../utils/constants.dart';
import '../widgets/custom_alert_dialog_widget.dart';
import '../widgets/raised_button_widget.dart';
import '../widgets/text_form_field_widget.dart';
import 'sign_up_page.dart';

class SignInPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final signInProv = Provider.of<SignInProvider>(context);
    final authProv = Provider.of<AuthProvider>(context);

    return Scaffold(
      backgroundColor: kBackgroundColor,
      body: authProv.isLoading
          ? CustomAlertDialogWidget(title: 'Mohon tunggu')
          : Container(
              child: SingleChildScrollView(
                padding: EdgeInsets.symmetric(horizontal: 25.0),
                child: Form(
                  key: signInProv.formKey,
                  autovalidate: signInProv.autoValidate,
                  child: Column(
                    children: <Widget>[
                      SizedBox(height: 80.0),
                      Center(
                          child: Image.asset(
                        'assets/images/logo.png',
                        height: 100.0,
                        fit: BoxFit.fitWidth,
                      )),
                      SizedBox(height: 18.0),
                      Text('Selamat datang', style: kHeadline3),
                      SizedBox(height: 12.0),
                      Text('Sign in untuk melanjutkan',
                          style: kDescription.copyWith(color: kGreyColor)),
                      SizedBox(height: 35.0),
                      TextFormFieldWidget(
                        obscureText: false,
                        hintText: 'Alamat email',
                        keyboardType: TextInputType.emailAddress,
                        prefixIcon: Icon(FlutterIcons.mail_fea),
                        validator: signInProv.validateEmail,
                        onChanged: (value) => signInProv.onSavedEmail(value),
                      ),
                      SizedBox(height: 15.0),
                      TextFormFieldWidget(
                          obscureText: true,
                          hintText: 'Password',
                          keyboardType: TextInputType.text,
                          prefixIcon: Icon(FlutterIcons.lock_fea),
                          validator: signInProv.validatePassword,
                          onChanged: (value) =>
                              signInProv.onSavedPassword(value)),
                      SizedBox(height: 15.0),
                      SizedBox(height: 20.0),
                      RaisedButtonWidget(
                        title: 'Sign In',
                        onPressed: () {
                          signInProv.signInPressed(authProv, context);
                        },
                      ),
                      SizedBox(height: 15.0),
                      SizedBox(height: 15.0),
                      Center(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Text(
                              'Tidak punya akun?',
                              style: kDescription.copyWith(color: kGreyColor),
                            ),
                            SizedBox(width: 7.0),
                            GestureDetector(
                              onTap: () {
                                Get.to(SignUpPage());
                              },
                              child: Text(
                                'Daftar',
                                style:
                                    kDescription.copyWith(color: kPrimaryColor),
                              ),
                            )
                          ],
                        ),
                      ),
                      SizedBox(height: 25.0),
                    ],
                  ),
                ),
              ),
            ),
    );
  }
}
