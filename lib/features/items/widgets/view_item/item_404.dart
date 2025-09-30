import 'package:borrow_mii/core/styles/styles.dart';
import 'package:flutter/material.dart';

class Item404 extends StatelessWidget {
  final String itemId;
  const Item404({
    super.key,
    required this.itemId
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Text("Item could not be found", style: AppText.title,),
        Text("Item ref: $itemId", style: AppText.body),
      ],
    );
  }

}