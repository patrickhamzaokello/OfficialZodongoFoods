import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:uuid/uuid.dart';

import '../foodObject.dart';

class FirestoreService {
  FirebaseFirestore _db = FirebaseFirestore.instance;

  Future<void> saveFood(List<Food> food) {
    var pk;
    var uuid = Uuid();

    var time = (Timestamp.now()).toString();

    for (var i = 0; i < food.length; i++) {
      pk = _db
          .collection('FoodCart')
          .doc('0777676206')
          .collection("sedrick")
          .doc(time)
          .collection("order")
          .doc(food[i].name)
          .set(food[i].toMap());
    }
    return pk;
  }
}
