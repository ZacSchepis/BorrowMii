import 'package:team_d_project/item.dart';

class ModelViewController {
  static final ModelViewController _instance = ModelViewController._internal();
  //create instance
  factory ModelViewController() {
    return _instance;
  }

 //constructor
  ModelViewController._internal() {
    // initialization logic
    //print("test mvc");
  }

  // rest of class as normal, for example:
  void openFile() {}
  void writeFile() {}
  //returns all items owned by user
  List<Item> searchMyItems(String search){
    //search current list of persons items
    List<Item> L1;
    L1=[Item("1","1","1")];
    return  L1;
  }
  List<Item> getMyItems(){
    //return list of persons items
    List<Item> L1;
    L1=[Item("1","1","1")];
    return  L1;
  }
  List<Item> getBorrowedItems(){
    //return list of items currently borrowed
    List<Item> L1;
    L1=[Item("1","1","1")];
    return  L1;
  }
  List<Item> searchOtherItems(){
    //return list of searched items other people own
    List<Item> L1;
    L1=[Item("1","1","1")];
    return  L1;
  }
}