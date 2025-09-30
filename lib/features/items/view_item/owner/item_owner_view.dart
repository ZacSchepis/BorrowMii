import 'package:borrow_mii/data/models/item_model.dart';
import 'package:borrow_mii/features/items/widgets/view_item/item_image.dart';
import 'package:borrow_mii/features/items/widgets/view_item/item_info.dart';
import 'package:borrow_mii/features/items/widgets/view_item/item_terms.dart';
import 'package:borrow_mii/widgets/skeletons/item.dart';
import 'package:flutter/material.dart';

class ItemOwnerView extends ItemEntityViewModel {
  final VoidCallback goHome;

  const ItemOwnerView({
    super.key,
    required super.item ,
    required this.goHome
  });

  @override
  State<StatefulWidget> createState() => _ItemOwnerViewWidgetState();
}

class _ItemOwnerViewWidgetState extends State<ItemOwnerView> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(widget.item.name ?? ""), leading: BackButton(onPressed: () => widget.goHome(),),),
      body: Align(
        alignment: Alignment.topLeft,
        child: Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ItemImage(itemId: widget.item.image ?? ""),
          ItemInfo(item: widget.item),
          ItemTerms(item: widget.item),
          // Button(text: "Borrow", onPressed: widget.onPressed)
          // ItemBorrowBtn(item: widget.item,onPressed: widget.onPressed, ),
        ],
      ),
    ),
      )
    );
       

    
  }
}