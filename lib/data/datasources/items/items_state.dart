import 'dart:async';

import 'package:borrow_mii/data/models/item_model.dart';
import 'package:borrow_mii/data/repositories/item_repository.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

abstract class ItemsState extends ChangeNotifier {
  late List<ItemModel> items;
  ItemRepository repo;
  ItemsState() : items = List.empty(growable: true), repo = ItemRepository();
  void addItems(List<ItemModel> itms) {
    items.addAll(itms);
    notifyListeners();
  }

  void removeCachedItem(String id) {
    final initialLength = items.length;
    items.removeWhere((i) => i.id == id);
    if(initialLength != items.length) {
      notifyListeners();
    } 
  }

  void loadItems(String userId);
  @override
  void dispose();



  

}