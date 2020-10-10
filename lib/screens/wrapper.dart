import 'package:flutter/material.dart';
import 'package:flutterloginui/models/user.dart';
import 'package:flutterloginui/screens/authenticate/authenticate.dart';
import 'package:flutterloginui/screens/home/home.dart';
import 'package:provider/provider.dart';

class Wrapper extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<UserObj>(context);

    //return either home or authenticte widget
    // if (user == null) {
    //   return Authenticate();
    // } else {
    return Home();
    // }
  }
}
