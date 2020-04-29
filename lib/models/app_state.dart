import 'package:flutter/cupertino.dart';
import 'package:flutter_ecommerce/models/product.dart';

@immutable
class AppState {
  final dynamic user;
  final List<Product> products;
  final List<Product> cartProducts;

  AppState({ @required this.user, @required this.products, @required this.cartProducts});

  factory AppState.initial() {
    return AppState(user: null, products: [], cartProducts: []);
  }
}