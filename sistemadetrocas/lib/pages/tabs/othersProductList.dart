import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sistemadetrocas/model/product.dart';
import 'package:sistemadetrocas/model/productCategory.dart';
import 'package:sistemadetrocas/requests/products/crudProduct_api.dart';
import 'package:sistemadetrocas/utils/composedWidgets/app_button.dart';
import 'package:sistemadetrocas/utils/composedWidgets/app_inputText.dart';

class OthersProduct extends StatefulWidget {

  @override
  _OthersProductState createState() => _OthersProductState();
}

class _OthersProductState extends State<OthersProduct> {
  // Lista de produtos buscado por nome ou por categoria
  List<Product> _searchedProducts;

  // variável para controlar a busca ou por nome ou por categoria
  bool _searchByName = true;

  // Campo default do dropdownbutton
  String dropdownValue = ProductCategory.Categoria;

  // Campo para armazenar o nome do produto
  String _productName;
  TextEditingController _tSearchByName = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: EdgeInsets.all(16),
        child: ListView(
          children: <Widget>[
              Center(
                child: Switch(
                  value: _searchByName,
                  onChanged: updateScreenSearch,
                ),
              ),
            Divider(height: 5.0, thickness: 3.0),
            getWidgetToRender(),
            Center(
              child: AppButton(
                  'PESQUISAR',
                  Colors.white,
                  20.0,
                  Colors.blue,
                      () {
                    _searchByNameOrProdCat();
                  }
              ),
            ),
            Divider(height: 25.0, thickness: 3.0),
            BuildSearchedProducts()
          ],
        ),
      ),
    );
  }

  void updateScreenSearch(bool value) {
    setState(() {
      _searchByName = value;
      _searchedProducts = null;
    });
  }

  Widget getWidgetToRender() {
    return _searchByName ? _getAppInputTextWithFormat() : _getDropdownButton();
  }

  // Verifica se a pesquisa será por nome ou por categoria
  Future<void> _searchByNameOrProdCat() async {
    print('>>> Dentro da função _searchByNameOrProdCat');
    if (_searchByName) {
      _productName = _tSearchByName.text;
      print(_productName);
      if (_productName == null || _productName.length < 3) {
        return;
      }
      List<Product> searchedProducts = await CrudProduct.getProductByName(
          _productName);
      setState(() {
        this._searchedProducts = searchedProducts;
      });
    } else {
      print(dropdownValue);
      if (!_hasNotEqualDefaultValue(dropdownValue)) {
        return;
      }
    }
  }

  // Constrói o input text
  Widget _getAppInputTextWithFormat() {
    return Container(
      padding: EdgeInsets.all(16),
      margin: EdgeInsets.all(4),
      child: AppInputText(
        "Pesquisa por Nome",
        "Digite o nome do produto",
        _tSearchByName,
      ),
    );
  }

  // Constrói o Dropdown button da Categoria de Produto
  DropdownButton<String> _getDropdownButton() {
    return DropdownButton<String>(
      value: dropdownValue,
      icon: Icon(Icons.arrow_downward),
      iconSize: 24,
      style: TextStyle(
          fontSize: 22, fontWeight: FontWeight.w300, color: Colors.black),
      onChanged: (String newProductCategory) {
        setState(() {
          dropdownValue = newProductCategory;
        });
      },
      items: ProductCategory.getAllProductCategories()
          .map<DropdownMenuItem<String>>((String value) {
        return DropdownMenuItem<String>(
          value: value,
          child: Text(value),
        );
      }).toList(),
    );
  }

  // Verifica se a categoria escolhida é diferente da default
  bool _hasNotEqualDefaultValue(String dropdownValue) {
    return dropdownValue.hashCode != ProductCategory.Categoria.hashCode
        ? true : false;
  }

  // Cria a lista de cards com os produtos buscado ou mostra uma mensagem pedindo
  // para fazer a busca, caso ela ainda não tenha sido feita
  Widget BuildSearchedProducts() {
    if (_searchedProducts == null) {
      return Column(
        children: <Widget>[
          Center(
            child: Text(
                'Faça uma busca',
              style: TextStyle(fontSize: 22.0),
            ),
          ),
          Center(
            child: Text(
                'Digite pelo menos 3 letras',
              style: TextStyle(fontSize: 16.0),
            ),
          )
        ],
      );
    }
    if ( _searchedProducts.isEmpty) {
      return Container(
        child: Center(
          child: Text('LISTA VAZIA'),
        ),
      );
    }
    return Container(
      height: 400,
        child:ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: _searchedProducts.length,
          itemBuilder: (context,index) {
            Product currentSearchedProduct = _searchedProducts[index];

            return Card(
              color: Colors.grey[200],
              child: Column(
                children: <Widget>[
                  Container(
                      height: 250,
                      width: 250,
                      child: Image.network(currentSearchedProduct.gImgPath)),
                  spaceBetweenElements(y:5.0),
                  Center(
                    child:Text(currentSearchedProduct.gName, style: TextStyle(fontSize: 22),),
                  ),
                  spaceBetweenElements(y:10.0),
                  Text(currentSearchedProduct.gDesc, style: TextStyle(fontSize: 18),),
                  spaceBetweenElements(y:10.0),
                  Center(
                    child: AppButton(
                      'TROCAR', Colors.blue, 16.0, Colors.white, () {
                        _onClickSendDeal();
                    }
                    ),
                  )
                ],
              ),
            );
          },
        )
    );
  }

  // Espaço entre elementos do ListView do formulário de SignUp
  SizedBox spaceBetweenElements({double y = 0, double x = 0}) {
    return SizedBox(height: y, width: x);
  }

  void _onClickSendDeal() {
    print ('>>> Dentro da função _onClickSendDeal');
  }
}