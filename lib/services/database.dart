import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutterloginui/models/foodObject.dart';

class DatabaseService {
  final String uid;
  DatabaseService({this.uid});

  //collection reference
  final CollectionReference userCollection =
      FirebaseFirestore.instance.collection('ZodongoUsers');

  final CollectionReference onlineFoodCollection =
      FirebaseFirestore.instance.collection('FoodListings');

  Future updateUserData(String name, String phone, String email) async {
    return await userCollection.doc(uid).set({
      'name': name,
      'phone': phone,
      'email': email,
    });
  }

  //Save Orders to Database
  // Future saveOrders(List<Food> food) async {
  //   return await userCollection
  //       .doc(uid)
  //       .collection("Orders")
  //       .doc()
  //       .set(food[0].toMap());
  // }

  // Food list from snapshot
  List<Food> _foodListFromSnapshot(QuerySnapshot snapshot) {
    return snapshot.docs.map((doc) {
      return Food(
        foodid: doc.data()['foodid'] ?? '',
        name: doc.data()['name'] ?? '',
        price: doc.data()['price'] ?? '',
        description: doc.data()['description'] ?? '',
        imagepath: doc.data()['imagepath'] ?? '',
        quantity: doc.data()['quantity'] ?? '',
      );
    }).toList();
  }

  //get Foods stream
  Stream<List<Food>> get foodlisting {
    return onlineFoodCollection.snapshots().map(_foodListFromSnapshot);
  }
}
