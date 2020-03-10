import 'package:flutter/material.dart';

class AppFormField extends StatelessWidget {
  // Field
  String property;
  TextEditingController controller;
  FormFieldValidator<String> validator;
  TextInputType keyboardType;
  TextInputAction keyboardAction;
  bool password;
  bool autoFocus;
  FocusNode nextFocus;

  // Constructor
  AppFormField(
    this.property,
    this.controller, {
    this.autoFocus = false,
    this.nextFocus,
    this.validator,
    this.keyboardType = TextInputType.text,
    this.keyboardAction = TextInputAction.next,
    this.password = false,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 100,
      child: TextFormField(
        autofocus: autoFocus,
        controller: controller,
        keyboardType: keyboardType,
        textInputAction: keyboardAction,
        validator: validator,
        obscureText: password,
        decoration: InputDecoration(
          labelText: property,
          labelStyle: TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.w300,
          ),
        ),
      ),
    );
  }
}
