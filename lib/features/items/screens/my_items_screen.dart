import 'package:flutter/material.dart';
import 'package:team_d_project/data/models/item_model.dart';
import 'package:team_d_project/data/repositories/item_repository.dart';
import 'package:team_d_project/modelViewController.dart';

class MyItemsScreenWidget extends StatefulWidget {
  const MyItemsScreenWidget({super.key});
  @override
  _MyItemsWidgetState createState() => _MyItemsWidgetState();
}

abstract class _DisplayListWidget extends StatefulWidget {
  const _DisplayListWidget({super.key});
}
// abstract class _DisplayListWidgetState extends State<_DisplayListWidget> {

// }
// abstract class _ItemsListWidgetState

abstract class _ItemsListWidgetState<T extends StatefulWidget> extends State<T> {
  List<ItemModel> items = [];
  ItemRepository repo = ItemRepository();
  // ModelViewController mvc = ModelViewController();
  void getItems() async {
    setState(() {} );
  }

  @override
  void initState() {
    getItems();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: items.length,
      itemBuilder: (BuildContext ctx, int idx) {
        return ListTile(
          title: items[idx].build(ctx),
        );
      },

    );
  }
}

class _MyItemsWidgetState extends _ItemsListWidgetState<MyItemsScreenWidget> {
  @override
  void getItems() async {
    final itms = await repo.getMyItems(context);
    setState(() {
      items = itms;
    });
  }

}