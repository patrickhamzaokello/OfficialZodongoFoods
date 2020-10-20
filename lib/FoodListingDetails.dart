import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class FoodListingDetails extends StatefulWidget {
  final heroTag;
  final foodName;
  final foodPrice;
  final foodDescription;

  FoodListingDetails({
    this.heroTag,
    this.foodName,
    this.foodPrice,
    this.foodDescription,
  });

  @override
  _FoodListingDetailsState createState() => _FoodListingDetailsState(
      this.heroTag, this.foodName, this.foodPrice, this.foodDescription);
}

class _FoodListingDetailsState extends State<FoodListingDetails> {
  _FoodListingDetailsState(
      this.heroTag, this.foodName, this.foodPrice, this.foodDescription);

  String heroTag;
  String foodName;
  String foodPrice;
  String foodDescription;
  @override
  Widget build(BuildContext context) {
    var nformat = NumberFormat("#,##0", "en_US");
    // int qtn = foodqtn;

    return Scaffold(
      body: ListView(
        children: <Widget>[
          Stack(
            children: <Widget>[
              Container(height: 300.0),
              Container(
                height: 200.0,
                decoration: BoxDecoration(
                    image: DecorationImage(
                        image: AssetImage('assets/images/green.jpg'),
                        fit: BoxFit.cover),
                    borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(100.0),
                        bottomRight: Radius.circular(100.0))),
              ),
              Positioned(
                  top: 50.0,
                  left: (MediaQuery.of(context).size.width / 2) - 125,
                  child: Hero(
                      tag: widget.heroTag,
                      child: Container(
                        height: 250.0,
                        width: 250.0,
                        decoration: BoxDecoration(
                            image: DecorationImage(
                                image: NetworkImage(widget.heroTag),
                                fit: BoxFit.cover)),
                      ))),
              Align(
                alignment: Alignment.topLeft,
                child: IconButton(
                  icon: Icon(Icons.arrow_back_ios),
                  color: Colors.white,
                  onPressed: () {
                    Navigator.pop(context);
                  },
                ),
              ),
              Align(
                alignment: Alignment.topRight,
                child: IconButton(
                  icon: Icon(Icons.more_horiz),
                  color: Colors.white,
                  onPressed: () {},
                ),
              )
            ],
          ),
          SizedBox(height: 10.0),
          Padding(
            padding: const EdgeInsets.only(left: 20.0, right: 20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(widget.foodName,
                    style: TextStyle(
                      fontFamily: 'Montserrat',
                      fontSize: 25.0,
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                    )),
                SizedBox(height: 10.0),
                Row(
                  children: <Widget>[
                    Text(
                      '4.9',
                      style: TextStyle(
                          fontFamily: 'Montserrat',
                          color: Colors.grey,
                          fontSize: 17.0),
                    ),
                    SizedBox(width: 10.0),
                    Icon(Icons.star, color: Colors.green, size: 16.0),
                    Icon(Icons.star, color: Colors.green, size: 16.0),
                    Icon(Icons.star, color: Colors.green, size: 16.0),
                    Icon(Icons.star, color: Colors.green, size: 16.0),
                    Icon(Icons.star, color: Colors.green, size: 16.0),
                  ],
                ),
                SizedBox(height: 25.0),
                Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Text(
                        'Ugx ' + nformat.format(int.parse(widget.foodPrice)),
                        style: TextStyle(
                            fontFamily: 'Montserrat',
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                            fontSize: 17.0),
                      ),
                    ]),
                SizedBox(height: 15.0),
                Text('About the food',
                    style: TextStyle(
                        fontFamily: 'Montserrat',
                        fontSize: 16.0,
                        color: Colors.black)),
                SizedBox(height: 15.0),
                Container(
                  child: Text(
                    widget.foodDescription,
                    style: TextStyle(
                        fontFamily: 'Montserrat',
                        fontSize: 14.0,
                        color: Colors.grey),
                  ),
                ),
                SizedBox(height: 15.0),
                Container(
                  height: 50.0,
                  margin: EdgeInsets.only(
                    bottom: 10.0,
                  ),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(30.0),
                    color: Color(0xFF5AC035),
                  ),
                  child: Center(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Text(
                          'Total',
                          style: TextStyle(
                            fontFamily: 'Montserrat',
                            fontSize: 17.0,
                            color: Colors.white,
                          ),
                        ),
                        SizedBox(width: 10.0),
                        Text(
                          'Ugx ' + nformat.format(int.parse(widget.foodPrice)),
                          style: TextStyle(
                              fontFamily: 'Montserrat',
                              fontSize: 18.0,
                              color: Colors.white,
                              fontWeight: FontWeight.bold),
                        )
                      ],
                    ),
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
