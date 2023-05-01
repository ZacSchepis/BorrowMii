import 'package:flutter/material.dart';

class Item {
  String _itemName = "";
  String _owner = "";
  String _status = "";

  Item(String itemName, String owner, String status) {
    this._itemName = itemName;
    this._owner = owner;
    this._status = status;
  }

  // getters
  String get itemname => _itemName;

  String getOwner() {
    return _owner;
  }

  String getStatus() {
    return _status;
  }

  // setter
  void setStatus(String status) {
    _status = status;
  }

  // Creates a map of item information to store in database
  // want to add functionality of who currently is borrowing the item if it is borrowed
  Map<String, dynamic> toFirestore() {
    return {
      if (_itemName != null) "itemName": _itemName,
      if (_owner != null) "owner": _owner,
      if (_status != null) "status": _status,
    };
  }

  //method to display on screen
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(
          Icons.gavel,
          color: Colors.black,
          size: 24.0,
          semanticLabel: _itemName,
        ),
        const Text("    "),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(" Item:  $_itemName"),
            Text(" Owner:  $_owner "),
            Text(" Status: $_status "),
          ],
        ),
        const Text("    "),
      ],
    );
  }
}
