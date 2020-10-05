import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:uuid/uuid.dart';

import '../foodObject.dart';

class FirestoreService {
  FirebaseFirestore _db = FirebaseFirestore.instance;

  Future<void> saveFood(List<Food> food) {
    var pk;
    var uuid = Uuid();

    for (var i = 0; i < food.length; i++) {
      pk = _db.collection('myCart').doc(uuid.v4()).set(food[i].toMap());
    }
    return pk;
  }
}
