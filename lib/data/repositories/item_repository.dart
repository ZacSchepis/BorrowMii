import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:borrow_mii/data/datasources/item_datasource.dart';
import 'package:borrow_mii/data/datasources/user_datasource.dart';
import 'package:borrow_mii/data/models/item_model.dart';

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
      // final items = local.getCachedItems();
      final items = await remote.getItems(userId!);
      await local.cacheItems(items);
      return items;
    } catch (_) {
      return fakeData.getFakeData();
    }
  }
  Future<ItemModel?> getItemById(String id) async {
    try {
      final item = await remote.getItemById(id);
      await local.cacheItems([item]);
      return item;
      // return local.getCachedItem(id);

    } catch (_) {
      return fakeData.getItem();
      // return null;
    }
  }
  bool getIsMyItem(BuildContext context, String itemOwner) {
    final userId = context.read<UserState>().userId;
    return userId == itemOwner;
    // return true;
  }
}

class ImageRepository {
  // const ImageRepository();
  Future<void> uploadImageToGCS(XFile? img) async {
  }
  String getImageFromGCS(String path) {
    String img = "https://www.shutterstock.com/image-photo/cute-astronaut-cat-black-space-600w-2402632927.jpg";
    return img;
  }
}

class AuthRepository {
  
}