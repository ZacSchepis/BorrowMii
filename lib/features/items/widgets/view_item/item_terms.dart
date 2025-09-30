import 'package:borrow_mii/core/styles/styles.dart';
import 'package:borrow_mii/data/models/item_model.dart';
import 'package:flutter/material.dart';

class ItemTerms extends StatelessWidget {
  final ItemModel item;
  const ItemTerms({
    super.key,
    required this.item
  });
  List<String> get bullets {
    List<String> b = [];
    final dailyFees = item.dailyFeeEnabled;
    final flatFees = item.flatFeeEnabled;
    if(dailyFees != null && dailyFees) {
      b.add("After ${item.lateFeeDays} days, a fee of \$${item.lateFeeCost}");
    }
    if(flatFees != null && flatFees) {
      b.add("Lump sum if item is late more than ${item.flatFeeMonths} month(s), of amount \$${item.flatFeeCost}");
    }
    return b;
  } 
  @override
  Widget build(BuildContext context) {
    return bullets.isNotEmpty
          ? Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text("Default loan terms:"),
              ...bullets.map((v) => Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text("• ", style: AppText.subtitle),
                  Expanded(child: Text(v))
                ],
              ))
            ],
          )
          : const SizedBox.shrink();
  }
}