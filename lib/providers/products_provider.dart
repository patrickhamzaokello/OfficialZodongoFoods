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
  String _description;
  String _imagepath;
  int _quantity;
  var uuid = Uuid();

  //Getters
  String get foodid => _foodid;
  String get name => _name;
  String get price => _price;
  String get description => _description;
  String get imagepath => _imagepath;
  int get quantity => _quantity;

  Stream<List<Food>> get foods => firestoreService.getFoods();

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

    print('items items $items');
    return items;
  }

  saveCardOrders(List<Food> mycart) {
    var datenow = (DateTime.now()).toString();
    // print(new DateFormat.yMd().add_jm().format(new DateTime.now()));

    firestoreService
        .saveDate(datenow)
        .then((value) => print('datesaved'))
        .catchError((error) {
      print(error);
    });

    firestoreService
        .setEntry(convertMyCartToMap(cartitems: mycart), datenow)
        .then((result) {
      print("Success!");
      print(convertMyCartToMap(cartitems: mycart));
    }).catchError((error) {
      print("Error! $error");
      return;
    });
  }
}
