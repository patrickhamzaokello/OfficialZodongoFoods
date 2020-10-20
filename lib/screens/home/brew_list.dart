import 'package:flutter/material.dart';
import 'package:flutterloginui/models/foodObject.dart';
import 'package:flutterloginui/screens/home/brew_tile.dart';

import 'package:provider/provider.dart';

class BrewList extends StatefulWidget {
  final List<Food> cartList;
  BrewList({this.cartList});
  @override
  _BrewListState createState() => _BrewListState(this.cartList);
}

class _BrewListState extends State<BrewList> {
  _BrewListState(this.cartList);
  List<Food> cartList;
  @override
  Widget build(BuildContext context) {
    final foods = Provider.of<List<Food>>(context);

    return ListView.builder(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        padding: EdgeInsets.only(right: 20.0),
        itemCount: foods.length,
        itemBuilder: (context, index) {
          var item = foods[index];
          return BrewTile(item: item, cartList: cartList);
        });
    // print("bill total: $billtotal");
  }
}
