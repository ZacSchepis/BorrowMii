import 'dart:async';

import 'package:borrow_mii/data/datasources/items/items_state.dart';
import 'package:borrow_mii/data/models/item_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class MyLoansState extends ItemsState {
  MyLoansState() : super();

  StreamSubscription<QuerySnapshot<ItemModel>>? _subscription;
  @override
  void loadItems(String userId) {
    _subscription ??= repo.getMyLoans(userId).listen((snapshot) {
      items = snapshot.docs.map((doc) => doc.data()).toList();
      notifyListeners();
    });
  }

  @override
  void dispose() {
    _subscription?.cancel();
    super.dispose();
  }
}
