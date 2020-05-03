import 'package:flutter/material.dart';
import 'package:sistemadetrocas/pages/home_page.dart';
import 'package:sistemadetrocas/pages/loginForm_page.dart';
import 'package:sistemadetrocas/requests/products/crudProduct_api.dart';
import 'package:sistemadetrocas/utils/nav.dart';

class AppAlert {
  // Fields
  String description;
  String buttonText;
  bool status;
  BuildContext context;

  // Constructor
  AppAlert(
    this.description,
    this.buttonText,
    this.context,
    this.status,
  );

  // Método para construir o alert
  buildAlert() {
    print('dentro do buildAlert()');
    showDialog(
      context: context,
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

  buildAlertCreatingProduct() {
    print('dentro do buildAlertCreatingProduct()');
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Sistema de Trocas'),
          content: Text(description),
          actions: <Widget>[
            FlatButton(
              child: Text(buttonText),
              onPressed: () {
                if ( status ) {
                  push(context, HomePage(), replace: true);
                }
              },
            )
          ],
        );
      }
    );
  }
}
