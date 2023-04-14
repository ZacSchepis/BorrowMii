import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:team_d_project/Notifiers/user_notifier.dart';

import 'item.dart';
import 'person.dart';
import 'Notifiers/user_notifier.dart';
import 'databaseController.dart';

class CurrentUser extends Person {
  static String _uName = "";
  static String _password = "";
  // List<Item> _uItems = <Item>[];
  // String _name = "";
  // String _password = "";
  // List<Item> _myItems = <Item>[];
  // List<Item> borrowedItems = <Item>[];
  // List<Item> requestedItems = <Item>[];
  // List<Person> friends = <Person>[];

  CurrentUser() : super(_uName, _password);

  void setUName(String username) {
    _uName = username;
  }

  void setUPassword(String password) {
    _password = password;
  }

  // void setUItems() {
  //   _uItems = getUserItems();
  // }

  getCurrentUname() {
    return _uName;
  }

  getCurrentPassword() {
    return _password;
  }

  String get uname => _uName;
}
