import 'package:borrow_mii/core/styles/styles.dart';
import 'package:borrow_mii/data/models/item_model.dart';
import 'package:flutter/material.dart';

class ItemInfo extends StatelessWidget {
  final ItemModel item;
  const ItemInfo({
    super.key,
    required this.item
  });

  @override
  Widget build(BuildContext context) {

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(item.itemName, style:  AppText.title,),
        Text("Owner: ${item.owner}", style: AppText.body,),
        Text("Status: ${item.status}", style: AppText.subtitle,),
        Text(item.itemDesc, style: AppText.subtitle,)
      ],
    );
  }

}