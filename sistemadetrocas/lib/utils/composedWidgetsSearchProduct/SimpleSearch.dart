import 'package:flutter/cupertino.dart';
import 'package:sistemadetrocas/utils/composedWidgets/app_inputText.dart';

class SimpleSearch extends StatelessWidget {
  final _tSimpleSearch = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(4),
      padding: EdgeInsets.all(16),
      child: AppInputText(
        "Pesquisa Simples",
        "Digite o nome do produto",
          _tSimpleSearch,
      ),
    );
  }

}