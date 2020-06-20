import 'package:flutter/material.dart';
import 'package:sistemadetrocas/infrastructure/api_entityResponse.dart';
import 'package:sistemadetrocas/pages/loginForm_page.dart';
import 'package:sistemadetrocas/requests/logout_api.dart';

import 'app_alert.dart';

class  AppDrawer extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        children: <Widget>[
          ListTile(
            leading: Icon(Icons.person),
            title: Text('Dados Cadastrais'),
            trailing: Icon(Icons.arrow_forward),
          ),
          ListTile(
            leading: Icon(Icons.chat),
            title: Text('Chat'),
            trailing: Icon(Icons.arrow_forward),
          ),
          ListTile(
            leading: Icon(Icons.exit_to_app),
            title: Text('Sair do App'),
            trailing: Icon(Icons.arrow_forward),
            onTap: () {
              Navigator
                  .of(context)
                  .pushAndRemoveUntil(
                  MaterialPageRoute(
                    builder:  (BuildContext context) => LoginPage(),
                  ),
                  (Route route) => false);
              _onClickLogout(context);
            },
          )
        ],
      ),
    );
  }

  _onClickLogout(BuildContext context) async {
    ApiEntityResponse apiEntityResponse = await LogoutAPI.logout();
    AppAlert(
        apiEntityResponse.actionMsg,
        apiEntityResponse.textButton,
        context,
        true
    ).buildAlert();
  }
}