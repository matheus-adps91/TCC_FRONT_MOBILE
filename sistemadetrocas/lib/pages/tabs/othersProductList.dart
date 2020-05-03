import 'package:flutter/material.dart';
import 'package:sistemadetrocas/utils/composedWidgetsSearchProduct/ComposedSearch.dart';
import 'package:sistemadetrocas/utils/composedWidgetsSearchProduct/SimpleSearch.dart';

class OthersProduct extends StatefulWidget {
  // variável para controlar a busca ou por simples ou composta
  @override
  _OthersProductState createState() => _OthersProductState();
}

class _OthersProductState extends State<OthersProduct> {
  bool _searchByName = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: <Widget>[
          Flexible(
            child: Switch(
              value: _searchByName,
              onChanged: updateScreenSearch,
            ),
          ),
          Divider(height: 5.0),
          getScreenToRender(),
        ],
      ),
    );
  }

  void updateScreenSearch(bool value) {
    setState(() {
      _searchByName = value;
    });
  }

  Widget getScreenToRender () {
    return _searchByName ? SimpleSearch() : ComposedSearch();
  }

}