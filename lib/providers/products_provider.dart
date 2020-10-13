import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutterloginui/models/foodObject.dart';
import 'package:flutterloginui/services/firestore_service.dart';
import 'package:uuid/uuid.dart';

class ProductProvider with ChangeNotifier {
  final firestoreService = FirestoreService();
  String _foodid;
  String _name;
  String _price;
  String _decription;
  String _imagepath;
  int _quantity;
  var uuid = Uuid();
  DateTime _date;

  //Getters
  String get foodid => _foodid;
  String get name => _name;
  String get price => _price;
  String get decription => _decription;
  String get imagepath => _imagepath;
  int get quantity => _quantity;

  set changeName(String value) {
    _name = value;
    notifyListeners();
  }

  set changePrice(String value) {
    _price = value;
    notifyListeners();
  }

  //Functions
  loadAll(Food food) {
    if (food != null) {
    } else {}
  }

  static List<Map> convertMyCartToMap({List<Food> cartitems}) {
    List<Map> items = [];
    cartitems.forEach((Food cartitem) {
      Map item = cartitem.toMap();
      items.add(item);
    });
    return items;
  }

  saveCardOrders(List<Food> mycart) {
    var newFood = Food(
        name: "Patrick",
        price: "2500",
        quantity: 1,
        decription: "The best Pork chops ever",
        imagepath: "https://www.google.com/pkasemer",
        foodid: uuid.v1());

    firestoreService
        .setEntry(convertMyCartToMap(cartitems: mycart))
        .then((result) {
      print("Success!");
    }).catchError((error) {
      print("Error!");
      return;
    });
  }
}
