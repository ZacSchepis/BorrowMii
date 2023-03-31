import 'package:flutter/material.dart';

class Item {
  String _name = "";
  String _owner = "";
  String _status = "";

  @override
  Item(String name, String owner, String status) {
    this._name = name;
    this._owner = owner;
    this._status = status;
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
    return Container(
      child: Expanded(
        child: Row(
          children: [
            Icon(
              Icons.gavel,
              color: Colors.black,
              size: 24.0,
              semanticLabel: _name,
            ),
            Text(),

          ],
        )
      )
    );
  }
}
