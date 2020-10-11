import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutterloginui/models/foodObject.dart';
import 'package:uuid/uuid.dart';

class FirestoreService {
  FirebaseFirestore _db = FirebaseFirestore.instance;

  //upsert
  Future<void> saveFood(List<Food> food) {
    var pk;
    var uuid = Uuid();

    var time = (Timestamp.now()).toString();

    pk = _db
        .collection('ZodongoCart')
        .doc()
        .collection("Orders")
        .doc()
        .set(food[0].toMap());

    return pk;
  }

  //upsert
  Future<void> setEntry(Food food) {
    var options = SetOptions(merge: true);
    return _db
        .collection('ZodongoOrders')
        .doc(food.foodid)
        .set(food.toMap(), options);
  }

  //get food listing from firestore
  Stream<List<Food>> getFood() {
    return _db.collection('FoodListing').snapshots().map((snapshot) =>
        snapshot.docs.map((doc) => Food.fromJson(doc.data())).toList());
  }

  Future<void> removeFood(String foodid) {
    return _db.collection('ZodongoOrders').doc(foodid).delete();
  }
}
