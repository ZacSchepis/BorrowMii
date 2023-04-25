import 'package:flutter/material.dart';
import 'item.dart';
import 'modelViewController.dart';


abstract class InteractableItem extends StatelessWidget{
  Item _item = Item("1","1","1");
  Icon _icon = const Icon(
    Icons.clear,
    color: Colors.red,
    size: 40.0,
  );
  Widget _text = Text("Remove");
  ModelViewController mvc = ModelViewController();
  InteractableItem(Item item,{super.key}){
  _item = item;
  }
  void setIcon(Icon icon){
    _icon = icon;
  }
  void setText(String text){
    _text = Text(text);
  }
  //override functionality
  void _interact(Item item){
    mvc.deleteItem(item);
  }
  @override
  Widget build(BuildContext context){
    return Row(
      children: [
        _item.build(context),
        ElevatedButton.icon(
            onPressed:(){
              _interact(_item);
            },
            icon: _icon,
            label: _text,
        )
      ],
    );
  }
}

