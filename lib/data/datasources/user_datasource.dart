import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class UserState  extends ChangeNotifier{
  User? _user;
  void setUser(User? user) {
    if(user == null) {
      _user = null;
    } else {
      _user = user;
    }
    notifyListeners();
  }
  String? getUserID() {
    return _user?.uid;
  }
  String? get userName => _user?.displayName;
  // void setUser(String id, String mail) {
  //   userId = id;
  //   email =email;
  //   notifyListeners();
  // }
  // void clearUser() {
  //   userId = null;
  //   email = null;
  //   notifyListeners();
  // }

}