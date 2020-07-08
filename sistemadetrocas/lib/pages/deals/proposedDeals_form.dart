import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sistemadetrocas/model/ProductDeal.dart';
import 'package:sistemadetrocas/model/product.dart';
import 'package:sistemadetrocas/requests/deals/crudDeals_api.dart';
import 'package:sistemadetrocas/utils/composedWidgets/app_button.dart';
import 'package:sistemadetrocas/utils/composedWidgets/app_confirmOperation.dart';
import 'package:sistemadetrocas/utils/composedWidgets/app_snackBarMessage.dart';

class ProposedPage extends StatefulWidget {
  @override
  _ProposedPageState createState() => _ProposedPageState();
}

class _ProposedPageState extends State<ProposedPage> {
  Timer _timer;
  bool _alternateProduct = false;
  List<ProductDeal> _productDeals;

  @override
  void initState() {
    super.initState();
    startTimer();
    _loadProductDeals();
  }

  // Busca as preDeals na API
  void _loadProductDeals() async {
    List<ProductDeal> productDeals = await CrudDeal.getProductDeal();
    setState(() {
      this._productDeals = productDeals;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Propostas Recebidas'),
        centerTitle: true,
        automaticallyImplyLeading: false,
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context, false),
        ),
      ),
      body: Builder (
        builder: (BuildContext context) {
          return _body(context);
        },
      ),
    );
  }

  Widget _body(BuildContext context) {
    if (_productDeals == null) {
      return Container(
        child: Center(
          child: CircularProgressIndicator(),
        ),
      );
    }

    if (_productDeals.length == 0) {
      return Container(
        child: Center(
          child: Text(
            'Não há propostas de troca',
            style: TextStyle(fontSize: 20),
          ),
        ),
      );
    }

    return Container(
      padding: EdgeInsets.all(16),
      child: ListView.builder(
          itemCount: _productDeals.length,
          itemBuilder: (context, index) {
            ProductDeal currentProductDeal = _productDeals[index];

            return Card(
              color: Colors.grey[200],
              child: Column(
                children: <Widget>[
                  ListTile(
                    trailing: Icon(Icons.compare_arrows),
                    title: Text(
                        currentProductDeal.gProductProponent.gSignupUser.gFullName,
                        style: TextStyle(fontSize: 22.0),
                    ),
                    subtitle: Text(
                      'Propõe a troca:',
                      style: TextStyle(fontSize: 16.0),
                    ),
                  ),
                   Container(
                      child: AnimatedCrossFade(
                        firstChild: _wireOfProposedDeal(currentProductDeal.gProductProponent),
                        secondChild: _wireOfProposedDeal(currentProductDeal.gProductProposed),
                        duration: Duration(seconds: 2),
                        crossFadeState: _alternateProduct
                            ? CrossFadeState.showFirst: CrossFadeState.showSecond,
                      ),
                    ),
                    spaceBetweenElements(y: 10.0),
                    ButtonBar(
                      alignment: MainAxisAlignment.spaceEvenly,
                      children: <Widget>[
                        AppButton('Aceitar', Colors.blue, 16.0, Colors.white, () {
                            _onClickAcceptDeal(currentProductDeal, context);
                          }),
                        AppButton('Recusar', Colors.blue, 16.0, Colors.white, () {
                            _onClickRejectDeal(currentProductDeal, context);
                          })
                        ],
                    )]
                )
          );
          }
      )
    );
  }

  void startTimer() {
    _timer = Timer.periodic(Duration(seconds: 8), (timer) {
      _alternateProductsInDeal();
    });
  }

  // Mudo o valor da flag para a troca de produto
  void _alternateProductsInDeal() {
    setState(() {
      _alternateProduct = !_alternateProduct;
    });
  }

  // Libera o timer que alterna entre os produtos
  @override
  void dispose() {
    super.dispose();
    _timer.cancel();
  }

  Widget _wireOfProposedDeal(Product product) {
    return Column(
      children: <Widget>[
        Container(
          width: 250,
          height: 250,
          child: Image.network(
            product.gImgPath,
          ),
        ),
        Text(
          product.gName,
          style: TextStyle(fontSize: 22),
        ),
        spaceBetweenElements(y: 10.0),
        Text(
          product.gDesc,
          style: TextStyle(fontSize: 18),
        ),
        spaceBetweenElements(y: 10.0),
        Text(
          product.gProdCat,
          style: TextStyle(fontSize: 18),
        )
      ],
    );
  }

  // Espaço entre elementos do ListView do formulário de SignUp
  SizedBox spaceBetweenElements({double y = 0, double x = 0}) {
    return SizedBox(height: y, width: x);
  }

  Future<void> _onClickAcceptDeal(ProductDeal productDeal, BuildContext context) async {
    print(">>> dentro do método _onClickAcceptDeal");
    var appConfirmOpearation = AppConfirmOperation(
        'Proposta', 'Aceitar a proposta de troca?', context
    );
    final bool shouldAccept  = await appConfirmOpearation.buildAlertConfirm();
    if(!shouldAccept) {
      return;
    }
    bool isSuccessfullAccepted = await CrudDeal.acceptedProposedDeal(productDeal);

    if(isSuccessfullAccepted) {
      var appSnackBarMessage =
      AppSnackBarMessage(context, 'Proposta aceita com sucesso', Icons.sync);
      appSnackBarMessage.buildSnackBarMessage();
      _loadProductDeals();
    } else {
      var appSnackBarMessage = AppSnackBarMessage(context, 'Falha no processo de Troca', Icons.sync_problem, backgroundColor: Colors.red);
      appSnackBarMessage.buildSnackBarMessage();
    }

  }

  Future<void> _onClickRejectDeal(ProductDeal productDeal, BuildContext context) async {
    print(">>> dentro do método _onClickReject");
    var appConfirmOpearation = AppConfirmOperation(
        'Proposta', 'Recusar a proposta de troca?', context
    );

    final bool shouldDelete = await appConfirmOpearation.buildAlertConfirm();
    if (!shouldDelete) {
      return;
    }
    final bool answeredProposedDeal = await CrudDeal.deleteProposedDeal(productDeal);
    if ( answeredProposedDeal) {
      setState(() {
        _productDeals.remove(productDeal);
      });
      var appSnackBarMessage = AppSnackBarMessage(context, 'Proposta recusada com sucesso', Icons.sync_disabled);
      appSnackBarMessage.buildSnackBarMessage();
    }
  }

}