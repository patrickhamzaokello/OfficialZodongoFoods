import 'package:flutter/material.dart';
import 'package:flutterloginui/detailPage.dart';
import 'package:flutterloginui/models/foodObject.dart';
import 'package:intl/intl.dart';

var numformat = NumberFormat("#,##0", "en_US");

class BrewTile extends StatefulWidget {
  final Food item;
  final List<Food> cartList;
  BrewTile({this.item, this.cartList});

  @override
  _BrewTileState createState() => _BrewTileState(this.cartList);
}

class _BrewTileState extends State<BrewTile> {
  _BrewTileState(this.cartList);
  List<Food> cartList;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: 10.0, right: 10.0, top: 10.0),
      child: InkWell(
        onTap: () {
          Navigator.of(context).push(MaterialPageRoute(
              builder: (context) => DetailsPage(
                    heroTag: widget.item.imagepath,
                    foodName: widget.item.name,
                    foodPrice: widget.item.price,
                    foodDescription: widget.item.description,
                  )));

          setState(() {});
        },
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Container(
              child: Row(children: [
                Hero(
                    tag: widget.item.imagepath,
                    child: Image(
                        // image: AssetImage(widget.item.imagepath),
                        image: NetworkImage(widget.item.imagepath),
                        fit: BoxFit.cover,
                        height: 75.0,
                        width: 75.0)),
                SizedBox(width: 10.0),
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                  Text(widget.item.name,
                      style: TextStyle(
                          fontFamily: 'Montserrat',
                          fontSize: 15.0,
                          fontWeight: FontWeight.bold)),
                  Text('UGX ' + numformat.format(int.parse(widget.item.price)),
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
                  if (!cartList.contains(widget.item)) {
                    widget.item.pricechange = widget.item.price;
                    widget.item.qtnchange = widget.item.quantity;
                    cartList.add(widget.item);
                  } else {
                    widget.item.pricechange = widget.item.price;
                    widget.item.qtnchange = widget.item.quantity;
                    cartList.remove(widget.item);
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
                    child: (!cartList.contains(widget.item))
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
  }
}
