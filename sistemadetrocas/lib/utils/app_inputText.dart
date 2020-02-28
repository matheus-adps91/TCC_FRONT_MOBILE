import 'package:flutter/material.dart';

class AppInputText extends StatelessWidget {
  // Fields
  String textTitle;
  String textHint;
  TextInputType keyboardType;
  TextEditingController controller;
  bool password;
  FormFieldValidator<String> validator;

  // Constructor
  AppInputText(
    this.textTitle,
    this.textHint,
    this.keyboardType,
    this.controller, {
    this.password = false,
    this.validator,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      keyboardType: keyboardType,
      obscureText: password,
      validator: validator,
      decoration: InputDecoration(
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
        ),
        labelText: textTitle,
        labelStyle: TextStyle(fontSize: 26),
        hintText: textHint,
        hintStyle: TextStyle(fontSize: 18),
      ),
    );
  }
}
