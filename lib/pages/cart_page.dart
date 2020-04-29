import 'package:flutter/material.dart';

class CartPage extends StatefulWidget {
  @override
  _CartPageState createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {

  Widget _cartTab() {
    return Text('cart');
  }

  Widget _cardsTab() {
    return Text('cart');
  }

  Widget _ordersTab() {
    return Text('cart');
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      initialIndex: 0,
      child: Scaffold(
        appBar: AppBar(
          bottom: TabBar(
            labelColor: Colors.deepOrange[600],
            unselectedLabelColor: Colors.deepOrange[900],
            tabs: [
              Tab(icon: Icon(Icons.shopping_cart)),
              Tab(icon: Icon(Icons.credit_card)),
              Tab(icon: Icon(Icons.receipt)),
            ]
          ),
          title: Text('Cart'),
        ),
        body: TabBarView(
          children: <Widget>[
            _cartTab(),
            _cardsTab(),
            _ordersTab()
          ],
        ),
      ),
    );
  }
}