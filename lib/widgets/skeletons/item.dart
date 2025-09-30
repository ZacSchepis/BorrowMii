import 'package:borrow_mii/data/models/item_model.dart';
import 'package:flutter/material.dart';

abstract class ItemEntityViewModel extends StatefulWidget {
  final ItemModel item;
  const ItemEntityViewModel({
    Key? key,
    required this.item
  }) : super(key: key);
}
