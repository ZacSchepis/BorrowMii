import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:team_d_project/data/datasources/item_datasource.dart';
import 'package:team_d_project/data/datasources/user_datasource.dart';
import 'package:team_d_project/data/models/item_model.dart';

class ItemRepository {
  FirestoreItemsDataSource remote;
  FakeItemsDataSource fakeData;
  LocalItemsDataSource local;

  ItemRepository () :
    remote = FirestoreItemsDataSource(),
    fakeData = FakeItemsDataSource(),
    local = LocalItemsDataSource();
  
  Future<List<ItemModel>> getMyItems(BuildContext context) async {
    try {
      final userId = context.read<UserState>().userId;
      final items = await remote.getItems(userId!);
      await local.cacheItems(items);
      return items;
    } catch (_) {
      return fakeData.getFakeData();
    }
  }
}