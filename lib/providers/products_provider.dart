import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutterloginui/foodObject.dart';
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

  //Getters
  String get foodid => _foodid;
  String get name => _name;
  String get price => _price;
  String get decription => _decription;
  String get imagepath => _imagepath;
  int get quantity => _quantity;

  changeName(String value) {
    _name = value;
    notifyListeners();
  }

  changePrice(String value) {
    _price = value;
    notifyListeners();
  }

  saveProduct() {
    // print("product saved");
    var newFood = Food(
        name: "pork",
        price: "2500",
        quantity: 1,
        decription: "The best Pork chops ever",
        imagepath: "https://www.google.com/pkasemer",
        foodid: uuid.v4());
    firestoreService.saveFood(newFood);
  }
}
