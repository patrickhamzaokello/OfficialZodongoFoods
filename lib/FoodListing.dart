import 'package:flutter/material.dart';
import 'package:flutterloginui/FoodListingCart.dart';
import 'package:flutterloginui/FoodListingDetails.dart';
import 'package:flutterloginui/popus/confirmation.dart';
import 'package:flutterloginui/providers/products_provider.dart';
import 'package:provider/provider.dart';

import 'models/foodObject.dart';
import 'package:intl/intl.dart';

var numformat = NumberFormat("#,##0", "en_US");

class FoodListing extends StatefulWidget {
  @override
  _FoodListingState createState() => _FoodListingState();
}

class _FoodListingState extends State<FoodListing> {
  List<Food> _cartList = List<Food>();

  @override
  Widget build(BuildContext context) {
    final foodProvider = Provider.of<ProductProvider>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text("Food Menu List"),
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
                          builder: (context) => FoodListingCart(_cartList)));

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
      body: StreamBuilder<List<Food>>(
        stream: foodProvider.foods,
        builder: (context, snapshot) {
          return ListView(children: <Widget>[
            SizedBox(height: 20.0),
            Padding(
              padding: EdgeInsets.only(left: 20.0),
              child: Text(
                'All Foods We Serve',
                style: TextStyle(
                    fontFamily: 'Montserrat',
                    fontWeight: FontWeight.w600,
                    fontSize: 17.0),
              ),
            ),
            SizedBox(height: 20.0),
            _buildFoodMenuList(snapshot)
          ]);
        },
      ),
    );
  }

  ListView _buildFoodMenuList(snapshot) {
    return ListView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      padding: EdgeInsets.only(right: 20.0),
      itemCount: snapshot.data.length,
      itemBuilder: (context, index) {
        var item = snapshot.data[index];

        // print("bill total: $billtotal");

        return Padding(
          padding: EdgeInsets.only(left: 10.0, right: 10.0, top: 10.0),
          child: InkWell(
            onTap: () {
              Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => FoodListingDetails(
                        heroTag: item.imagepath ?? '',
                        foodName: item.name ?? '',
                        foodPrice: item.price ?? '',
                        foodDescription: item.description ?? '',
                      )));

              setState(() {});
            },
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Container(
                  child: Row(children: [
                    Hero(
                        tag: item.imagepath,
                        child: Image(
                            image: NetworkImage(item.imagepath),
                            fit: BoxFit.cover,
                            height: 75.0,
                            width: 75.0)),
                    SizedBox(width: 10.0),
                    Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(item.name,
                              style: TextStyle(
                                  fontFamily: 'Montserrat',
                                  fontSize: 15.0,
                                  fontWeight: FontWeight.bold)),
                          Text('UGX ' + numformat.format(int.parse(item.price)),
                              style: TextStyle(
                                  fontFamily: 'Montserrat',
                                  fontSize: 14.0,
                                  color: Colors.grey))
                        ])
                  ]),
                ),
                GestureDetector(
                  onTap: () {
                    setState(() {
                      if (!_cartList.contains(item)) {
                        item.pricechange = item.price;
                        item.qtnchange = item.quantity;
                        _cartList.add(item);
                      } else {
                        item.pricechange = item.price;
                        item.qtnchange = item.quantity;
                        _cartList.remove(item);
                      }
                    });
                  },
                  child: Material(
                    elevation: 2.0,
                    borderRadius: BorderRadius.circular(15.0),
                    child: Container(
                      height: 30.0,
                      width: 30.0,
                      child: Center(
                        child: (!_cartList.contains(item))
                            ? Icon(
                                Icons.add_circle,
                                color: Colors.amber[400],
                                // size: 17.0,
                              )
                            : Icon(
                                Icons.remove_circle,
                                color: Colors.red,
                              ),
                      ),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15.0),
                          color: Colors.white),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

// ListView.builder(
//             itemCount: snapshot.data.length,
//             itemBuilder: (context, index) {
//               return ListTile(
//                 trailing: Icon(
//                   Icons.edit,
//                 ),
//                 title: Text(snapshot.data[index].name),
//               );
//             },
//           );
