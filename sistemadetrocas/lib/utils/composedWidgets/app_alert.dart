import 'package:flutter/material.dart';
import 'package:sistemadetrocas/pages/login_page.dart';
import 'package:sistemadetrocas/utils/nav.dart';

class AppAlert {
  // Fields
  String description;
  String buttonText;
  bool status;
  BuildContext signupContext;

  // Constructor
  AppAlert(
    this.description,
    this.buttonText,
    this.status,
    this.signupContext,
  );

  // Método para construir o alert
  buildAlert() {
    print('dentro do build alert');
    showDialog(
      context: signupContext,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Sistema de Trocas'),
          content: Text(description),
          actions: <Widget>[
            FlatButton(
              child: Text(buttonText),
              onPressed: () {
                if (status) {
                  push(context, LoginPage(), replace: true);
                } else {
                  pop(context);
                }
              },
            ),
          ],
        );
      },
    );
  }
}
