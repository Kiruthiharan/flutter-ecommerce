import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProductsPage extends StatefulWidget{
  @override 
  ProductsPageState createState() => ProductsPageState();
}

class ProductsPageState extends State<ProductsPage> {
  @override
  void initState() {
    super.initState();
    _getUser();
  }

  _getUser() async {
    final prefs = await SharedPreferences.getInstance();
    var storedUser = prefs.getString('user');
    print('------------------------------------------------------------------------');
    print(json.decode(storedUser));
  }
  @override 
  Widget build(BuildContext context) {
    return Text('Products page');
  }
}