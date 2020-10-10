import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutterloginui/screens/home/brew_list.dart';
import 'package:flutterloginui/models/brew.dart';
import 'package:flutterloginui/services/auth.dart';
import 'package:flutterloginui/services/database.dart';

import 'package:provider/provider.dart';

class UserAccount extends StatefulWidget {
  @override
  _UserAccountState createState() => _UserAccountState();
}

class _UserAccountState extends State<UserAccount> {
  final AuthService _auth = AuthService();

  @override
  Widget build(BuildContext context) {
    return StreamProvider<List<Brew>>.value(
      value: DatabaseService().userinfo,
      child: Scaffold(
        appBar: AppBar(
          title: Text("User Account"),
          elevation: 0.0,
          actions: <Widget>[
            FlatButton.icon(
                onPressed: () async {
                  await _auth.signOut();
                },
                icon: Icon(Icons.person),
                label: Text('logout'))
          ],
        ),
        body: BrewList(),
      ),
    );
  }
}
