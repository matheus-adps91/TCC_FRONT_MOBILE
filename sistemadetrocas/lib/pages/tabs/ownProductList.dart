import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sistemadetrocas/model/product.dart';
import 'package:sistemadetrocas/pages/product/productForm_page.dart';
import 'package:sistemadetrocas/requests/products/crudProduct_api.dart';
import 'package:sistemadetrocas/utils/composedWidgets/app_button.dart';
import 'package:sistemadetrocas/utils/nav.dart';

class OwnProducts extends StatefulWidget {
  Product product;

  @override
  _OwnProductsState createState() => _OwnProductsState();
}

class _OwnProductsState extends State<OwnProducts> {
  List<Product> _products;

  @override
  void initState() {
    super.initState();
    _loadProducts();
  }

  _loadProducts() async {
    List<Product> products = await CrudProduct.getProducts();
    setState(() {
      this._products = products;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _body(),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          push(context, CreateProduct());
        },
        child: Icon(Icons.add),
      ),
    );
  }

  _body() {
    if (_products == null) {
      return Container(
        child: Center(
          child: CircularProgressIndicator(),
        ),
      );
    }

    if (_products.length == 0) {
      return Container(
        child: Center(
          child: Text(
            'Não há produtos cadastrados',
            style: TextStyle(fontSize: 20),
          ),
        ),
      );
    }
    return Container(
      padding: EdgeInsets.all(16),
      child: ListView.builder(
        itemCount: _products.length,
        itemBuilder: (context, index) {
          Product currentProduct = _products[index];

          return Card(
            color: Colors.grey[200],
            child: Column(
              children: <Widget>[
                Image.network(
                  currentProduct.imagePath,
                  loadingBuilder: (context, child, progress) {
                    return progress == null
                        ? child
                        : Center(
                            child: LinearProgressIndicator(
                                backgroundColor: Colors.blue));
                  },
                ),
                Text(
                  currentProduct.gName,
                  style: TextStyle(fontSize: 24),
                ),
                ButtonBar(
                  alignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    AppButton('DETALHES', Colors.blue, 20.0, Colors.white,
                        _onClickDetail),
                    AppButton('EXCLUIR', Colors.blue, 20.0, Colors.white,
                        () {
                         _shouldDeleteProduct(currentProduct);
                        })
                  ],
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  _shouldDeleteProduct(Product product ) async {
    print('>>> Dentro da função _shouldDeleteProduct');
    final bool shouldDelete = await _onClickDeleteProduct();
    if ( shouldDelete ) {
      CrudProduct.deleteProduct(product);
      setState(() {
        this._products.remove(product);
      });
    }

  }

  _onClickDetail() {
    print('teste');
  }

  // Constrói o diálogo de alerta e pega a resposta de exclusão do usuário
  Future<bool> _onClickDeleteProduct() async {
    print('>>> Dentro da função _onClickDeleteProduct');
    return showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) {
          return AlertDialog(
            title: Text('Excluir'),
            content: Text('Deseja excluir este item?'),
            actions: <Widget>[
              FlatButton(
                child: Text('OK'),
                onPressed: _confirmedDeleted,
              ),
              FlatButton(
                child: Text('CANCELAR'),
                onPressed: _cancelledDeleted,
              )
            ],
          );
        });
  }

  void _confirmedDeleted() {
    final bool result = true;
    Navigator.pop(context, result);
  }

  void _cancelledDeleted() {
    final bool result = false;
    Navigator.pop(context, result);
  }
}
