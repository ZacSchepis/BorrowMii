// talks to firestore to get user items

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:team_d_project/core/errors/item_errors.dart';
import 'package:team_d_project/data/datasources/user_datasource.dart';
import 'package:team_d_project/data/models/item_model.dart';

class FirestoreItemsDataSource {
  Future<List<ItemModel>> getItems(String id) async {

    throw ItemException("Remote not implemented");
  }
}
class FakeItemsDataSource {
  List<ItemModel> getFakeData() {
    return List.generate(3, ItemModel.generate);
  }
}
class LocalItemsDataSource {
  Future<void> cacheItems(List<ItemModel> items) async {
    // save to firestore    
  } 
  List<ItemModel> getCachedItems() {
    // 
    

    return List.empty();
  }  
  
}