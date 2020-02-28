import 'package:flutter/material.dart';
import 'package:sistemadetrocas/model/usuario.dart';
import 'package:sistemadetrocas/pages/api_response.dart';
import 'package:sistemadetrocas/pages/home_page.dart';
import 'package:sistemadetrocas/pages/login_api.dart';
import 'package:sistemadetrocas/utils/app_button.dart';
import 'package:sistemadetrocas/utils/app_inputText.dart';
import 'package:sistemadetrocas/utils/nav.dart';

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
      body: _body(context),
    );
  }

  _body(BuildContext context) {
    return Form(
      key: _formKey,
      child: Container(
        margin: EdgeInsets.only(right: 25, left: 25, top: 25),
        padding: EdgeInsets.all(16),
        child: ListView(
          children: <Widget>[
            AppInputText(
              "Login",
              "usuario@provedor.com",
              TextInputType.emailAddress,
              _tLogin,
              validator: _validateLogin,
            ),
            SizedBox(height: 25),
            AppInputText(
              "Senha",
              "Senha de no mínimo 6 caracteres",
              TextInputType.text,
              _tSenha,
              password: true,
              validator: _validateSenha,
            ),
            SizedBox(height: 25),
            AppButton('Login', Colors.white, 22, Colors.blue,
                () => _onClickLogin(context)),
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

  void _onClickLogin(BuildContext context) async {
    final String login = _tLogin.text;
    final String senha = _tSenha.text;

    final bool formRespValidation = _formKey.currentState.validate();

    if (!formRespValidation) {
      return;
    }

    ApiResponse apiResponse = await LoginAPI.login(login, senha);

    if (apiResponse.userAuthenticated) {
      Usuario usuarioResp = apiResponse.result;
      print(">>> $usuarioResp");
      push(context, HomePage());
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
    if (value.length < 1) {
      return "Senha deve conter pelo menos 6 caracteres";
    }
    return null;
  }
}
