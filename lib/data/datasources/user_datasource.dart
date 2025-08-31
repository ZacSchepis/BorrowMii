import 'package:flutter/material.dart';

class UserState  extends ChangeNotifier{
  String? userId;
  String? email;

  void setUser(String id, String mail) {
    userId = id;
    email =email;
    notifyListeners();
  }
  void clearUser() {
    userId = null;
    email = null;
    notifyListeners();
  }

}