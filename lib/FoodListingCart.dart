import 'package:flutter/material.dart';
import 'package:flutterloginui/CartFoodDetail.dart';
import 'package:flutterloginui/FoodListingCartDetails.dart';
import 'package:flutterloginui/popus/confirmation.dart';
import 'package:flutterloginui/providers/products_provider.dart';
import 'package:load/load.dart';
import 'package:provider/provider.dart';
import 'models/foodObject.dart';
import 'dart:io';

int bill = 0;

class FoodListingCart extends StatefulWidget {
  final List<Food> _cart;

  FoodListingCart(this._cart);

  @override
  _FoodListingCartState createState() => _FoodListingCartState(this._cart);
}

class _FoodListingCartState extends State<FoodListingCart> {
  _FoodListingCartState(this._cart);
  List<Food> _cart;

  @override
  void initState() {
    final cartProvider = Provider.of<ProductProvider>(context, listen: false);
    cartProvider.loadAll(null);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var total = 0;
    for (var i = 0; i < _cart.length; i++) {
      total = total + int.parse(_cart[i].pricechange);
      print("totalprice $total");
    }
    bill = total;

    final cartProvider = Provider.of<ProductProvider>(context);

    return LoadingProvider(
      child: Scaffold(
        backgroundColor: Colors.red[400],
        body: ListView(
          children: <Widget>[
            Padding(
              padding: EdgeInsets.only(top: 15.0, left: 10.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  IconButton(
                    icon: Icon(Icons.arrow_back_ios),
                    color: Colors.white,
                    onPressed: () {
                      Navigator.of(context).pop(_cart);
                    },
                  ),
                  Container(
                      // width: 125.0,
                      child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      // IconButton(
                      //   icon: Icon(Icons.calendar_today),
                      //   color: Colors.white,
                      //   onPressed: () {},
                      // ),
                      IconButton(
                        icon: Icon(Icons.menu),
                        color: Colors.white,
                        onPressed: () {
                          showLoadingDialog();
                          // showCustomLoadingWidget(Container()); // custom dialog
                          // hideLoadingDialog();
                        },
                      )
                    ],
                  ))
                ],
              ),
            ),
            SizedBox(height: 25.0),
            Padding(
              padding: EdgeInsets.only(left: 40.0),
              child: Row(
                children: <Widget>[
                  Text('Your',
                      style: TextStyle(
                          fontFamily: 'Montserrat',
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 25.0)),
                  SizedBox(width: 10.0),
                  Text('Cart',
                      style: TextStyle(
                          fontFamily: 'Montserrat',
                          color: Colors.white,
                          fontSize: 25.0))
                ],
              ),
            ),
            Container(
              padding: EdgeInsets.only(top: 10.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text(
                    'Total (ugx)',
                    style: TextStyle(
                      fontFamily: 'Montserrat',
                      fontSize: 17.0,
                      color: Colors.white,
                    ),
                  ),
                  SizedBox(width: 10.0),
                  Text(
                    bill.toString(),
                    style: TextStyle(
                        fontFamily: 'Montserrat',
                        fontSize: 18.0,
                        color: Colors.white,
                        fontWeight: FontWeight.bold),
                  )
                ],
              ),
            ),
            SizedBox(height: 40.0),
            Container(
              height: MediaQuery.of(context).size.height - 185.0,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(topLeft: Radius.circular(75.0)),
              ),
              child: ListView(
                primary: false,
                padding: EdgeInsets.only(left: 25.0, right: 20.0),
                children: <Widget>[
                  Padding(
                    padding: EdgeInsets.only(top: 10.0),
                    child: Container(
                      height: MediaQuery.of(context).size.height - 300.0,
                      child: ListView(
                        children: [
                          _buildFoodItem(),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(height: 8.0),
                  Padding(
                    padding:
                        EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
                    child: Row(
                      children: <Widget>[
                        Expanded(
                          child: InkWell(
                            onTap: () async {
                              await showLoadingDialog();
                              try {
                                final result =
                                    await InternetAddress.lookup('google.com');
                                if (result.isNotEmpty &&
                                    result[0].rawAddress.isNotEmpty) {
                                  // print('connected');
                                  // productProvider.saveProduct(_cart);
                                  cartProvider.saveCardOrders(_cart);
                                  hideLoadingDialog();
                                  showDialog(
                                    context: context,
                                    builder: (BuildContext context) =>
                                        CustomDialog(
                                      title: "Success!",
                                      description:
                                          "Your Order has been Received! We shall Contact You Right Away, Thank You",
                                      buttonText: "Okay",
                                    ),
                                  );
                                  _cart.clear();
                                  // bill = 0;
                                  Navigator.of(context).pop(_cart);
                                  // setState(() {});
                                }
                              } on SocketException catch (_) {
                                // print('not connected');
                                hideLoadingDialog();
                                showDialog(
                                  context: context,
                                  builder: (BuildContext context) =>
                                      CustomDialog(
                                    title: "Failed",
                                    description:
                                        "Order Failed, No Internet Connection. Please Try again",
                                    buttonText: "Okay",
                                  ),
                                );
                              }
                            },
                            child: Container(
                              height: 40.0,
                              decoration: BoxDecoration(
                                border: Border.all(color: Colors.red[400]),
                                color: Colors.red[400],
                              ),
                              child: Center(
                                child: Text(
                                  "Submit Order",
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(width: 10.0),
                        Expanded(
                          child: InkWell(
                            onTap: () => {
                              _cart.clear(),
                              Navigator.of(context).pop(_cart)
                            },
                            child: Container(
                              height: 40.0,
                              decoration: BoxDecoration(
                                border: Border.all(),
                              ),
                              child: Center(
                                child: Padding(
                                  padding: EdgeInsets.all(10.0),
                                  child: Text(
                                    "Clear Cart",
                                    style:
                                        TextStyle(fontWeight: FontWeight.w600),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget _buildFoodItem() {
    return ListView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: _cart.length,
      itemBuilder: (context, index) {
        var item = _cart[index];
        // int totalpsrice = (int.parse(item.price));
        // int totalpsrice = (int.parse(item.price));

        // var sum = 0;
        // totalprice.forEach((e) => sum += e);
        // billtotal = sum;

        return Padding(
          padding: EdgeInsets.only(left: 10.0, right: 10.0, top: 10.0),
          child: InkWell(
            onTap: () async {
              final result = await Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => FoodListingCartDetails(
                        heroTag: item.imagepath,
                        foodName: item.name,
                        foodPrice: item.price,
                        foodDescription: item.description,
                        foodqtn: item.quantity,
                        changeprice: item.pricechange,
                        changeqtn: item.qtnchange,
                      )));

              setState(() {
                // item.quantity = result;

                // item.price = ((int.parse(item.price)) * result).toString();

                item.qtnchange = result;

                item.pricechange =
                    ((int.parse(item.price)) * result).toString();

                print("quantity: ${item.price}");
              });
            },
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Container(
                  child: Row(
                    children: [
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
                                    fontSize: 14.0,
                                    fontWeight: FontWeight.bold)),
                            Text('Ugx ${item.pricechange}',
                                style: TextStyle(
                                    fontFamily: 'Montserrat',
                                    fontSize: 13.0,
                                    color: Colors.grey)),
                            Text('Qtn: ${item.qtnchange}',
                                style: TextStyle(
                                    fontFamily: 'Montserrat',
                                    fontSize: 13.0,
                                    color: Colors.grey))
                          ])
                    ],
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    setState(() {
                      var newbill = bill - (int.parse(item.price));
                      bill = newbill;
                      _cart.remove(item);
                      print("remained $bill");
                    });
                  },
                  child: Material(
                    elevation: 2.0,
                    borderRadius: BorderRadius.circular(15.0),
                    child: Container(
                      height: 30.0,
                      width: 30.0,
                      child: Center(
                        child: Icon(
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
