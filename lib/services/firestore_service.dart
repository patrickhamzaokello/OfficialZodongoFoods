import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:uuid/uuid.dart';

import '../foodObject.dart';

class FirestoreService {
  FirebaseFirestore _db = FirebaseFirestore.instance;

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
}
