import 'package:borrow_mii/features/borrow_requests/screens/borrow_screen.dart';
import 'package:borrow_mii/features/items/item_tabs/borrowed_items/borrowed_items.dart';
import 'package:borrow_mii/features/items/item_tabs/inventory/my_inventory.dart';
import 'package:borrow_mii/features/items/item_tabs/loaned_items/my_loaned_items.dart';
import 'package:flutter/material.dart';

class ItemTabsSelectorScreen extends StatelessWidget {
  const ItemTabsSelectorScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        ListTile(
            leading: const Icon(Icons.inventory),
            title: const Text("My Items"),
            onTap: () => Navigator.push(
                context, MaterialPageRoute(builder: (_) => MyInventory()))),
        ListTile(
            leading: const Icon(Icons.handyman),
            title: const Text("Borrowed Items"),
            onTap: () => Navigator.push(
                context, MaterialPageRoute(builder: (_) => BorrowedItems()))),
        ListTile(
            leading: const Icon(Icons.people),
            title: const Text("Loaned Items"),
            onTap: () => Navigator.push(
                context, MaterialPageRoute(builder: (_) => MyLoanedItems()))),
          ListTile(
            leading: const Icon(Icons.pending_actions),
            title: const Text("Pending Requests"),
            onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => BorrowScreen())),
          )
      ],
    );
  }
}
