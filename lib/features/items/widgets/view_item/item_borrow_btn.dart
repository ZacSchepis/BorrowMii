import 'package:borrow_mii/widgets/skeletons/item.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class ItemBorrowBtn extends ItemEntityViewModel {
  final VoidCallback onPressed;
  const ItemBorrowBtn({super.key, required super.item, required this.onPressed});
  
  @override
  State<ItemBorrowBtn> createState() => _ItemBorrowBtnWidgetState();

}
class _ItemBorrowBtnWidgetState extends State<ItemBorrowBtn> {

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: widget.onPressed,
      child: const Text("Borrow item")
    );
  }
}