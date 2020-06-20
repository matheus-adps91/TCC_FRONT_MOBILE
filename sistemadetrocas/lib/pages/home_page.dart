import 'dart:async';

import 'package:flutter/material.dart';
import 'package:sistemadetrocas/pages/tabs/ownProductList.dart';
import 'package:sistemadetrocas/pages/tabs/othersProductList.dart';
import 'package:sistemadetrocas/pages/tabs/dealsList.dart';
import 'package:sistemadetrocas/requests/preDeals/crudPreDeals_api.dart';
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
  TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(vsync: this, length: 3,);
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
              firstChild: IconButton( icon: Icon(Icons.notifications_none, size: 32,), onPressed: _getOldDeals,),
              secondChild: IconButton( icon: Icon(Icons.notifications_active, size: 32,), onPressed: _getNewDeals,),
              duration: Duration(milliseconds: 2000),
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
    // cancel o contador
    _timer.cancel();
    _tabController.dispose();
    super.dispose();
  }

  // Busca as proposta de troca para este usuário
  void _getProposedDeals(bool hasDeal) {
    setState(() {
      _hasDeal = hasDeal;
    });
  }

  // Inicializa o contador
  void startTimer() {
    _timer = Timer.periodic(Duration(seconds: 60),
        (timer) {
          Future<bool> futureHasDeal = CrudPreDeal.hasDeal();
          futureHasDeal.then( (hasDeal) => hasDeal ? _getProposedDeals(hasDeal) : print('não há propostas até o momento'));
        } );
  }

  void _getOldDeals() {
    print('Este método vai recuperar os delas antigos');
  }

  void _getNewDeals() {
    print('Este método vai recuperar os deals novos');
    _getProposedDeals(false);
  }
}
