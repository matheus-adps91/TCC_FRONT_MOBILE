import 'package:flutter/material.dart';

class AppFormField extends StatelessWidget {
  // Field
  final String property;
  final TextEditingController controller;
  final FormFieldValidator<String> validator;
  final TextInputType keyboardType;
  final TextInputAction keyboardAction;
  final bool password;
  final bool autoFocus;
  final FocusNode nextFocus;

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
            color: Colors.black,
          ),
        ),
      ),
    );
  }
}
