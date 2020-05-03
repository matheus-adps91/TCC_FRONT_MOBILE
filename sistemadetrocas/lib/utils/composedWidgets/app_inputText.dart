import 'package:flutter/material.dart';

class AppInputText extends StatelessWidget {
  // Fields
  final String textTitle;
  final String textHint;
  final TextInputType keyboardType;
  final TextInputAction keyboardAction;
  final TextEditingController controller;
  final bool password;
  final FormFieldValidator<String> validator;

  // Constructor
  AppInputText(
    this.textTitle,
    this.textHint,
    this.controller, {
    this.keyboardType = TextInputType.text,
    this.keyboardAction = TextInputAction.next,
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
