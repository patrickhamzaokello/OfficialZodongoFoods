import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutterloginui/AboutUs.dart';
import 'package:flutterloginui/Search.dart';
import 'package:flutterloginui/UserPage.dart';
import 'package:flutterloginui/detailPage.dart';
import 'package:flutterloginui/models/foodObject.dart';
import 'package:flutterloginui/mycart.dart';
import 'package:flutterloginui/popus/confirmation.dart';
import 'package:intl/intl.dart';

var numformat = NumberFormat("#,##0", "en_US");

class Home extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "Zodongo Foods",
      theme: ThemeData(
        primarySwatch: Colors.green,
      ),
      home: MyHomePage(title: 'Zodongo Foods'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);
  final String title;
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  List<Food> _dishes = List<Food>();
  List<Food> _favdishes = List<Food>();

  List<Food> _cartList = List<Food>();

  @override
  void initState() {
    super.initState();
    _populateFavouriteDishes();
    _populateDishes();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
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
                      MaterialPageRoute(builder: (context) => Cart(_cartList)));

                  setState(() {
                    _cartList = result;

                    // print("quantity: ${item.quantity}");
                  });
                } else {
                  showDialog(
                    context: context,
                    builder: (BuildContext context) => CustomDialog(
                      title: "Empty Cart",
                      description: "Please Add Food to Cart First!",
                      buttonText: "Okay",
                    ),
                  );
                }
              },
            ),
          )
        ],
      ),
      body: ListView(
        children: <Widget>[
          SizedBox(height: 20.0),
          SizedBox(height: 10.0),
          Padding(
            padding: EdgeInsets.only(left: 25.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text('You Stay At Home.',
                    style: TextStyle(
                        fontFamily: 'Futur',
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF5B8842),
                        fontSize: 35.0)),
                Text('We Deliver!',
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF5B8842),
                        fontSize: 35.0)),
                SizedBox(height: 20.0),
                Text('Popular Food',
                    style: TextStyle(
                        fontFamily: 'Montserrat',
                        fontWeight: FontWeight.w600,
                        fontSize: 17.0))
              ],
            ),
          ),
          SizedBox(height: 7.0),
          Container(
            height: 250.0,
            child: _buildFavouriteFoods(),
          ),
          SizedBox(height: 20.0),
          Padding(
              padding: EdgeInsets.only(left: 20.0),
              child: Text('Best Food',
                  style: TextStyle(
                      fontFamily: 'Montserrat',
                      fontWeight: FontWeight.w600,
                      fontSize: 17.0))),
          SizedBox(height: 20.0),
          _buildFoodMenuList(),
        ],
      ),
      bottomNavigationBar: Container(
        height: 50.0,
        decoration: BoxDecoration(
          color: Color(0xFF5AC035),
        ),
        padding: EdgeInsets.only(left: 40.0, right: 40.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            IconButton(
              onPressed: () {
                Navigator.of(context).push(
                  (MaterialPageRoute(builder: (context) => AboutUs())),
                );
              },
              icon: Icon(
                Icons.extension,
                color: Colors.white,
              ),
            ),
            IconButton(
                icon: Icon(
                  Icons.search,
                  color: Colors.white,
                ),
                onPressed: () {
                  Navigator.of(context).push(
                    (MaterialPageRoute(builder: (context) => SearchFood())),
                  );
                }),
            IconButton(
              icon: Icon(
                Icons.person_outline,
                color: Colors.white,
              ),
              onPressed: () {
                Navigator.of(context).push(
                  (MaterialPageRoute(builder: (context) => UserPage())),
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  ListView _buildFavouriteFoods() {
    return ListView.builder(
      scrollDirection: Axis.horizontal,
      itemCount: _favdishes.length,
      itemBuilder: (context, index) {
        var item = _favdishes[index];
        return InkWell(
          onTap: () {
            Navigator.of(context).push(
              (MaterialPageRoute(
                builder: (context) => DetailsPage(
                  heroTag: item.imagepath,
                  foodName: item.name,
                  foodPrice: item.price,
                  foodDescription: item.price,
                ),
              )),
            );
          },
          child: Padding(
            padding: EdgeInsets.only(left: 20.0, top: 10.0, bottom: 4.0),
            child: Container(
              height: 200.0,
              width: 200.0,
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10.0),
                  boxShadow: [
                    BoxShadow(
                        blurRadius: 6.0,
                        color: Colors.grey.withOpacity(0.2),
                        spreadRadius: 5.0)
                  ]),
              child: Stack(
                children: <Widget>[
                  Container(
                    height: 175.0,
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                          colors: [Colors.white, Color(0xFFACBEA3)],
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight),
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(10.0),
                        topRight: Radius.circular(10.0),
                      ),
                    ),
                  ),
                  Hero(
                      tag: item.imagepath,
                      child: Container(
                        height: 175.0,
                        decoration: BoxDecoration(
                            image: DecorationImage(
                                image: AssetImage(item.imagepath),
                                fit: BoxFit.contain),
                            borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(10.0),
                                topRight: Radius.circular(10.0))),
                      )),
                  Positioned(
                    top: 160.0,
                    right: 20.0,
                    child: Material(
                      elevation: 2.0,
                      borderRadius: BorderRadius.circular(15.0),
                      child: Container(
                        height: 30.0,
                        width: 30.0,
                        child: Center(
                          child: Icon(Icons.favorite,
                              color: Colors.green, size: 17.0),
                        ),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15.0),
                            color: Colors.white),
                      ),
                    ),
                  ),
                  Positioned(
                    top: 190.0,
                    left: 10.0,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(item.name,
                            style: TextStyle(
                                fontFamily: 'Montserrat',
                                fontWeight: FontWeight.w600,
                                color: Colors.black,
                                fontSize: 14.0)),
                        SizedBox(height: 3.0),
                        Container(
                            width: 175.0,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                Row(
                                  children: <Widget>[
                                    Text(
                                      '4.9',
                                      style: TextStyle(
                                          fontFamily: 'Montserrat',
                                          color: Colors.grey,
                                          fontSize: 12.0),
                                    ),
                                    SizedBox(width: 3.0),
                                    Icon(Icons.star,
                                        color: Colors.green, size: 14.0),
                                    Icon(Icons.star,
                                        color: Colors.green, size: 14.0),
                                    Icon(Icons.star,
                                        color: Colors.green, size: 14.0),
                                    Icon(Icons.star,
                                        color: Colors.green, size: 14.0),
                                    Icon(Icons.star,
                                        color: Colors.green, size: 14.0),
                                  ],
                                ),
                                Text(
                                    'Ugx ' +
                                        numformat.format(
                                          int.parse(item.price),
                                        ),
                                    style: TextStyle(
                                        fontFamily: 'Montserrat',
                                        fontWeight: FontWeight.w500,
                                        color: Colors.black,
                                        fontSize: 13.0)),
                              ],
                            ))
                      ],
                    ),
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
          ),
        );
      },
    );
  }

  ListView _buildFoodMenuList() {
    return ListView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      padding: EdgeInsets.only(right: 20.0),
      itemCount: _dishes.length,
      itemBuilder: (context, index) {
        var item = _dishes[index];

        // print("bill total: $billtotal");

        return Padding(
          padding: EdgeInsets.only(left: 10.0, right: 10.0, top: 10.0),
          child: InkWell(
            onTap: () {
              Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => DetailsPage(
                        heroTag: item.imagepath,
                        foodName: item.name,
                        foodPrice: item.price,
                        foodDescription: item.decription,
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
                            image: AssetImage(item.imagepath),
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

  void _populateFavouriteDishes() {
    var list = <Food>[
      Food(
        name: 'Tyeng Gweno',
        price: '5000',
        decription:
            'Zinge that meal and rock Favourite Chicken Plaza Meant for youyour pallete.Favourite Chicken Plaza Meant for you',
        imagepath: 'assets/burger.png',
        quantity: 1,
      ),
      Food(
        name: 'Molokony',
        price: '2000',
        decription:
            'Favourite Chicken Plaza.Favourite Chicken Plaza Meant for you Meant for you.Favourite Chicken Plaza Meant for you',
        imagepath: 'assets/images/plate6.png',
        quantity: 1,
      ),
      Food(
        name: 'Zodongo Meal',
        price: '2000',
        decription:
            'Favourite Chicken Plaza.Favourite Chicken Plaza Meant for you Meant for you.Favourite Chicken Plaza Meant for you',
        imagepath: 'assets/images/plate3.png',
        quantity: 1,
      ),
      Food(
        name: 'Patrick Special',
        price: '2000',
        decription:
            'Favourite Chicken Plaza.Favourite Chicken Plaza Meant for you Meant for you.Favourite Chicken Plaza Meant for you',
        imagepath: 'assets/images/plate2.png',
        quantity: 1,
      ),
      Food(
        name: 'Sedrick Special',
        price: '2000',
        decription:
            'Favourite Chicken Plaza.Favourite Chicken Plaza Meant for you Meant for you.Favourite Chicken Plaza Meant for you',
        imagepath: 'assets/images/plate1.png',
        quantity: 1,
      ),
    ];

    setState(() {
      _favdishes = list;
    });
  }

  void _populateDishes() {
    var list = <Food>[
      Food(
        name: 'Chicken Zinger',
        price: '5000',
        decription:
            'Zinge that meal and rock Favourite Chicken Plaza Meant for youyour pallete.Favourite Chicken Plaza Meant for you',
        imagepath: 'assets/plate1.png',
        quantity: 1,
      ),
      Food(
        name: 'Chicken',
        price: '2000',
        decription:
            'Favourite Chicken Plaza.Favourite Chicken Plaza Meant for you Meant for you.Favourite Chicken Plaza Meant for you',
        imagepath: 'assets/plate2.png',
        quantity: 1,
      ),
      Food(
        name: 'Rice',
        price: '5000',
        decription:
            'Favourite Chicken Plaza.Favourite Chicken Plaza Meant for you Meant for you.The assorted Rice content meant for you',
        imagepath: 'assets/plate3.png',
        quantity: 1,
      ),
      Food(
        name: 'Beef',
        price: '5000',
        decription:
            'The Best Beef.Favourite Chicken.Favourite Chicken Plaza Meant for you Plaza Meant for you Burger in the Land',
        imagepath: 'assets/plate4.png',
        quantity: 1,
      ),
      Food(
        name: 'Sausage ',
        price: '5000',
        decription:
            'checkout our.Favourite Chicken.Favourite Chicken Plaza Meant for you Plaza Meant for you sauage',
        imagepath: 'assets/saucesage.png',
        quantity: 1,
      ),
      Food(
        name: 'Deck',
        price: '5000',
        decription:
            'Where .Favourite Chicken Plaza Meant for youall,Favourite Chicken Plaza Meant for you the local foods meet and dine',
        imagepath: 'assets/plate5.png',
        quantity: 1,
      ),
      Food(
        name: 'Mac',
        price: '5000',
        decription:
            'Favourite.Favourite Chicken Plaza ,Favourite Chicken Plaza Meant for youMeant for you Mac Food meant for you',
        imagepath: 'assets/plate6.png',
        quantity: 1,
      ),
    ];

    setState(() {
      _dishes = list;
    });
  }
}
