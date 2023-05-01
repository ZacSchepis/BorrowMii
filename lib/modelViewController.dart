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
    List<dynamic> itemmaps = await getUserInventory();
    List<Item> items = [];
    for (int i = 0; i < itemmaps.length; i++) {
      Map<String, dynamic> map = itemmaps[i];
      items.add(getItemFromMap(map));
    }
    return items;
  }

  // Get all current user's borrowed items as a List of Items
  Future<List<Item>> getBorrowedItems() async {
    //return list of items currently borrowed
    List<dynamic> borroweditemsmaps = await getBorrowedInventory();
    List<Item> borrowedItems = [];
    for (int i = 0; i < borroweditemsmaps.length; i++) {
      Map<String, dynamic> map = borroweditemsmaps[i];
      borrowedItems.add(getItemFromMap(map));
    }
    return borrowedItems;
  }

  // Get all current user's friends' items as a List of Items
  Future<List<Item>> searchOtherItems() async {
    //return list of searched items other people own
    List<dynamic> friendsitemsmaps = await getFriendsItemsInDatabase();
    List<Item> friendsItems = [];
    for (int i = 0; i < friendsitemsmaps.length; i++) {
      Map<String, dynamic> map = friendsitemsmaps[i];
      friendsItems.add(getItemFromMap(map));
    }
    return friendsItems;
  }
}
