import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AppSnackBarMessage {
  BuildContext context;
  String message;
  IconData icons;
  Color backgroundColor;

  AppSnackBarMessage(
      this.context,
      this.message,
      this.icons,
      { this.backgroundColor : Colors.blue}
      );

  // Constrói a snackbar no bottom da tela informando que o produto foi deletado
  buildSnackBarMessage() {
    Scaffold.of(context).showSnackBar(
      SnackBar(
        backgroundColor: backgroundColor,
        elevation: 9.0,
        duration: Duration(milliseconds: 2500),
        content: Row(
          children: <Widget>[
            Expanded(child: Text(message,style: TextStyle(fontSize: 18),)),
            Icon(
              icons,
              color: Colors.white,
            )
          ],
        ),
      ),
    );
  }

}
