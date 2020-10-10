import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutterloginui/models/brew.dart';

class DatabaseService {
  final String uid;
  DatabaseService({this.uid});

  //collection reference
  final CollectionReference brewCollection =
      FirebaseFirestore.instance.collection('brews');

  Future updateUserData(String name, String phone, String email) async {
    return await brewCollection.doc(uid).set({
      'name': name,
      'phone': phone,
      'email': email,
    });
  }

  // brew list from snapshot
  List<Brew> _brewListFromSnapshot(QuerySnapshot snapshot) {
    return snapshot.docs.map((doc) {
      return Brew(
        name: doc.data()['name'] ?? '',
        phonenumber: doc.data()['phone'] ?? '',
        email: doc.data()['email'],
      );
    }).toList();
  }

  //get brews stream
  Stream<List<Brew>> get userinfo {
    return brewCollection.snapshots().map(_brewListFromSnapshot);
  }
}
