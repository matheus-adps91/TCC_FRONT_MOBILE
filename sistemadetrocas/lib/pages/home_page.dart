import 'package:flutter/material.dart';
import 'package:sistemadetrocas/infrastructure/api_entityResponse.dart';
import 'package:sistemadetrocas/utils/composedWidgets/app_alert.dart';
import 'package:sistemadetrocas/utils/composedWidgets/app_button.dart';

import 'package:sistemadetrocas/requests/logout_api.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Página Inicial'),
      ),
      body: _body(context),
    );
  }

  _body(BuildContext context) {
    return Center(
      child: AppButton(
        'SAIR',
        Colors.white,
        18,
        Colors.blue,
        () => _onClickLogout(context),
      ),
    );
  }

  _onClickLogout(BuildContext context) async {
    ApiEntityResponse apiEntityResponse = await LogoutAPI.logout();
    AppAlert(
      apiEntityResponse.actionMsg,
      apiEntityResponse.textButton,
      apiEntityResponse.actionPerformed,
      context,
    ).buildAlert();
  }
}
