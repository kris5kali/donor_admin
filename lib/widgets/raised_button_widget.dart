import 'package:flutter/material.dart';

import '../utils/constants.dart';
import '../utils/screens.dart';

class RaisedButtonWidget extends StatelessWidget {
  final String title;
  final Function onPressed;

  const RaisedButtonWidget(
      {Key key, @required this.title, @required this.onPressed})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      width: Screen.width(context),
      height: 50.0,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(30.0),
        boxShadow: <BoxShadow>[
          BoxShadow(
            color: kPrimaryColor.withOpacity(0.4),
            blurRadius: 5,
            offset: Offset(0, 5),
          ),
        ],
      ),
      child: RaisedButton(
        onPressed: onPressed,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30.0),
        ),
        color: kPrimaryColor,
        child: Center(
          child: Text(
            title,
            style: kText.copyWith(color: Colors.white),
          ),
        ),
      ),
    );
  }
}
