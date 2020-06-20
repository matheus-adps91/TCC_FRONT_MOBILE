import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sistemadetrocas/model/product.dart';
import 'package:sistemadetrocas/model/productCategory.dart';
import 'package:sistemadetrocas/requests/preDeals/crudPreDeals_api.dart';
import 'package:sistemadetrocas/requests/products/crudProduct_api.dart';
import 'package:sistemadetrocas/utils/composedWidgets/app_button.dart';
import 'package:sistemadetrocas/utils/composedWidgets/app_confirmOperation.dart';
import 'package:sistemadetrocas/utils/composedWidgets/app_inputText.dart';
import 'package:sistemadetrocas/utils/composedWidgets/app_snackBarMessage.dart';

class OthersProduct extends StatefulWidget {

  @override
  _OthersProductState createState() => _OthersProductState();
}

class _OthersProductState extends State<OthersProduct> {
  // Lista dos meus produtos
  List<Product> _myProducts;
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
  void initState() {
    super.initState();
    _loadProducts();
  }

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
            Center(child: getWidgetToRender()),
            Center(
              child: AppButton(
                  'Pesquisar',
                  Colors.white,
                  20.0,
                  Colors.blue,
                      () {
                    _searchByNameOrProdCat();
                  }
              ),
            ),
            Divider(height: 25.0, thickness: 3.0),
            buildSearchedProducts()
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
      List<Product> searchedProductsByName = await CrudProduct.getProductByName(
          _productName);
      setState(() {
        this._searchedProducts = searchedProductsByName;
      });
    } else {
      print(dropdownValue);
      if (!_hasNotEqualDefaultValue(dropdownValue)) {
        return;
      }
      List<Product> searchedProductsByCategory = await CrudProduct.getProductByCategory(dropdownValue);
      setState(() {
        this._searchedProducts = searchedProductsByCategory;
      });
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
  Widget buildSearchedProducts() {
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
                _getTextActingLikeHint(),
              style: TextStyle(fontSize: 16.0),
            ),
          )
        ],
      );
    }
    if ( _searchedProducts.isEmpty) {
      return Container(
        child: Center(
          child: Text('Produto(s) não encontrado(s)',
          style: TextStyle(fontSize: 22.0),),
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
                      'Trocar', Colors.blue, 16.0, Colors.white, () {
                        _onClickMakeDeal(currentSearchedProduct);
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

  // Abre o bottomSheet para o usuário escolher seu produto
  void _onClickMakeDeal(Product currentSearchedProduct) {
    print ('>>> Dentro da função _onClickSendDeal');
    showModalBottomSheet(context: context, builder: (BuildContext buildContext) {
      return Container(
        height: 400,
        color: Colors.blue,
        child: Center(
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: _myProducts.length,
            itemBuilder: (context, index){
              Product myCurrentProduct = _myProducts[index];

              return Card(
                color: Colors.grey[200],
                child: Column(
                  children: <Widget>[
                    Container(
                      height: 250,
                      width: 250,
                      child: Image.network(myCurrentProduct.gImgPath),
                    ),
                    spaceBetweenElements(y:10),
                    Text(myCurrentProduct.gName, style: TextStyle(fontSize: 22.0),),
                    spaceBetweenElements(y:10),
                    Center(
                      child: AppButton(
                        'Propor Troca', Colors.white, 16.0, Colors.blue, () {
                          _onClickSendDeal(myCurrentProduct, currentSearchedProduct);
                        }
                      ),
                    )
                  ],
                ),
              );
            },
          ),
        ),
      );
    });
  }

  // Busca os meus produtos na API
  void _loadProducts() async {
    _myProducts = await CrudProduct.getProducts();
  }

  String _getTextActingLikeHint() {
    return _searchByName ? 'Digite pelo menos 3 letras': 'Selecione uma categoria diferente da padrão';
  }

  Future<void> _onClickSendDeal(Product myProduct, Product desiredProduct) async {
    print('>>> Dentro da função _onClickSendDeal');
    var appConfirmOperation = AppConfirmOperation(
      'Propor Troca', 'Confirmar a proposta de troca?', context
    );

    final bool shouldProposeDeal = await appConfirmOperation.buildAlertConfirm();
    if (!shouldProposeDeal) {
      return;
    }
    print(myProduct);
    print(desiredProduct);
    CrudPreDeal.create(myProduct, desiredProduct);

    var appSnackBarMessage = AppSnackBarMessage(context, 'Proposta enviada', Icons.thumbs_up_down);
    appSnackBarMessage.buildSnackBarMessage();
    Navigator.pop(context);
  }

}