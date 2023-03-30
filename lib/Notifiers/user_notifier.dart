// import 'dart:collection';

// // import 'package:adminpanel/model/allmodels.dart';
// import 'package:flutter/cupertino.dart';
// import 'package:team_d_project/person.dart';

// class UserNotifier with ChangeNotifier {
//   List<Person> _userList = [];
//   Person _currentUser;

//   UnmodifiableListView<Person> get userList => UnmodifiableListView(_userList);

//   Person get currentUser => _currentUser;

//   set userList(List<Person> userList) {
//     _userList = userList;
//     notifyListeners();
//   }

//   set currentUser(Person user) {
//     _currentUser = user;
//     notifyListeners();
//   }

//   addUser(Person user) {
//     _userList.insert(0, user);
//     notifyListeners();
//   }

//   // not sure with user.name???
//   deleteUser(Person user) {
//     _userList.removeWhere((_user) => _user.name == user.name);
//     notifyListeners();
//   }
// }
