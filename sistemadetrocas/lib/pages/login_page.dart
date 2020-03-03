import 'package:flutter/material.dart';
import 'package:sistemadetrocas/infrastructure/api_response.dart';
import 'package:sistemadetrocas/model/usuario.dart';
import 'package:sistemadetrocas/pages/home_page.dart';
import 'package:sistemadetrocas/pages/signup_page.dart';
import 'package:sistemadetrocas/requests/login_api.dart';
import 'package:sistemadetrocas/utils/composedWidgets/app_button.dart';
import 'package:sistemadetrocas/utils/composedWidgets/app_inputText.dart';
import 'package:sistemadetrocas/utils/nav.dart';
import 'package:sistemadetrocas/utils/validation.dart';

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
            AppInputText("Login", "usuario@provedor.com", _tLogin,
                keyboardType: TextInputType.emailAddress,
                validator: Validation.validateLogin),
            SizedBox(height: 25),
            AppInputText("Senha", "Senha de no mínimo 4 caracteres", _tSenha,
                keyboardAction: TextInputAction.done,
                password: true,
                validator: Validation.validatePassword),
            SizedBox(height: 25),
            AppButton('Login', Colors.white, 22, Colors.blue,
                () => _onClickLogin(context)),
            SizedBox(height: 15),
            AppButton('Recuperar Senha', Colors.blue, 20, Colors.white,
                _onClickNewPassword),
            SizedBox(height: 15),
            AppButton('Nova Conta', Colors.white, 22, Colors.blue,
                () => _onClickNewAccount(context)),
            SizedBox(height: 15),
            AppButton('Sair', Colors.blue, 22, Colors.white, _onClickExit),
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

  _onClickNewAccount(BuildContext context) {
    push(context, SignupPage());
  }

  _onClickNewPassword() {}

  _onClickExit() {}
}
