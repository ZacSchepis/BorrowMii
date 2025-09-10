// talks to firestore to get user items

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:borrow_mii/core/errors/item_errors.dart';
import 'package:borrow_mii/data/datasources/user_datasource.dart';
import 'package:borrow_mii/data/models/item_model.dart';

List<ItemModel> itemsCache = List.empty(growable: true);
class FirestoreItemsDataSource {
  Future<List<ItemModel>> getItems(String id) async {

    throw ItemException("Remote not implemented");
  }
  Future<ItemModel> getItemById(String id) async {
    throw ItemException("Remote not implemented");
  }
}

class FakeItemsDataSource {
  List<ItemModel> getFakeData() {
    return List.generate(3, ItemModel.generate);
  }
  ItemModel getItem() {
    ItemModel itm = ItemModel.generate(0);
    itm.dailyFeeEnabled = true;
    itm.flatFeeEnabled = true;
    itm.lateFeeCost = 10;
    itm.lateFeeDays = 2;
    itm.flatFeeCost = 100;
    itm.flatFeeMonths = 1;
    return itm;
  }
}
class LocalItemsDataSource {
  Future<void> cacheItems(List<ItemModel> items) async {
    // save to firestore    
    itemsCache.addAll(items);
  } 
  List<ItemModel> getCachedItems() {
    // 
    

    return itemsCache;
  }  
  
  ItemModel getCachedItem(String id) {
    return itemsCache.firstWhere((e) => e.itemId == id);
  }
}