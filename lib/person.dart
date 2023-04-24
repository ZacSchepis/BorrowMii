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
  List<dynamic> _friends = <dynamic>[];
  bool has_items = false;
  bool has_Bitems = false;

  Person(String username, String password) {
    _username = username;
    _password = password;
  }

  String get name => _name;
  String get password => _password;
  String get uname => _username;
  String get dob => _dob;
  List<dynamic> get myItems => _myItems;
  List<dynamic> get bItems => _borrowedItems;
  List<dynamic> get friends => _friends;

  void setUserName(String uname) {
    _username = uname;
  }

  void setPassword(String password) {
    _password = password;
  }

  void setItems(List<dynamic> items) {
    _myItems = items;
  }

  void setborrowedItems(List<dynamic> borroweditems) {
    _borrowedItems = borroweditems;
  }

  void setFriendList(List<dynamic> friends) {
    _friends = friends;
  }

  void setName(String name) {
    _name = name;
  }

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
      if (_friends != null) "friends": friends,
    };
  }

  Map<String, dynamic> friendToFirestore() {
    return {
      if (_name != null) "name": _name,
      if (uname != null) "userName": _username,
      // if (_myItems != null) "myItems": myItems,
    };
  }

  void addItem(Item item) {
    // when item is added just push button to add it set owner to current user and prompt user name tool
    item.setStatus("Available");
    myItems.add(item.toFirestore());
  }

  void removeItem(Item item) {
    myItems.removeWhere((element) => element["itemName"] == item.itemname);
  }

  void removeItemFromName(String n) {
    myItems.removeWhere((element) => element["itemName"] == n);
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

  void addFriend(Person friend) {
    friends.add(friend.friendToFirestore());
  }

  void addFriendByString(String friendUName) {
    friends.add(friendUName);
  }

  void removeFriend(Person friend) {
    friends.removeWhere((element) => element["userName"] == friend.uname);
  }

  void removeFriendByString(String frienduName) {
    friends.removeWhere((element) => element == frienduName);
  }
}
