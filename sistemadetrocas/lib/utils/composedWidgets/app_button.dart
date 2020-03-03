import 'package:flutter/material.dart';

class AppButton extends StatelessWidget {
  // Fields
  String text;
  Color textButtonColor;
  double textFontSize;
  Color buttonColor;
  Function onPressed;

  // Constructor
  AppButton(
    this.text,
    this.textButtonColor,
    this.textFontSize,
    this.buttonColor,
    this.onPressed,
  );

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 46,
      child: RaisedButton(
        color: buttonColor,
        child: Text(
          text,
          style: TextStyle(
            color: textButtonColor,
            fontSize: textFontSize,
          ),
        ),
        onPressed: onPressed,
      ),
    );
  }
}
