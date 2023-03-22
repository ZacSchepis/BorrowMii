import 'package:flutter/material.dart';
class Item {
  String _name = "";
  String _owner = "";
  Item(String name, String owner){
    _name = name;
    _owner = owner;
  }
  //method to display on screen
  @override
  Widget build(BuildContext context) {
    return Container();
  }
}