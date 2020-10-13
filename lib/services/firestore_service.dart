import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutterloginui/models/foodObject.dart';

class FirestoreService {
  FirebaseFirestore _db = FirebaseFirestore.instance;
  final FirebaseAuth _auths = FirebaseAuth.instance;

  String useruid;

  Future<void> inputData() async {
    final User user = _auths.currentUser;
    final uid = user.uid;
    // here you write the codes to input the data into firestore
    useruid = uid;
    print("printing --- pk: $useruid");
  }

  //upsert
  Future<void> setEntry(List<Map> food) async {
    var options = SetOptions(merge: true);
    await inputData();
    return _db
        .collection('brews')
        .doc(useruid)
        .collection('Cart')
        .doc()
        .set(food[0], options);
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
