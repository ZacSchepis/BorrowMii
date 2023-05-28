import 'package:team_d_project/item.dart';
import 'package:team_d_project/databaseController.dart';
import 'current_user.dart';

// Takes UI input and talks to database Controller for data
class ModelViewController {
  static final ModelViewController _instance = ModelViewController._internal();

  //create instance
  factory ModelViewController() {
    return _instance;
  }

  //constructor
  ModelViewController._internal() {
    // initialization logic
  }
  CurrentUser cu = CurrentUser();

  // Adds an item from a name
  void addItemFromName(String name) {
    Item newItem = Item(name, cu.getCurrentUname(), "Available");
    addItemToDatabase(newItem);
  }

  // Deletes an item from a name
  void deleteItemFromName(String name) {
    removeItemByStringFromDatabase(name);
  }

  // borrows an item
  void borrowItem(Item item) {
    borrowItemDatabase(item);
  }

  // returns an item
  void returnItem(Item item) {
    returnItemDatabase(item);
  }

  // delete an owned item
  void deleteItem(Item item) {
    removeItemFromDatabase(item);
  }

  // add a friend by their username
  void addFriendByName(String frienduname) {
    addFriend(frienduname);
  }

  // change current user's name
  void changeCName(String name) async {
    changeName(name);
  }

  // change current user's username
  void changeCUserName(String newuName) async {
    changeUserName(newuName);
  }

  // change current user's password
  void updateCPassword(String newpassword) async {
    updatePassword(newpassword);
  }

  // Get all current user's items as a List of Items
  Future<List<Item>> getMyItems() async {
    List<dynamic> itemsMaps = await getUserInventory();
    List<Item> items = [];
    for (var itemMap in itemsMaps) {
      Map<String, dynamic> map = itemMap;
      items.add(getItemFromMap(map));
    }
    return items;
  }

  // Get all current user's borrowed items as a List of Items
  Future<List<Item>> getBorrowedItems() async {
    //return list of items currently borrowed
    List<dynamic> borroweditemsmaps = await getBorrowedInventory();
    List<Item> borrowedItems = [];
    for (var bItemMap in borroweditemsmaps) {
      Map<String, dynamic> map = bItemMap;
      borrowedItems.add(getItemFromMap(map));
    }
    return borrowedItems;
  }

  // Get all current user's friends' items as a List of Items
  //Note that we probably don't have to explicitly define map and set it to fMap, but the type hinting is more readable here.
  Future<List<Item>> searchOtherItems() async {
    //return list of searched items other people own
    List<dynamic> friendsitemsmaps = await getFriendsItemsInDatabase();
    List<Item> friendsItems = [];
    for (var fMap in friendsitemsmaps) {
      Map<String, dynamic> map = fMap;
      friendsItems.add(getItemFromMap(map)); //HELLO
    }
    return friendsItems;
  }
}
