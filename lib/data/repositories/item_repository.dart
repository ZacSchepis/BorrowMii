import 'package:borrow_mii/core/constants/item_status.dart';
import 'package:borrow_mii/core/errors/item_errors.dart';
import 'package:borrow_mii/data/models/borrow_order.dart';
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
      final userId = context.read<UserState>().getUserID();
      final items = await remote.getItems(userId!);
      // await local.cacheItems(items);
      return items;
    } catch (e) {
      print("Error retrieving items: $e");
      return fakeData.getFakeData();
    }
  }
  Future<ItemModel?> getItemById(String id, BuildContext context) async {
    try {
      final userId = context.read<UserState>().getUserID();

      final item = await remote.getItemById(id, userId!);
      return item;
    } on ItemUnownedException {
      return null;
    } catch (e) {
      rethrow;
    }
  }
  bool getIsMyItem(BuildContext context, String itemOwner) {
    final userId = context.read<UserState>().getUserID();
    return userId == itemOwner;
    // return true;
  }
  Future<String?> addBorrowOrder(BuildContext ctx, BorrowOrder order ) async {
    try {
      final borrowerId = ctx.read<UserState>().getUserID();
      if(borrowerId != null && borrowerId.isNotEmpty) {
        order.borrowerId = borrowerId;
        final borrowId = await remote.addBorrowOrder(order) ?? "";
        
        if(borrowId.isNotEmpty) {
          print("Borrow ID: $borrowId");
          return borrowId;
        }
        return null;
      }
    } catch (e) {
      rethrow;
    }
    return null;
  }
  Future<void> removeBorrowOrder(BuildContext ctx, String id) async {
    try {
      await remote.removeBorrowOrder(id);
    } catch (e) {
      print("Could not remove: $id\n$e");
    }
  }
  Future<void> acceptBorrowOrder(BuildContext ctx, String id, ItemStatus status) async {
    try {
      await remote.approveBorrowOrder(id, status);
      
      await removeBorrowOrder(ctx, id);
    } catch (e) {
      print("Could not accept: $id\n $e");
    }
  }
  Future<void> addItem(ItemModel item, BuildContext context) async {
    try {
      final userId = context.read<UserState>().getUserID();
      await remote.addItem(item, userId!);
    } catch (e) {
      print(e);
    }
  }
  Future<BorrowOrder?> getBorrowOrderFromContext(BuildContext context, String id) async {
    final userId = context.read<UserState>().getUserID();
    return remote.getBorrowOrderFromBorrower(id, userId!);
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