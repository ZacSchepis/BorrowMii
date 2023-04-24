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
  static bool _new_user = false;
  static bool _has_items = false;
  static bool has_borrowed_items = false;

  bool get nuser => _new_user;
  bool get hasItems => _has_items;
  bool get hasBItems => has_borrowed_items;
  String get uname => _uName;
  String get password => _password;

  CurrentUser() : super(_uName, _password);

  void setCUName(String username) {
    _uName = username;
  }

  void setCUPassword(String password) {
    _password = password;
  }

  void setNewUser(bool nuser) {
    _new_user = nuser;
  }

  void setHasItems(bool hasitems) {
    _has_items = hasitems;
  }

  void setHasBItems(bool hasBitems) {
    has_borrowed_items = hasBitems;
  }

  getCurrentUname() {
    return _uName;
  }

  getCurrentPassword() {
    return _password;
  }
}
