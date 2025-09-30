import 'package:borrow_mii/core/styles/styles.dart';
import 'package:borrow_mii/data/models/item_model.dart';
import 'package:flutter/material.dart';

class ItemInfo extends StatelessWidget {
  final ItemModel item;
  final CrossAxisAlignment crossAxisAlignment;
  const ItemInfo({
    super.key,
    required this.item,
    this.crossAxisAlignment = CrossAxisAlignment.start
  });

  @override
  Widget build(BuildContext context) {

    return Column(
      crossAxisAlignment: crossAxisAlignment,
      children: [
        Text(item.name ?? "", style:  AppText.title,),
        Text("Owner: ${item.owner}", style: AppText.body,),
        Text("Status: ${item.status}", style: AppText.subtitle,),
        Text(item.description ?? "", style: AppText.subtitle,)
      ],
    );
  }

}