import 'package:flutter/material.dart';

class AppButton extends StatelessWidget {
  // Fields
  final String text;
  final Color textButtonColor;
  final double textFontSize;
  final Color buttonColor;
  final Function onPressed;

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
