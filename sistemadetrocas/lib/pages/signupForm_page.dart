import 'package:flutter/material.dart';
import 'package:sistemadetrocas/infrastructure/api_entityResponse.dart';
import 'package:sistemadetrocas/model/signupUser.dart';
import 'package:sistemadetrocas/requests/users/crudUser_api.dart';
import 'package:sistemadetrocas/utils/composedWidgets/app_alert.dart';
import 'package:sistemadetrocas/utils/composedWidgets/app_button.dart';
import 'package:sistemadetrocas/utils/composedWidgets/app_formField.dart';
import 'package:sistemadetrocas/utils/validation.dart';

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
  bool _compliance = false;
  // Variável global para armazenar o estado da aplicação
  final _formSignUpkey = GlobalKey<FormState>();

  // Controllers para os campos do formulário
  final _tFullName = TextEditingController();
  final _tEmail = TextEditingController();
  final _tPass = TextEditingController();
  final _tConfirmPass = TextEditingController();
  final _tZipCode = TextEditingController();
  final _tState = TextEditingController();
  final _tCity = TextEditingController();
  final _tStreet = TextEditingController();
  final _tHouseNumber = TextEditingController();
  final _tComplement = TextEditingController();

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
    return Form(
      key: _formSignUpkey,
      child: Container(
          padding: EdgeInsets.only(top: 20, left: 30, right: 30),
          child: ListView(
            children: <Widget>[
              AppFormField("Nome Completo", _tFullName,
                  validator: Validation.validateFullName),
              spaceBetweenElements(y: 15),
              AppFormField("Email", _tEmail,
                  validator: Validation.validateLogin,
                  keyboardType: TextInputType.emailAddress),
              spaceBetweenElements(y: 15),
              AppFormField("Password", _tPass,
                  validator: Validation.validatePassword, password: true),
              spaceBetweenElements(y: 15),
              AppFormField("Confirm Password", _tConfirmPass,
                  validator: Validation.validatePassword, password: true),
              spaceBetweenElements(y: 15),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: <Widget>[
                  drawRadioButton(GenderType.masculino),
                  drawTextRadioButton("Masculino"),
                  spaceBetweenElements(y: 15),
                  drawRadioButton(GenderType.feminino),
                  drawTextRadioButton("Feminino"),
                ],
              ),
              spaceBetweenElements(y: 15.0),
              AppFormField("Código Postal", _tZipCode,
                  validator: Validation.validateZipCode,
                  keyboardType: TextInputType.number),
              spaceBetweenElements(y: 15.0),
              AppFormField("Estado", _tState,
                  validator: Validation.defaultValidation),
              spaceBetweenElements(y: 15.0),
              AppFormField("Cidade", _tCity,
                  validator: Validation.defaultValidation),
              spaceBetweenElements(y: 15.0),
              AppFormField("Rua", _tStreet,
                  validator: Validation.defaultValidation),
              spaceBetweenElements(y: 15.0),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  AppFormField("Número", _tHouseNumber,
                      validator: Validation.defaultValidation,
                      keyboardType: TextInputType.number),
                  spaceBetweenElements(x: 5.0),
                  AppFormField("Compl.", _tComplement,
                      validator: Validation.defaultValidation)
                ],
              ),
              spaceBetweenElements(y: 15.0),
              drawCheckButton(),
              spaceBetweenElements(y: 30.0),
              AppButton('Cadastrar', Colors.white, 22, Colors.blue,
                  () => _onClickSignup(context)),
              spaceBetweenElements(y: 30.0),
            ],
          )),
    );
  }

  // Espaço entre elementos do ListView do formulário de SignUp
  SizedBox spaceBetweenElements({double y = 0, double x = 0}) {
    return SizedBox(height: y, width: x);
  }

  // Desenha o texto que acompanha o botão rádio
  Text drawTextRadioButton(String text) {
    return Text(
      text,
      textAlign: TextAlign.center,
      style: TextStyle(fontSize: 18),
    );
  }

  // Desenha SOMENTE o botão rádio para cada tipo de gênero
  Container drawRadioButton(GenderType type) {
    return Container(
      child: Radio<GenderType>(
        value: type,
        groupValue: _genderSelected,
        onChanged: _updateGender,
      ),
    );
  }

  // Atualiza o gênero
  // NOTA: a tela é redesenhada pelo SETSTATE
  void _updateGender(GenderType newValue) {
    setState(() {
      _genderSelected = newValue;
    });
  }

  // Get no valor do enum do gender
  static String _getValue(GenderType genderType) {
    return genderType.toString().split('.').last;
  }

  // Desenha o botão check mais o texto
  Container drawCheckButton() {
    return Container(
      child: CheckboxListTile(
        title: const Text("De acordo com as políticas do app"),
        value: _compliance,
        onChanged: _updateCompliance,
      ),
    );
  }

  // Atualiza o check
  // NOTA: a tela é redesenhada pelo SETSTATE
  void _updateCompliance(bool value) {
    setState(() {
      _compliance = value;
    });
  }

  void _onClickSignup(BuildContext context) async {
    print('>>> FUNÇÃO: _onClickSignup');
    final String fullName = _tFullName.text;
    final String email = _tEmail.text;
    final String password = _tPass.text;
    final String confirmPassword = _tConfirmPass.text;
    final String gender = _getValue(_genderSelected);
    final String zipCode = _tZipCode.text;
    final String state = _tState.text;
    final String city = _tCity.text;
    final String address = _tStreet.text;
    final String houseNumber = _tHouseNumber.text;
    final String complement = _tComplement.text;

    final bool formRespValidation = _formSignUpkey.currentState.validate();

    if (!formRespValidation) {
      return;
    }

    // FALTA UM IF AQUI
    Validation.validateConfirmPassword(password, confirmPassword);

    SignupUser signupUser = SignupUser(
        email: email,
        password: password,
        fullName: fullName,
        gender: gender,
        address: address,
        houseNumber: houseNumber,
        state: state,
        city: city,
        zipCode: zipCode,
        complement: complement,
        compliance: _compliance);
    ApiEntityResponse apiResponse = await CrudUser.create(signupUser);

    AppAlert appAlert = AppAlert(
      apiResponse.actionMsg,
      apiResponse.textButton,
      context,
      apiResponse.status
    );
    appAlert.buildAlert();
  }

}
