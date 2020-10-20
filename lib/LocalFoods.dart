import 'package:flutter/material.dart';
import 'package:flutterloginui/models/foodObject.dart';
import 'package:flutterloginui/mycart.dart';
import 'package:flutterloginui/popus/confirmation.dart';
import 'package:flutterloginui/screens/home/brew_list.dart';
import 'package:flutterloginui/services/database.dart';

import 'package:provider/provider.dart';

class LocalFoods extends StatefulWidget {
  @override
  _LocalFoodsState createState() => _LocalFoodsState();
}

class _LocalFoodsState extends State<LocalFoods> {
  List<Food> _cartList = List<Food>();

  @override
  Widget build(BuildContext context) {
    return StreamProvider<List<Food>>.value(
      value: DatabaseService().foodlisting,
      child: Scaffold(
        appBar: AppBar(
          title: Text("Local Foods"),
          elevation: 0.0,
          actions: <Widget>[
            Padding(
              padding: const EdgeInsets.only(right: 16.0, top: 8.0),
              child: GestureDetector(
                child: Stack(
                  alignment: Alignment.topCenter,
                  children: <Widget>[
                    Icon(
                      Icons.shopping_cart,
                      size: 36.0,
                    ),
                    if (_cartList.length > 0)
                      Padding(
                        padding: const EdgeInsets.only(left: 2.0),
                        child: CircleAvatar(
                          radius: 8.0,
                          backgroundColor: Colors.red,
                          foregroundColor: Colors.white,
                          child: Text(
                            _cartList.length.toString(),
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 12.0,
                            ),
                          ),
                        ),
                      ),
                  ],
                ),
                onTap: () async {
                  if (_cartList.isNotEmpty) {
                    final result = await Navigator.of(context).push(
                        MaterialPageRoute(
                            builder: (context) => Cart(_cartList)));

                    setState(() {
                      _cartList = result;

                      // print("quantity: ${item.quantity}");
                    });
                  } else {
                    showDialog(
                      context: context,
                      builder: (BuildContext context) => CustomDialog(
                        title: "Empty Cart",
                        description:
                            "Your Cart is Empty,Please Add Food to Cart First! Before you can Continue",
                        buttonText: "Okay",
                      ),
                    );
                  }
                },
              ),
            )
          ],
        ),
        body: BrewList(cartList: _cartList),
      ),
    );
  }
}
