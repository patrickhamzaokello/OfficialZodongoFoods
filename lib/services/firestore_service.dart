import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutterloginui/models/foodObject.dart';

class FirestoreService {
  FirebaseFirestore _db = FirebaseFirestore.instance;

  //upsert
  Future<void> setEntry(Food food) {
    var options = SetOptions(merge: true);
    return _db
        .collection('brews')
        .doc('jSgv63SF7bVvWySRnBYVzF8flTK2')
        .collection('Cart')
        .doc()
        .set(food.toMap(), options);
  }

  //get food listing from firestore
  Stream<List<Food>> getFood() {
    return _db.collection('FoodListing').snapshots().map((snapshot) =>
        snapshot.docs.map((doc) => Food.fromJson(doc.data())).toList());
  }

  Future<void> removeFood(String foodid) {
    return _db.collection('PKfoods').doc(foodid).delete();
  }
}
