// import 'dart:collection';

// // import 'package:adminpanel/model/allmodels.dart';
// import 'package:flutter/cupertino.dart';
// import 'package:team_d_project/item.dart';

// class ItemNotifier with ChangeNotifier {
//   List<Item> _itemList = [];
//   Item _currentItem;

//   UnmodifiableListView<Item> get itemList => UnmodifiableListView(_itemList);

// Item get currentItem => _currentItem;

//   set itemList(List<Item> itemList) {
//     _itemList = itemList;
//     notifyListeners();
//   }

//   set currentItem(Item item) {
//     _currentItem = item;
//     notifyListeners();
//   }

//   addItem(Item item) {
//     _itemList.insert(0, item);
//     notifyListeners();
//   }

//   // not sure with user.name???
//   deleteItem(Item item) {
//     _itemList.removeWhere((_item) => _item.name == item.name);
//     notifyListeners();
//   }
// }