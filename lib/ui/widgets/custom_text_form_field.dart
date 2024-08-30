import 'package:flutter/material.dart';

typedef Validator = String? Function(String?);

class CustomTextFormField extends StatelessWidget {
  String? hitText;
  TextInputType keyboardType;
  Validator? validator;
  TextEditingController? controller;

  bool isSecureText;
  IconButton? iconButton;
  String? label;
  int? numberOfLines;

  CustomTextFormField(
      {this.hitText,
      this.keyboardType = TextInputType.text,
      this.validator,
      this.controller,
      this.isSecureText = false,
      this.iconButton,
      this.label,
      this.numberOfLines});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      // maxLines: numberOfLines,
      //minLines: numberOfLines,
      obscureText: isSecureText,
      controller: controller,
      validator: validator,
      keyboardType: keyboardType,
      decoration: InputDecoration(
        suffixIcon: iconButton,
        hintText: hitText,
        labelText: label,
        hintStyle: TextStyle(
          fontSize: 12,
        ),
        fillColor: Colors.white,
        filled: true,
        enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(22),
            borderSide: BorderSide(
              color: Colors.grey,
              width: 2,
            )),
        focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(22),
            borderSide: BorderSide(
              color: Colors.blue,
              width: 2,
            )),
        errorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(22),
            borderSide: BorderSide(
              color: Colors.red,
              width: 2,
            )),
        border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(22),
            borderSide: BorderSide(
              color: Colors.red,
              width: 2,
            )),

      ),
    );
  }
}
