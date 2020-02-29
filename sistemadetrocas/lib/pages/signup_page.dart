import 'package:flutter/material.dart';
import 'package:sistemadetrocas/utils/app_formField.dart';

enum GenderType {
  masculino,
  feminino,
}

class SignupPage extends StatefulWidget {
  @override
  _SignupPageState createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  GenderType _genderSelected = GenderType.masculino;

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
    return Container(
        padding: EdgeInsets.only(top: 20, left: 30, right: 30),
        child: ListView(
          children: <Widget>[
            AppFormField(
              "Nome Completo",
            ),
            SizedBox(height: 15),
            AppFormField(
              "Email",
            ),
            SizedBox(height: 15),
            AppFormField(
              "Password",
            ),
            SizedBox(height: 15),
            Row(
              children: <Widget>[
                Container(
                  child: Radio<GenderType>(
                    value: GenderType.masculino,
                    groupValue: _genderSelected,
                    onChanged: updateGender,
                  ),
                ),
                Container(
                  child: Radio<GenderType>(
                    value: GenderType.feminino,
                    groupValue: _genderSelected,
                    onChanged: updateGender,
                  ),
                )
              ],
            ),
          ],
        ));
  }

  void updateGender(GenderType newValue) {
    setState(() {
      _genderSelected = newValue;
    });
  }
}
