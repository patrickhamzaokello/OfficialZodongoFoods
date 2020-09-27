import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'detailPage.dart';
import 'checkout.dart';
import 'shopping.dart';

class Browse extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          title: Text("Zodongo Foods"),
          backgroundColor: Color(0xFF5AC035),
        ),
        body: Container(
          child: MyHomePage(),
        ),
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: <Widget>[
          SizedBox(height: 20.0),
          // Padding(
          //   padding: EdgeInsets.only(left: 15.0, right: 15.0),
          //   child: Row(
          //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
          //     children: <Widget>[
          //       IconButton(
          //         onPressed: () {},
          //         icon: Icon(Icons.menu),
          //         color: Colors.black,
          //       ),
          //       Container(
          //         height: 40.0,
          //         width: 40.0,
          //         decoration: BoxDecoration(
          //             borderRadius: BorderRadius.circular(7.0),
          //             image: DecorationImage(
          //                 image: AssetImage('assets/images/avocado.png'),
          //                 fit: BoxFit.cover)),
          //       )
          //     ],
          //   ),
          // ),
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
            child: ListView(
              scrollDirection: Axis.horizontal,
              children: <Widget>[
                _buildListItem(
                  'assets/burger.png',
                  'Beef Burger',
                  '7000',
                  'This Burger home-cooked food is low salt and low oil with balanced nutrition, selected from high-quality ingredients. This delicious food maybe your best healthy choice.',
                ),
                _buildListItem(
                  'assets/plate6.png',
                  'BBQ  Plate',
                  '5500',
                  'This light home-cooked food is low salt and low oil with balanced nutrition, selected from high-quality ingredients. This delicious food maybe your best healthy choice.',
                ),
                _buildListItem(
                  'assets/plate3.png',
                  'Vegan Breakfast',
                  '8000',
                  'This light home-cooked food is low salt and low oil with balanced nutrition, selected from high-quality ingredients. This delicious food maybe your best healthy choice.',
                ),
                _buildListItem(
                  'assets/images/plate2.png',
                  'Protein Salad',
                  '7500',
                  'This light home-cooked food is low salt and low oil with balanced nutrition, selected from high-quality ingredients. This delicious food maybe your best healthy choice.',
                ),
              ],
            ),
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
          ListView(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              padding: EdgeInsets.only(right: 20.0),
              children: [
                _buildFoodItem('assets/plate1.png', 'Salmon', '5000',
                    'The Best Beef Burger in the Land'),
                _buildFoodItem('assets/plate2.png', 'Spring bowl', '4000',
                    'Spring Bowl made from local available content'),
                _buildFoodItem('assets/images/plate6.png', 'BBQ Combo', '6000',
                    'You need to try out our BBQ specially made for your tasty buds'),
                _buildFoodItem('assets/beans.png', 'Beans Bowl', '4500',
                    'There is nothing like our own Beans plate that is served with much favour and juice'),
                _buildFoodItem('assets/images/plate3.png', 'Boo', '4000',
                    'Lets talk about quality for all the party people'),
                _buildFoodItem('assets/chicken.png', 'Muchomo', '7000',
                    'Muchome is the word, get your own from zodongo food'),
                _buildFoodItem('assets/macd.png', 'WI-D bowl', '5500',
                    'Mach and Cheese, we make it all. Try it out with us'),
                _buildFoodItem('assets/plate5.png', 'Berry bowl', '4000',
                    'For all the Vegan Friends out there. we gat what you need ')
              ]),
        ],
      ),
      bottomNavigationBar: Container(
        height: 75.0,
        decoration: BoxDecoration(
          // borderRadius: BorderRadius.only(
          // topLeft: Radius.circular(50.0), topRight: Radius.circular(50.0)),
          color: Color(0xFF5AC035),
        ),
        padding: EdgeInsets.only(left: 40.0, right: 40.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            IconButton(
              onPressed: () {
                // Navigator.of(context).push(
                //   (MaterialPageRoute(builder: (context) => ShoppingCart())),
                // );
              },
              icon: Icon(
                Icons.bookmark_border,
                color: Colors.white,
              ),
            ),
            Icon(
              Icons.search,
              color: Colors.white,
            ),
            Icon(
              Icons.person_outline,
              color: Colors.white,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 2.0),
              child: GestureDetector(
                child: Stack(
                  alignment: Alignment.topCenter,
                  children: <Widget>[
                    Icon(
                      Icons.shopping_cart,
                      color: Colors.white,
                      size: 25.0,
                    ),
                    if (savedWords.length > 0)
                      Padding(
                        padding: const EdgeInsets.only(left: 2.0),
                        child: CircleAvatar(
                          radius: 8.0,
                          backgroundColor: Colors.red,
                          foregroundColor: Colors.white,
                          child: Text(
                            savedWords.length.toString(),
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 12.0,
                            ),
                          ),
                        ),
                      ),
                  ],
                ),
                onTap: () {
                  if (savedWords.isNotEmpty)
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => CheckoutPage(),
                      ),
                    );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Set<String> savedWords = Set<String>();

  Widget _buildFoodItem(
      String imgPath, String foodName, String price, String description) {
    bool isSaved = savedWords.contains(foodName);

    return Padding(
      padding: EdgeInsets.only(left: 10.0, right: 10.0, top: 10.0),
      child: InkWell(
        onTap: () {
          Navigator.of(context).push(MaterialPageRoute(
              builder: (context) => DetailsPage(
                    heroTag: imgPath,
                    foodName: foodName,
                    foodPrice: price,
                    foodDescription: description,
                  )));
        },
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Container(
                child: Row(children: [
              Hero(
                  tag: imgPath,
                  child: Image(
                      image: AssetImage(imgPath),
                      fit: BoxFit.cover,
                      height: 75.0,
                      width: 75.0)),
              SizedBox(width: 10.0),
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                Text(foodName,
                    style: TextStyle(
                        fontFamily: 'Montserrat',
                        fontSize: 17.0,
                        fontWeight: FontWeight.bold)),
                Text('UGX $price',
                    style: TextStyle(
                        fontFamily: 'Montserrat',
                        fontSize: 15.0,
                        color: Colors.grey))
              ])
            ])),
            GestureDetector(
              onTap: () {
                setState(() {
                  if (isSaved) {
                    savedWords.remove(foodName);
                  } else {
                    savedWords.add(foodName);
                  }
                });
                print(savedWords);
              },
              child: Icon(
                isSaved ? Icons.favorite : Icons.add,
                color: isSaved ? Colors.red : null,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildListItem(
      String imgPath, String foodName, String price, String description) {
    return InkWell(
        onTap: () {
          Navigator.of(context).push((MaterialPageRoute(
              builder: (context) => DetailsPage(
                    heroTag: imgPath,
                    foodName: foodName,
                    foodPrice: price,
                    foodDescription: description,
                  ))));
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
                                topRight: Radius.circular(10.0)))),
                    Hero(
                        tag: imgPath,
                        child: Container(
                          height: 175.0,
                          decoration: BoxDecoration(
                              image: DecorationImage(
                                  image: AssetImage(imgPath),
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
                                      color: Colors.red, size: 17.0)),
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(15.0),
                                  color: Colors.white),
                            ))),
                    Positioned(
                        top: 190.0,
                        left: 10.0,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text(foodName,
                                style: TextStyle(
                                    fontFamily: 'Montserrat',
                                    fontWeight: FontWeight.w600,
                                    color: Colors.black,
                                    fontSize: 14.0)),
                            SizedBox(height: 3.0),
                            Container(
                                width: 175.0,
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
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
                                    Text('Ugx ' + price,
                                        style: TextStyle(
                                            fontFamily: 'Montserrat',
                                            fontWeight: FontWeight.w500,
                                            color: Colors.black,
                                            fontSize: 13.0)),
                                  ],
                                ))
                          ],
                        ))
                  ],
                ))));
  }
}
