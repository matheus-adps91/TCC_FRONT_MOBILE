import 'package:flutter/material.dart';

class AppFormField extends StatelessWidget {
  // Field
  String property;

  // Constructor
  AppFormField(this.property);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.yellow,
      child: TextFormField(
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
