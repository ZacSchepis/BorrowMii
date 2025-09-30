import 'package:borrow_mii/core/errors/item_errors.dart';
import 'package:borrow_mii/data/models/item_model.dart';
import 'package:borrow_mii/data/models/load_state_model.dart';
import 'package:borrow_mii/data/repositories/item_repository.dart';
import 'package:borrow_mii/features/home/screens/home.dart';
import 'package:borrow_mii/features/items/create_item/create_item_flow.dart';
import 'package:borrow_mii/features/items/view_item/owner/item_owner_view.dart';
import 'package:borrow_mii/features/items/view_item/standard/item_standard.dart';
import 'package:borrow_mii/features/items/view_item/standard/item_standard_view.dart';
import 'package:borrow_mii/features/items/widgets/view_item/item_404.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class ItemViewWidget extends StatefulWidget {
  final String itemId;
  const ItemViewWidget({
    super.key,
    required this.itemId
  });

  @override
  State<ItemViewWidget> createState() => _ItemViewWidgetState();
}

class _ItemViewWidgetState extends State<ItemViewWidget> {
  final ItemRepository _repo = ItemRepository();
  Future<ItemModel?>? _futuristicItem;
  @override
  void initState() {
    super.initState();
    _futuristicItem = _repo.getItemById(widget.itemId, context);
  }

  Future<ItemModel?> getItem(String id) async {
    
    // final item = await _repo.getItemById(id);
    // return item;
  }
  void goHome() {
    Navigator.push(context, MaterialPageRoute(builder: (ctx) => Home()));
    
    }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(future: _futuristicItem, builder: (context, AsyncSnapshot<ItemModel?> snapshot) {
      if(snapshot.connectionState == ConnectionState.waiting) {
        return const Center(child: CircularProgressIndicator());
      }
      if(snapshot.hasError) {
        final error = snapshot.error;
        if( error is ItemException) {
          return Item404(itemId: widget.itemId);
        } else {
          return Center(child: Text("Something went wrong: ${error.toString()}"),);
        }
      }
      if(snapshot.data == null) {
        return CreateItemFlow(id: widget.itemId,);
      }
      if(snapshot.hasData) {
        return _repo.getIsMyItem(context, snapshot.data!.ownerId) 
                  ? ItemOwnerView(item: snapshot.data!, goHome: goHome)
                  : ItemStandard(item: snapshot.data!, goHome: goHome)
                  ;

      }
      else {
        return Text("We don't know what happened 5123");
      }
    }) ; 
  }
}