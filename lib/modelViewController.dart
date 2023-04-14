import 'package:team_d_project/item.dart';
import 'package:team_d_project/databaseController.dart';

class ModelViewController {
  static final ModelViewController _instance = ModelViewController._internal();
  //create instance
  factory ModelViewController() {
    return _instance;
  }

  //constructor
  ModelViewController._internal() {
    // initialization logic
    print("test mvc");
  }

  // rest of class as normal, for example:
  void openFile() {}
  void writeFile() {}
  //returns all items owned by user
  List<Item> searchMyItems(String search) {
    //replace with function in person class
    List<Item> L1;
    L1 = [Item("1", "1", "1")];
    return L1;
  }
}
