import 'package:flutter/material.dart';

class SearchFood extends StatefulWidget {
  @override
  _SearchFoodState createState() => _SearchFoodState();
}

class _SearchFoodState extends State<SearchFood> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
      title: Text("Search Food"),
    ));
  }
}
