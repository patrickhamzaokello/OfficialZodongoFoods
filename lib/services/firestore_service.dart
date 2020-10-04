import 'package:cloud_firestore/cloud_firestore.dart';

import '../foodObject.dart';

class FirestoreService {
  FirebaseFirestore _db = FirebaseFirestore.instance;

  Future<void> savefood(Food food) {
    return _db.collection('foods').doc(food.name).set(food.toMap());
  }
}
