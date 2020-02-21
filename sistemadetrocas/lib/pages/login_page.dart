import 'package:flutter/material.dart';

class LoginPage extends StatelessWidget {
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
    return Container(
      padding: EdgeInsets.all(16),
      child: ListView(
        children: <Widget>[
          Text('Login'),
          TextFormField(),
          Text('Senha'),
          TextFormField(
            obscureText: true,
          ),
          SizedBox(
            height: 30,
          ),
          Container(
            height: 46,
            child: RaisedButton(
              color: Colors.blue,
              child: Text(
                'Login',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 22,
                ),
              ),
              onPressed: () {},
            ),
          )
        ],
      ),
    );
  }
}
