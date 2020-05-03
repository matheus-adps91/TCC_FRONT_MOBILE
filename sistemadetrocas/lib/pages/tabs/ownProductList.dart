

import 'package:flutter/material.dart';
import 'package:sistemadetrocas/model/product.dart';
import 'package:sistemadetrocas/pages/product/productForm_page.dart';
import 'package:sistemadetrocas/requests/products/crudProduct_api.dart';
import 'package:sistemadetrocas/utils/composedWidgets/app_button.dart';
import 'package:sistemadetrocas/utils/nav.dart';

class OwnProducts extends StatelessWidget {
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
    List<Product> products = CrudProduct.getProducts();

    return Container(
      padding: EdgeInsets.all(16),
      child: ListView.builder(
        itemCount: products.length,
        itemBuilder: (context, index) {
          Product currentProduct = products[index];

          return Card(
            color: Colors.grey[200],
            child: Column(
              children: <Widget> [
                Image.asset('assets/images/teste.jpeg'),
                Text(
                  currentProduct.gName,
                  style: TextStyle( fontSize: 24),
                ),
                 ButtonBar(
                   alignment: MainAxisAlignment.spaceEvenly,
                 children: <Widget> [
                   AppButton(
                     'DETALHES',
                     Colors.blue,
                     20.0,
                     Colors.white,
                     _onClickDetail
                   ),
                   AppButton(
                       'EXCLUIR',
                       Colors.blue,
                       20.0,
                       Colors.white,
                       _onClickRemoveProduct
                   )
                 ],
                ),
              ],
            ),
          );
      },
      ),
    );
  }


  _onClickDetail() {
    print('teste');
  }

  _onClickRemoveProduct() {
    print('teste');
  }
}