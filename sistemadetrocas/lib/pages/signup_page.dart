import 'package:flutter/material.dart';

class SignupPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Página de Cadastro'),
      ),
      body: _body(),
    );
  }

  _body() {
    return Center(
      child: Text('Página de Cadastro'),
    );
  }
}
