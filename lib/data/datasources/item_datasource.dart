// talks to firestore to get user items

import 'dart:async';

import 'package:borrow_mii/core/constants/firebase_collections.dart';
import 'package:borrow_mii/core/constants/item_status.dart';
import 'package:borrow_mii/data/models/borrow_order.dart';
import 'package:borrow_mii/item.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:borrow_mii/core/errors/item_errors.dart';
import 'package:borrow_mii/data/datasources/user_datasource.dart';
import 'package:borrow_mii/data/models/item_model.dart';

List<ItemModel> itemsCache = List.empty(growable: true);
class FirestoreItemsDataSource {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  Future<List<ItemModel>> getItems(String id) async {
    print("User: $id");
    final snapshot = await _firestore
      .collection(ITEMS).withConverter(fromFirestore: (d, o) => ItemModel.fromFirestore(d, o, id), toFirestore: (ItemModel item, _) => item.toFirestore())
      // .where("ownerId", isEqualTo: id)
      .where(
        Filter.or(
            Filter("ownerId", isEqualTo: id),
            Filter("borrowerId", isEqualTo: id) 
          )
      )
      .get();
      if(snapshot.docs.isNotEmpty) {
        List<ItemModel> items = List.empty(growable: true);
        for(final doc in snapshot.docs){
          items.add(doc.data());
        }
        return items;
      } else {
        throw ItemException("No items found");
      }

      // return 
      
    
    // throw ItemException("Remote not implemented");
  }
  Future<ItemModel> getItemById(String id, String uId) async {
    final snapshot = await _firestore
      .collection(ITEMS)
      .withConverter(fromFirestore: (d, o) => ItemModel.fromFirestore(d, o, uId), toFirestore: (ItemModel item, _) => item.toFirestore())
      .doc(id)
      .get();
    if(snapshot.exists) {
      final d = snapshot.data();
      final owner = d?.ownerId;
      if(owner == null || owner.isEmpty) {
        throw ItemUnownedException("Item is unowned");
      }
      return d!;
    } else {
      throw ItemException("Item with ID $id not found");
    }
  }
  Future<void> addItem(ItemModel item, String uId) async {
    _firestore
      .collection(ITEMS)
      .withConverter(fromFirestore: (d, o) => ItemModel.fromFirestore(d, o, uId), toFirestore: (ItemModel item, _) => item.toFirestore())
      .doc(item.id).set(item)  
      ;
  }
  Future<String?> addBorrowOrder(BorrowOrder order) async {
    final bId = order.borrowerId;
    if(bId != null && bId.isEmpty) {
      throw BorrowerMissingException("You must be signed in to borrow this item!");
    } 
    // final isFutureOrSoon = DateTime.now().compareTo(order.borrowDate);
    // final isPast = DateTime(year)
    // if(DateTime().compareTo(bo))
    final snap = _firestore.collection(FirebaseCollections.borrowOrders.name).withConverter(
      toFirestore: (BorrowOrder o,_) => o.toFirestore(),
      fromFirestore: BorrowOrder.fromFirestore
      
      );
      print("The coll: ${FirebaseCollections.borrowOrders.name}");
      final oId = order.id ?? "";
      DocumentReference<BorrowOrder> doc;
      if(oId.isNotEmpty) {
        await snap.doc(oId).set(order);
        return oId; 
      } else {
        final doc =  snap.doc();
        order.id = doc.id;
        await doc.set(order);
        return doc.id;
      }
      // final doc = oId.isNotEmpty ? snap.doc(oId) : snap.doc();
      // order.id = doc.id;
      // return order.id;
  }
 Stream<QuerySnapshot<ItemModel>> listenForItems(BuildContext ctx, List<ItemModel> borrows, VoidCallback onUpdate) {
    final userId = ctx.read<UserState>().getUserID();
    if(userId == null || userId.isEmpty) throw ItemException("You must be signed in to watch your items feed");
    
    return _firestore.collection(FirebaseCollections.items.name)
            .withConverter(fromFirestore: (d, o) => ItemModel.fromFirestore(d,o, userId), toFirestore: (ItemModel o, _) => o.toFirestore())
            .where(
                Filter.or(
                  Filter("ownerId", isEqualTo: userId),
                  Filter("borrowerId", isEqualTo: userId)
                )
              )
            .snapshots();
  }

  StreamSubscription<QuerySnapshot<BorrowOrder>> listenForBorrows(BuildContext ctx, List<BorrowOrder> borrows, VoidCallback onUpdate) {
    final userId = ctx.read<UserState>().getUserID();
    if(userId == null || userId.isEmpty) throw ItemException("You must be signed in to watch your borrow requests");
    
    return _firestore.collection(FirebaseCollections.borrowOrders.name)
            .withConverter(fromFirestore: BorrowOrder.fromFirestore, toFirestore: (BorrowOrder o, _) => o.toFirestore())
            .where("ownerId", isEqualTo: userId)
            
            .snapshots()
            .listen((event) {
              for(var change in event.docChanges) {
                // final b = change.doc.data()
                switch (change.type) {
                  case DocumentChangeType.added: {
                    borrows.add(change.doc.data()!);
                    onUpdate();
                    break;
                  }
                  case DocumentChangeType.removed:  {
                    final borrowId = change.doc.data();
                    final existingItem = borrows.firstWhere((e) => e.id == borrowId!.id );
                    borrows.remove(existingItem);
                    onUpdate();
                    break;
                  }
                  default: break;
                }
              }
            });
  }
  Future<BorrowOrder?> getBorrowOrderFromBorrower(String itemId, String borrowerId) async{
    final o = 
          await _firestore
                .collection(FirebaseCollections.borrows.name)
                .withConverter(fromFirestore: BorrowOrder.fromFirestore, toFirestore: (BorrowOrder o, _) => o.toFirestore())
                .where(
                  Filter.and(
                    Filter("borrowerId", isEqualTo: borrowerId),
                    Filter("itemId", isEqualTo: itemId)
                  )
                ).limit(1).get();
        if(o.docs.isNotEmpty) {
          return o.docs[0].data();
        } else {
          throw ItemException("Requested borrow order doesn't exist");

        }
  }
  Future<BorrowOrder?> getBorrowOrder(String id) async {
    final o = await _firestore.collection(FirebaseCollections.borrowOrders.name).withConverter(fromFirestore: BorrowOrder.fromFirestore, toFirestore: (BorrowOrder o, _) => o.toFirestore()).doc(id).get();
    return o.data();
  }
  
  Future<void> removeBorrowOrder(String id) async {
    return _firestore.collection(FirebaseCollections.borrowOrders.name).doc(id).delete();
  }
  Future<void> approveBorrowOrder(String id, ItemStatus status) async {
    
    final order = await getBorrowOrder(id);
    if(order == null) {
      return;
    } 
    // final item = await getItemById(order.itemId);
    // if(item == null) {
    //   item.status = ItemStatus.borrowed;
    //   return;
    // }
    String borrowerId = status == ItemStatus.home ? "" : order.borrowerId!;
    if(status == ItemStatus.borrowed) {
      await _firestore.collection(FirebaseCollections.borrows.name).doc(order.id).set(order.toFirestore());
    }
    await _firestore.collection(FirebaseCollections.items.name).doc(order.itemId).update({"status": status.name, "borrowerId": borrowerId });
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
    return itemsCache.firstWhere((e) => e.id == id);
  }
}