import 'package:flutter/material.dart';

import '../utils/constants.dart';

class TextFormFieldWidget extends StatelessWidget {
  final String hintText;
  final TextInputType keyboardType;
  final bool obscureText;
  final Widget prefixIcon;
  final Function(String) validator;
  final Function onChanged;
  final String initialValue;

  const TextFormFieldWidget({
    Key key,
    this.hintText,
    this.keyboardType,
    this.obscureText,
    this.prefixIcon,
    this.validator,
    this.onChanged,
    this.initialValue,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      cursorColor: kBlackColor,
      obscureText: obscureText,
      keyboardType: keyboardType,
      style: kText,
      autocorrect: false,
      initialValue: initialValue,
      decoration: InputDecoration(
        hintText: hintText,
        hintStyle: kHelperText,
        prefixIcon: prefixIcon,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12.0),
          borderSide: BorderSide(
            color: kGreyColor,
          ),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12.0),
          borderSide: BorderSide(
            color: kGreyColor.withOpacity(.4),
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12.0),
          borderSide: BorderSide(
            color: kSuccessColor,
          ),
        ),
      ),
      validator: validator,
      onChanged: onChanged,
    );
  }
}
