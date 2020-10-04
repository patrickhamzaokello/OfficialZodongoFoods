import 'package:flutter/material.dart';
import 'foodObject.dart';
import 'detailPage.dart';

class Cart extends StatefulWidget {
  final List<Food> _cart;
  final List<int> totalcost;
  final int bill;

  Cart(this._cart, this.totalcost, this.bill);

  @override
  _CartState createState() => _CartState(this._cart, this.totalcost, this.bill);
}

class _CartState extends State<Cart> {
  _CartState(this._cart, this.totalcost, this.bill);
  List<Food> _cart;
  List<int> totalcost;

  int bill;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF5AC035),
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
                    Navigator.pop(context);
                  },
                ),
                Container(
                    width: 125.0,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        IconButton(
                          icon: Icon(Icons.filter_list),
                          color: Colors.white,
                          onPressed: () {},
                        ),
                        IconButton(
                          icon: Icon(Icons.menu),
                          color: Colors.white,
                          onPressed: () {},
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
                Text('Order Cart',
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
                  'Total',
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
                Container(
                  height: 50.0,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(30.0),
                    color: Color(0xFF5AC035),
                  ),
                  child: GestureDetector(
                    onTap: () {
                      print("placing order clicke");
                      setState(() {});
                    },
                    child: Center(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Text(
                            'Place',
                            style: TextStyle(
                              fontFamily: 'Montserrat',
                              fontSize: 17.0,
                              color: Colors.white,
                            ),
                          ),
                          SizedBox(width: 10.0),
                          Text(
                            "Order",
                            style: TextStyle(
                                fontFamily: 'Montserrat',
                                fontSize: 18.0,
                                color: Colors.white,
                                fontWeight: FontWeight.bold),
                          )
                        ],
                      ),
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

  Widget _buildFoodItem() {
    return ListView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: _cart.length,
      itemBuilder: (context, index) {
        var item = _cart[index];
        int totalpsrice = (int.parse(item.price));

        return Padding(
          padding: EdgeInsets.only(left: 10.0, right: 10.0, top: 10.0),
          child: InkWell(
            onTap: () async {
              final result = await Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => DetailsPage(
                        heroTag: item.imagepath,
                        foodName: item.name,
                        foodPrice: item.price,
                        foodDescription: item.decription,
                        // foodqtn: item.quantity,
                      )));

              setState(() {
                item.quantity = result;

                // print("quantity: ${item.quantity}");
              });
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
                                fontSize: 14.0,
                                fontWeight: FontWeight.bold)),
                        Text('Ugx ${item.price}',
                            style: TextStyle(
                                fontFamily: 'Montserrat',
                                fontSize: 13.0,
                                color: Colors.grey)),
                        Text('Qtn: ${item.quantity}',
                            style: TextStyle(
                                fontFamily: 'Montserrat',
                                fontSize: 13.0,
                                color: Colors.grey))
                      ])
                ])),
                IconButton(
                    icon: Icon(
                      Icons.remove_circle,
                      color: Colors.red,
                    ),
                    color: Colors.red,
                    onPressed: () {
                      setState(() {
                        _cart.remove(item);
                        // totalprice.remove(totalpsrice);
                        totalcost.remove(totalpsrice);
                        // print("total $totalprice");
                        bill = bill - (int.parse(item.price));
                      });
                    })
              ],
            ),
          ),
        );
      },
    );
  }
}
