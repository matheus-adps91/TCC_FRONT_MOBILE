import 'package:flutter/material.dart';
import 'package:sistemadetrocas/pages/app_button.dart';
import 'package:sistemadetrocas/pages/app_inputText.dart';

class LoginPage extends StatelessWidget {
  // Fields
  // Armazena o estado atual do formulário
  final _formKey = GlobalKey<FormState>();
  final _tLogin = TextEditingController();
  final _tSenha = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Sistema de Trocas"),
      ),
      body: _body(),
    );
  }

  _body() {
    return Form(
      key: _formKey,
      child: Container(
        margin: EdgeInsets.only(right: 25, left: 25, top: 25),
        padding: EdgeInsets.all(16),
        child: ListView(
          children: <Widget>[
            AppInputText(
              "Login",
              "Formato: usuário@provedor.com",
              TextInputType.emailAddress,
              _tLogin,
              validator: _validateLogin,
            ),
            SizedBox(height: 25),
            AppInputText(
              "Senha",
              "A senha deve conter no mínimo 6 caracteres",
              TextInputType.text,
              _tSenha,
              password: true,
              validator: _validateSenha,
            ),
            SizedBox(height: 25),
            AppButton('Login', Colors.white, 22, Colors.blue, _onClickLogin),
            SizedBox(height: 15),
            AppButton('Nova Conta', Colors.blue, 22, Colors.white,
                _onClickNewAccount),
            SizedBox(height: 15),
            AppButton('Sair', Colors.white, 22, Colors.blue, _onClickExit),
          ],
        ),
      ),
    );
  }

  _onClickLogin() {
    final String login = _tLogin.text;
    final String senha = _tSenha.text;

    final bool formRespValidation = _formKey.currentState.validate();

    if (!formRespValidation) {
      return;
    }
  }

  _onClickNewAccount() {}

  _onClickExit() {}

  String _validateLogin(String value) {
    if (value.isEmpty) {
      return "Login não pode estar em branco";
    }
    if (!value.contains('@')) {
      return "Login inválido";
    }
    return null;
  }

  String _validateSenha(String value) {
    if (value.isEmpty) {
      return "Senha não pode estar em branco";
    }
    if (value.length < 6) {
      return "Senha deve conter pelo menos 6 caracteres";
    }
    if (value.contains(RegExp(r"(\w+)"))) {
      return "Senha deve conster letras e números";
    }
    return null;
  }
}
