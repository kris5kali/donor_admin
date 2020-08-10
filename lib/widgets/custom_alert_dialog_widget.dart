import 'package:flutter/material.dart';

import '../utils/constants.dart';
import '../utils/screens.dart';

class CustomAlertDialogWidget extends StatelessWidget {
  final String title;

  const CustomAlertDialogWidget({Key key, @required this.title})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: Screen.width(context),
      height: Screen.heigth(context),
      color: Colors.black45,
      child: Center(
        child: SizedBox(
          width: double.infinity,
          height: 80.0,
          child: Card(
            margin: const EdgeInsets.symmetric(horizontal: 25.0),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15.0),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  CircularProgressIndicator(),
                  SizedBox(width: 12.0),
                  Text(title, style: kHeadline3)
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
