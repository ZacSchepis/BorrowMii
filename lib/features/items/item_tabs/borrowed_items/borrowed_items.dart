import 'package:borrow_mii/core/controllers/choose_controller.dart';
import 'package:borrow_mii/data/datasources/items/my_borrows_state.dart';
import 'package:borrow_mii/data/models/item_model.dart';
import 'package:borrow_mii/data/repositories/item_repository.dart';
import 'package:borrow_mii/widgets/collapsible_group_list.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class BorrowedItems extends StatefulWidget {
  const BorrowedItems({super.key});

    @override
    State<BorrowedItems> createState() => _BorrowedItemsWidgetState();
}


class _BorrowedItemsWidgetState extends State<BorrowedItems> {
  final ItemRepository repo = ItemRepository();
  final SimpleChooser chooser = SimpleChooser<ItemModel>(getLabel: (item) => item.borrowerId);

  void getBorrows() {
    MyBorrowsState myBorrows = Provider.of<MyBorrowsState>(context, listen: true);
    chooser.setItems(myBorrows.items);
    // List<ItemModel> items = List.generate(12, ItemModel.generate);
    // chooser.setItems(items);
  }

  @override
  void didChangeDependencies() {
    getBorrows();
    super.didChangeDependencies();
  }

  // @override
  // void initState() {
  //   super.initState();
  //   getBorrows();
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Borrowed Items"),
        leading: BackButton(
          onPressed: () => Navigator.pop(context),
        ),
        // actions: [

        // ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Expanded(
                child: CollapsibleGroupList(
                    getGroupKey: (ItemModel item) => item.borrowerId,
                    getLabel: (ItemModel item) => item.borrowerId,
                    buildTile: (ItemModel item, context) => item.build(context),
                    chooser: chooser))
          ],
        ),
      ),
    );
  }
}