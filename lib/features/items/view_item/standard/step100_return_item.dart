import 'package:borrow_mii/core/constants/item_status.dart';
import 'package:borrow_mii/core/errors/item_errors.dart';
import 'package:borrow_mii/data/models/borrow_order.dart';
import 'package:borrow_mii/data/repositories/item_repository.dart';
import 'package:borrow_mii/widgets/loading_modal.dart';
import 'package:flutter/material.dart';

class Step100ReturnItem extends StatefulWidget {
  final String itemId;
  const Step100ReturnItem({super.key, required this.itemId});

  @override
  State<Step100ReturnItem> createState() => _Step100ReturnItemWidgetState();
}

class _Step100ReturnItemWidgetState extends State<Step100ReturnItem> {
  // Future<BorrowOrder?>? _futureBorrow;
  final ItemRepository _repo = ItemRepository();
  @override
  void initState() {
    super.initState();
    // _futureBorrow = _repo.getBorrowOrderFromContext(context, widget.itemId);
  }

  @override
  Widget build(BuildContext context) {
    print("In part 2:D");
    return FutureBuilder(
        future: () async {
          final data = await _repo.getBorrowOrderFromContext(context, widget.itemId);
          if(data == null) return null;
          print(data.name);
          data.status = ItemStatus.pendingReturn;
          final r = await _repo.addBorrowOrder(context, data);
          print(r);
          return r;
        }(),
        builder: (context, AsyncSnapshot<String?> snapshot) {
          if(snapshot.connectionState == ConnectionState.waiting) {
            return LoadingModal(loaded: false);
          }
          if(snapshot.hasError) {
            final error = snapshot.error;
            if(error is ItemException) {

            } else {
              return Center(child: Text("Something went wrong: ${error.toString()}"),);
            }
          }
          if(snapshot.hasData) {
            return LoadingModal(loaded: true, title: "Returning item...", subtitle: "Please wait a moment",);
          }
          return LoadingModal(loaded: false, title: "We dont know what happened",);
        });
  }
}
