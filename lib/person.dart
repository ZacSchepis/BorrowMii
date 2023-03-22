import 'item.dart';
class Person {
  String _name = "";
  List<Item> myItems = <Item>[];
  List<Item> borrowedItems = <Item>[];

  Person(String name){
    _name = name;
  }

  void addItem(Item item){
    myItems.add(item);
  }
  void removeItem(Item item){
    int index = myItems.indexOf(item);
    myItems.remove(index);
  }
  void borrowItem(Item item){
    borrowedItems.add(item);
  }
  void returnItem(Item item){
    int index = myItems.indexOf(item);
    borrowedItems.remove(index);
  }
}