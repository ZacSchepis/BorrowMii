import 'dart:async';

import 'package:borrow_mii/widgets/loading_modal.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:borrow_mii/data/models/item_model.dart';
import 'package:borrow_mii/data/repositories/item_repository.dart';
import 'package:borrow_mii/modelViewController.dart';

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
  void onItemsUpdate() {setState(() {});}
  @override
  void initState() {
    getItems();
    super.initState();
  }


  Widget? buildInteractable() {

  }
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot<ItemModel>>(stream: repo.remote.listenForItems(context, items, onItemsUpdate), builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
      if(snapshot.hasError) {
        return const Text("Something went wrong");
      }
      if (snapshot.connectionState == ConnectionState.waiting) {
        return LoadingModal(loaded: false);
      }
      return ListView(
        children: snapshot.data!.docs
                    .map(( doc) {
                      final ItemModel item = doc.data() as ItemModel;
                      // DocumentSnapshot<Map<String, dynamic>> d = doc as  DocumentSnapshot<Map<String, dynamic>>;
                      // ItemModel dat2 = ItemModel.fromFirestore(doc, null, "");
                      return ListTile(title: item.build(context));
                    }).toList()
        ,
      );
    }
    );
    // return ;
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