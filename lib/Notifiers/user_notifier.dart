import 'dart:collection';

// import 'package:adminpanel/model/allmodels.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:team_d_project/person.dart';
import 'package:team_d_project/item.dart';
import 'package:team_d_project/databaseController.dart';

class UserNotifier with ChangeNotifier {
  // List<Item> _userItemList = [];
  // Person _currentUser = Person(username: "", password: "");

  // UserNotifier();

  // UnmodifiableListView<Item> get userItemList =>
  //     UnmodifiableListView(_userItemList);

  // Person get currentUser => _currentUser;
  // // String get currentUserName => _currentUser.uname;

  // // void getInventory() {
  // //   getUserInventory(UserNotifier());
  // // }

  // // List<Item> getUserItems() {

  // // }

  // set userItemsList(List<Item> userItemList) {
  //   _userItemList = userItemList;
  //   notifyListeners();
  // }

  // set currentUser(Person user) {
  //   _currentUser = user;
  //   notifyListeners();
  //   // print(currentUser.uname);
  // }

  // addItem(Item item) {
  //   _userItemList.insert(0, item);
  //   notifyListeners();
  // }

  // // not sure with user.name???
  // deleteUser(Person user) {
  //   _userList.removeWhere((_user) => _user.name == user.name);
  //   notifyListeners();
  // }
}
