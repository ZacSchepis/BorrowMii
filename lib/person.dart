import 'package:cloud_firestore/cloud_firestore.dart';

import 'item.dart';
import 'databaseController.dart';

class Person {
  String _username = "";
  String _name = "";
  String _password = "";
  String _dob = "";
  List<dynamic> _myItems = <dynamic>[];
  List<dynamic> _borrowedItems = <dynamic>[];
  List<Item> requestedItems = <Item>[];
  List<Person> friends = <Person>[];
  bool has_items = false;
  bool has_Bitems = false;

  Person(String username, String password) {
    _username = username;
    _password = password;
  }

  String get name => _name;
  String get uname => _username;
  String get dob => _dob;
  List<dynamic> get myItems => _myItems;
  List<dynamic> get bItems => _borrowedItems;

  void setUserName(String uname) {
    _username = uname;
  }

  void setItems(List<dynamic> items) {
    _myItems = items;
  }

  void setborrowedItems(List<dynamic> borroweditems) {
    _borrowedItems = borroweditems;
  }

  void setPassword(String password) {
    _password = password;
  }

  void setName(String name) {
    _name = name;
  }

  // void setUItems() async {
  //   _myItems = await getUserInventory();
  // }

  // void setBItems() async {
  //   _borrowedItems = await getBorrowedInventory();
  // }

  List<Map<String, dynamic>> inventoryMapping() {
    List<Map<String, dynamic>> inventory = <Map<String, dynamic>>[];
    for (int i = 0; i < myItems.length; i++) {
      inventory.add(myItems[i]);
    }
    return inventory;
  }

  List<Map<String, dynamic>> borrowedInventoryMapping() {
    List<Map<String, dynamic>> inventory = <Map<String, dynamic>>[];
    for (int i = 0; i < bItems.length; i++) {
      inventory.add(bItems[i]);
    }
    return inventory;
  }

  Map<String, dynamic> toFirestore() {
    return {
      if (_name != null) "name": _name,
      if (uname != null) "userName": _username,
      if (_password != null) "password": _password,
      if (_dob != null) "dob": _dob,
      if (_myItems != null) "myItems": myItems,
      if (_borrowedItems != null) "borrowedItems": bItems,
    };
  }

  // // Add friend when button selected to become friends

  // // see friend list

  void addItem(Item item) {
    // when item is added just push button to add it set owner to current user and prompt user name tool
    item.setStatus("Available");
    myItems.add(item.toFirestore());
  }

  void removeItem(Item item) {
    myItems.removeWhere((element) => element["itemName"] == item.itemname);
  }

  void borrowAItem(Item item) {
    if (item.getStatus() == "Available") {
      item.setStatus("Borrowed");
      bItems.add(item.toFirestore());
    }
  }

  void returnItem(Item item) {
    item.setStatus("Available");
    bItems.removeWhere((element) => element["itemName"] == item.itemname);
  }

  // void requestItem(Item item) {
  //   if (item.getStatus() == "Available") {
  //     item.setStatus("Requested");
  //   }
  // }

  // void acceptRequests(Item item) {
  //   if (item.getStatus() == "Requested") {
  //     item.setStatus("Borrowed");
  //     borrowedItems.add(item);
  //   }
  // }
}
