import 'package:flutter/material.dart';

class ProductItem extends StatelessWidget {
  final dynamic item;
  ProductItem({this.item});

  @override
  Widget build(BuildContext context) {
    //final String pictureUrl = 'http://localhost:1337/${item['picture']['url']}';
    return GridTile(
      //child: Image.network(pictureUrl, fit: BoxFit.cover),
      child: Text(item['photo'])
      
    );
  }
}