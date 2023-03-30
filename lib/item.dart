import 'package:flutter/material.dart';

class Item {
  String _name = "";
  String _owner = "";
  String _status = "";
  Item(String name, String owner) {
    _name = name;
    _owner = owner;
  }

  String get name => _name;

  String getOwner() {
    return _owner;
  }

  String getStatus() {
    return _status;
  }

  void setStatus(String status) {
    _status = status;
  }

  //method to display on screen
  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
