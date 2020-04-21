import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_ecommerce/models/app_state.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:shared_preferences/shared_preferences.dart';

final gradientBackground = BoxDecoration(
  gradient: LinearGradient(
    begin: Alignment.bottomLeft,
    end: Alignment.topRight,
    stops: [0.1, 0.3, 0.5, 0.7, 0.9],
    colors: [
      Colors.deepOrange[300],
      Colors.deepOrange[400],
      Colors.deepOrange[500],
      Colors.deepOrange[600],
      Colors.deepOrange[700],
    ]
  )
);

class ProductsPage extends StatefulWidget{
  final void Function() onInit;
  ProductsPage({this.onInit});
  @override 
  ProductsPageState createState() => ProductsPageState();
}

class ProductsPageState extends State<ProductsPage> {
  @override
  void initState() {
    super.initState();
    widget.onInit();
  }

  

  final _appBar = PreferredSize(
    preferredSize: Size.fromHeight(60.0),
    child: StoreConnector<AppState, AppState>(
      converter: (store) => store.state,
      builder: (context, state) {
        return AppBar(
          centerTitle: true,
          title: SizedBox(child: state.user != null ? Text(state.user.username) : Text(''),),
          leading: Icon(Icons.shopping_cart),
          actions: <Widget>[
            Padding(
              padding: EdgeInsets.only(right: 12.0),
              child: state.user != null ? IconButton(icon: Icon(Icons.exit_to_app),
                onPressed: () => print('log out')) : Text('')
            ),
          ],
        );
      },
    ),
  );
  
  @override 
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _appBar,
      body: Container(
        decoration: gradientBackground,
        child: Column(
          children:[
            Row(
              children: <Widget>[
                Text("products")
              ],
            )
          ]
        )
      )
    );
  }
}