import 'package:borrow_mii/data/models/item_model.dart';
import 'package:flutter/material.dart';

class ItemLoanHistory extends StatefulWidget {
  final ItemModel item;
  const ItemLoanHistory({
    super.key,
    required this.item
  });

  @override
  State<ItemLoanHistory> createState() => _ItemLoanHistoryWidgetState();
}

class _ItemLoanHistoryWidgetState extends State<ItemLoanHistory> {

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    throw UnimplementedError();
  }
}