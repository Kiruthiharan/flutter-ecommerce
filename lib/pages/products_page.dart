import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter_ecommerce/models/app_state.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:shared_preferences/shared_preferences.dart';

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

  
  @override 
  Widget build(BuildContext context) {
    return StoreConnector<AppState, AppState>(
      converter: (store) => store.state,
      builder: (context, state) {
        return Text(json.encode(state.user));
      },
    );
  }
}