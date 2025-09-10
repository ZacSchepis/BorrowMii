import 'package:borrow_mii/features/items/widgets/view_item/item_borrow_btn.dart';
import 'package:borrow_mii/features/items/widgets/view_item/item_image.dart';
import 'package:borrow_mii/features/items/widgets/view_item/item_info.dart';
import 'package:borrow_mii/features/items/widgets/view_item/item_terms.dart';
import 'package:borrow_mii/widgets/button.dart';
import 'package:borrow_mii/widgets/skeletons/item.dart';
import 'package:flutter/material.dart';

class ItemStandardView extends ItemEntityViewModel{
  final VoidCallback onPressed;
  const ItemStandardView({super.key, required super.item, required this.onPressed});

  @override
  State<ItemStandardView> createState() => _ItemStandardViewWidgetState();
}

class _ItemStandardViewWidgetState extends State<ItemStandardView> {
  @override
  Widget build(BuildContext context) {
    return
       Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ItemImage(itemId: widget.item.ownerId),
          ItemInfo(item: widget.item),
          ItemTerms(item: widget.item),
          const Spacer(),
          Align(
              child: Button(text: "Borrow", onPressed: widget.onPressed),
              alignment: Alignment.bottomRight,
            )
          
          // ItemBorrowBtn(item: widget.item,onPressed: widget.onPressed, ),
        ],
      ),
    );

    
  }
}