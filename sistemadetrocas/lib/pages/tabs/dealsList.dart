import 'package:flutter/material.dart';
import 'package:sistemadetrocas/model/ProductDeal.dart';
import 'package:sistemadetrocas/model/deal.dart';
import 'package:sistemadetrocas/pages/deals/expansionPainel_item.dart';
import 'package:sistemadetrocas/requests/deals/crudDeals_api.dart';
import 'package:sistemadetrocas/utils/prefs.dart';

class Deals extends StatefulWidget
{
  @override
  _DealsState createState() => _DealsState();
}

class _DealsState extends State<Deals>
{
  // Lista de associação entre produto e deal
  List<ProductDeal> _productsDeals;
  // Lista de items que contem as informações do header e do body do painel
  List<Item> _itemsOfProductsDeals;
  // Lista de negócios
  List<Deal> _deals;
  // Id do usuário logado
  int idCurrentUser;
  // Armazena o valor do steper
  int _currentStep;

  @override
  void initState() {
    super.initState();
    _loadDataToBuildPanel();
    _loadCurrentUser();
  }

  // Busca as associações de produto e deal que virarram negócio
  _loadDataToBuildPanel() async {
    List<ProductDeal> productsDealsToShowOnPanel = await CrudDeal.getProductsDealsToShowOnPanel();
    List<Deal> dealsToShowOnPanel = await CrudDeal.getDealsToShowOnPanel();
    setState(() {
      this._productsDeals = productsDealsToShowOnPanel;
      this._deals = dealsToShowOnPanel;
      this._itemsOfProductsDeals = Item.generateItems(productsDealsToShowOnPanel, dealsToShowOnPanel);
    });
  }

  _loadCurrentUser() async {
     String sIdCurrentUser = await Prefs.getString('id');
     setState(() {
       idCurrentUser = int.parse(sIdCurrentUser);
     });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: _buildPanel(),
      ),
    );
  }

  Widget _buildPanel() {
    if (_productsDeals == null || _deals == null) {
      return Container(
        child: Center(
          child: CircularProgressIndicator(),
        ),
      );
    }

    if (_productsDeals.length == 0) {
      return Container(
        child: Center(
          child: Text(
            'Não há troca em andamento',
            style: TextStyle(fontSize: 20),
          ),
        ),
      );
    }

    return ListView(
      children: <Widget>[
        ExpansionPanelList(
          expansionCallback: (int index, bool isExpanded) {
            setState(() {
              _itemsOfProductsDeals[index].isExpanded = !isExpanded;
            });
          },
        children: _itemsOfProductsDeals.map<ExpansionPanel>((Item item) {
          return ExpansionPanel(
            headerBuilder: (BuildContext context, bool isExpanded) {
              return ListTile(
                title: Text('Troca: '+item.headerValue.gIdDeal.toString()),
                subtitle:_buildSubtitleTextPanel(item.headerValue),
              );
            },
            body: _buildStepper(item),
            isExpanded: item.isExpanded,
          );
        }).toList(),
      ),
      ]
    );
  }

    Widget _buildStepper(Item item) {
      return Container(
          padding: EdgeInsets.all(16),
          child: Card(
              color: Colors.grey[200],
              child: Stepper(
                steps: _stepper(item),
                currentStep:  _currentStepForUser(item),
                onStepContinue: _currentStepForUser(item) == 3 ? null : () {
                  if (_currentStepForUser(item) < this._stepper(item).length - 1) {
                    setState(() {
                      if ( idCurrentUser == item.headerValue.gProductProponent.gSignupUser.gUserId) {
                        item.expandedValue.stepperUserProponent = item.expandedValue.gStepperUserProponent + 1;
                      } else {
                        item.expandedValue.stepperUserProposed = item.expandedValue.gStepperUserProposed + 1;
                      }
                    });
                    CrudDeal.updateStepper(item.headerValue.id);
                  } else {
                    print('troca completa');
                  }
                })
          )
      );
    }

    int _currentStepForUser(Item item) {
      return idCurrentUser == item.headerValue.gProductProponent.gSignupUser.gUserId?
                item.expandedValue.gStepperUserProponent : item.expandedValue.gStepperUserProposed;
    }

  List<Step> _stepper(Item item) {
    List<Step> steps = [
      Step(
        title: Text('Negociação Iniciada'),
        content: _rowOfProducts(item.headerValue),
        isActive: true,
      ),
      Step(
          title: Text('Envie '+item.headerValue.gProductProponent.gName),
          content: Text('Enviei o seu produto para o outro usuário'),
          isActive: _currentStepForUser(item) >= 1 ? true : false
      ),
      Step(
          title: Text('Receba '+item.headerValue.gProductProposed.gName),
          content: Text('Recebi o produto do outro usuário'),
          isActive: _currentStepForUser(item) >= 2 ? true : false
      ),
      Step(
          title: Text('Negociação Encerrada'),
          content: Text('Negociação Finalizada com sucesso'),
          isActive: _currentStepForUser(item) >= 3 ? true : false
      )
    ];
    return steps;
  }

  _buildSubtitleTextPanel(ProductDeal headerValue) {
    return Text(
      'Proponente: '+headerValue.gProductProponent.gSignupUser.gFullName+
      '  #  Proposto: '+headerValue.gProductProposed.gSignupUser.gFullName
    );
  }

  _rowOfProducts(ProductDeal productDeal) {
    return Container(
      child: Column(
        children: <Widget> [
          Row(
            children: <Widget> [
              Text('Produtos envolvidos na troca',
              style: TextStyle(fontSize: 18),),
            ]),
          spaceBetweenElements(y:10),
          Row(
             children: <Widget> [
               Column(
                 children: <Widget> [
                   Container(
                     height: 100,
                     width: 100,
                     child: Image.network(
                       productDeal.gProductProponent.gImgPath,),
                   ),
                   spaceBetweenElements(y:5),
                   Text(productDeal.gProductProponent.gName),
                 ],
               ),
               spaceBetweenElements(x:10),
               Column(
                 children: <Widget>[
                   Container(
                     height: 120,
                     width: 120,
                     child: Image.network(
                       productDeal.gProductProposed.gImgPath,),
                   ),
                   spaceBetweenElements(y:5),
                   Text(productDeal.gProductProposed.gName),
                 ],
               ),
             ]
          )
        ] ,
        ),
    );
  }

  SizedBox spaceBetweenElements({double y = 0, double x = 0}) {
    return SizedBox(height: y, width: x);
  }

}