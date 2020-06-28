import 'package:flutter/material.dart';

class AppConfirmOperation {
  // Fields
  String title;
  String content;
  BuildContext context;

  // Constructor
  AppConfirmOperation(
    this.title,
    this.content,
    this.context,
  );

  // Constrói o diálogo de alerta e pega a resposta de exclusão do usuário
  Future<bool> buildAlertConfirm() async {
    print('>>> Dentro da função buildAlertConfirm');
    return showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text(title),
            content: Text(content),
            actions: <Widget>[
              FlatButton(
                child: Text('SIM'),
                onPressed: _confirmedOperation,
              ),
              FlatButton(
                child: Text('CANCELAR'),
                onPressed: _cancelledOperation,
              )
            ],
          );
        });
  }

  void _confirmedOperation() {
    final bool result = true;
    Navigator.pop(context, result);
  }

  void _cancelledOperation() {
    final bool result = false;
    Navigator.pop(context, result);
  }
}
