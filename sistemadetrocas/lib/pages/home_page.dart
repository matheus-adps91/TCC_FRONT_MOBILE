import 'package:flutter/material.dart';
import 'package:sistemadetrocas/pages/tabs/ownProductList.dart';
import 'package:sistemadetrocas/pages/tabs/othersProductList.dart';
import 'package:sistemadetrocas/pages/tabs/dealsList.dart';

class HomePage extends StatefulWidget {
  const HomePage({ Key key }) : super(key: key);
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with SingleTickerProviderStateMixin{

  TabController _tabController;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        bottom: TabBar(tabs: [
          Tab(icon: Icon(Icons.add)),
          Tab(icon: Icon(Icons.search)),
          Tab(icon: Icon(Icons.compare_arrows))
        ],
        controller: _tabController,),
      ),
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
  void initState() {
    super.initState();
    _tabController = TabController(vsync: this, length: 3,);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }
}
