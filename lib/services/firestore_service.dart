import 'package:cloud_firestore/cloud_firestore.dart';

import '../foodObject.dart';

class FirestoreService {
  FirebaseFirestore _db = FirebaseFirestore.instance;

  Future<void> saveFood(Food food) {
    return _db.collection('orders').doc(food.foodid).set(food.toMap());
  }
}
