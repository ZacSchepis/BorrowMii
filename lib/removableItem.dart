import 'package:flutter/material.dart';
import 'item.dart';
import 'modelViewController.dart';


class RemovableItem extends StatelessWidget{
  Item _item = Item("1","1","1");
  ModelViewController mvc = ModelViewController();
  RemovableItem(Item item, {super.key}){
  _item = item;
  }
  void _deleteItem(Item item){
    mvc.deleteItem(item);
  }
  @override
  Widget build(BuildContext context){
    return Row(
      children: [
        _item.build(context),
        ElevatedButton.icon(
            onPressed:(){
              _deleteItem(_item);
              //delete item from person class
              //create modelviewcontroller method to delete passing item
              //create method to delete item in person call passing method
            },
            icon: const Icon(
              Icons.clear,
              color: Colors.red,
              size: 40.0,
            ),
            label: const Text("remove")
        )
      ],
    );
  }
}

