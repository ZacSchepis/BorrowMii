import 'dart:async';

import 'package:borrow_mii/core/constants/dialog_options.dart';
import 'package:borrow_mii/core/constants/item_status.dart';
import 'package:borrow_mii/data/models/borrow_order.dart';
import 'package:borrow_mii/data/repositories/item_repository.dart';
import 'package:borrow_mii/features/borrow_requests/widgets/borrow_request.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class NonFriendlyBorrow  extends StatefulWidget{

  const NonFriendlyBorrow({
    super.key
  });

  @override
  State<NonFriendlyBorrow> createState() => _NonFriendlyBorrowWidgetState();
}

class _NonFriendlyBorrowWidgetState extends State<NonFriendlyBorrow> {
  final ItemRepository _repo = ItemRepository();
  StreamSubscription<QuerySnapshot<BorrowOrder>>? _borrowsSubscription;
  DialogOptions borrowRequestStatus = DialogOptions.ignore;
  final List<BorrowOrder> _borrows = List.empty(growable: true);

  void onBorrowsUpdated() {
    setState(() {});
  }

  @override
  void didChangeDependencies() {
    _borrowsSubscription ??= _repo.remote.listenForBorrows(context, _borrows, onBorrowsUpdated);
    if(_borrowsSubscription!.isPaused) {
      _borrowsSubscription!.resume();
    }
    // onBorrowRequestOption(borrowRequestStatus, id)
    super.didChangeDependencies();
  }

  @override
  void dispose() {
      _borrowsSubscription?.cancel();
    super.dispose();
  }
  void setBorrowOption(DialogOptions option) {
    borrowRequestStatus = option;
    setState(() {});
  }
  Future<void> onBorrowRequestOption(DialogOptions option, String? id, ItemStatus status) async {
    if(id == null || id.isEmpty) {
      return;
    }
    var responseStatus = ItemStatus.home;
    switch(status) {
      case ItemStatus.pendingBorrow: responseStatus = ItemStatus.borrowed; break;
      case ItemStatus.pendingReturn: responseStatus = ItemStatus.home; break;
      default: break;
    }
    switch(option) {
      case DialogOptions.accept: {
        _repo.acceptBorrowOrder(context, id,responseStatus);
        break;
      }
      case DialogOptions.reject: {
        _repo.removeBorrowOrder(context, id);
        break;
      }
      default: break;

    }
  }
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: _borrows.length,
      itemBuilder: (context, index) {
        final BorrowOrder borrow = _borrows[index];
        print("Got a b? ${borrow.id}");
        return BorrowRequest(onChooseOption: (DialogOptions option) => onBorrowRequestOption(option, borrow.id, borrow.status), borrowOrder: borrow);
        
      }
    
    );

  }
}