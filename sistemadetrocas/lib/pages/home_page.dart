import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sistemadetrocas/pages/deals/proposedDeals_form.dart';
import 'package:sistemadetrocas/pages/tabs/ownProductList.dart';
import 'package:sistemadetrocas/pages/tabs/othersProductList.dart';
import 'package:sistemadetrocas/pages/tabs/dealsList.dart';
import 'package:sistemadetrocas/requests/deals/crudDeals_api.dart';
import 'package:sistemadetrocas/utils/composedWidgets/app_drawer.dart';

class HomePage extends StatefulWidget
{
  const HomePage({ Key key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with SingleTickerProviderStateMixin
{
  Timer _timer;
  bool _hasDeal = false;
  bool _hasToStopTimer = false;
  TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(vsync: this, length: 3);
    startTimer();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('App de Trocas'),
        centerTitle: true,
        automaticallyImplyLeading: false,
        actions: <Widget>[
          Center(
            child: AnimatedCrossFade(
              firstChild: IconButton( icon: Icon(Icons.notifications_none, size: 32), onPressed: _getProposedDeals,),
              secondChild: IconButton( icon: Icon(Icons.notifications_active, size: 32), onPressed: _getProposedDeals,),
              duration: Duration(seconds: 2),
              crossFadeState: _hasDeal ? CrossFadeState.showSecond: CrossFadeState.showFirst,
            ),
          )
        ],
        bottom: TabBar(tabs: [
          Tab(icon: Icon(Icons.storage), text: 'Meus Produtos',),
          Tab(icon: Icon(Icons.search), text: 'Buscar Produtos',),
          Tab(icon: Icon(Icons.compare_arrows), text: 'Negociações',)
        ],
        controller: _tabController,)
         ,
      ),
      drawer: AppDrawer(),
      body: _body(context),
    );
  }

  _body(BuildContext context) {
    return TabBarView(
      controller: _tabController,
      children: <Widget>[
        OwnProducts(),
        OthersProduct(),
        Deals(),
      ],
    );
  }

  @override
  void dispose() {
    // cancela o contador
    _timer.cancel();
    _tabController.dispose();
    super.dispose();
  }

  // Atualiza a tela quando há propostas
  void _updateProposedDeals(bool hasDeal) {
    setState(() {
      _hasDeal = hasDeal;
    });
  }

  // Inicializa o contador
  // Busca as proposta de troca para este usuário
  void startTimer() {
    _timer = Timer.periodic(Duration(seconds: 10),
        (timer) {
          if (!_hasToStopTimer ) {
            Future<bool> futureHasDeal = CrudDeal.hasDeal();
            futureHasDeal.then( (hasDeal) => hasDeal ? _updateProposedDeals(hasDeal) : print('não há propostas até o momento'));
          }
        } );
  }

  void _getProposedDeals() {
    print('>>> dentro da função _getProposedDeals');
    _hasToStopTimer = true;
    Navigator.push(context, MaterialPageRoute(builder: (context) => ProposedPage())).then((value) {
      _hasToStopTimer = value;
    });
    _updateProposedDeals(false);
  }

}


