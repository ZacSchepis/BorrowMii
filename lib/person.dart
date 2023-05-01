import 'item.dart';

class Person {
  String _username = "";
  String _name = "";
  String _password = "";
  String _dob = "";
  List<dynamic> _myItems = <dynamic>[];
  List<dynamic> _borrowedItems = <dynamic>[];
  List<Item> requestedItems = <Item>[];
  List<dynamic> _friends = <dynamic>[];
  bool has_items = false;
  bool has_Bitems = false;

  Person(String username, String password) {
    _username = username;
    _password = password;
  }

  // Getters
  String get name => _name;
  String get password => _password;
  String get uname => _username;
  String get dob => _dob;
  List<dynamic> get myItems => _myItems;
  List<dynamic> get bItems => _borrowedItems;
  List<dynamic> get friends => _friends;

  // Setters
  void setUserName(String uname) {
    _username = uname;
  }

  void setPassword(String password) {
    _password = password;
  }

  void setItems(List<dynamic> items) {
    _myItems = items;
  }

  void setborrowedItems(List<dynamic> borroweditems) {
    _borrowedItems = borroweditems;
  }

  void setFriendList(List<dynamic> friends) {
    _friends = friends;
  }

  void setName(String name) {
    _name = name;
  }

  // Converts person to a map to be saved in database.
  Map<String, dynamic> toFirestore() {
    return {
      if (_name != null) "name": _name,
      if (uname != null) "userName": _username,
      if (_password != null) "password": _password,
      if (_dob != null) "dob": _dob,
      if (_myItems != null) "myItems": myItems,
      if (_borrowedItems != null) "borrowedItems": bItems,
      if (_friends != null) "friends": friends,
    };
  }

  Map<String, dynamic> friendToFirestore() {
    return {
      if (_name != null) "name": _name,
      if (uname != null) "userName": _username,
    };
  }

  // Adds an item to current users items
  void addItem(Item item) {
    item.setStatus("Available");
    myItems.add(item.toFirestore());
  }

  // Removes items where an item name is equal to an item name in the current users items
  void removeItem(Item item) {
    myItems.removeWhere((element) => element["itemName"] == item.itemname);
  }

  // Removes item by its item name
  void removeItemFromName(String n) {
    myItems.removeWhere((element) => element["itemName"] == n);
  }

  // borrows item from user and adds to current users borrowed items
  void borrowAItem(Item item) {
    if (item.getStatus() == "Available") {
      item.setStatus("Borrowed");
      bItems.add(item.toFirestore());
    }
  }

  // return a borrowed item from borrowed items list by item name
  void returnItem(Item item) {
    item.setStatus("Available");
    bItems.removeWhere((element) => element["itemName"] == item.itemname);
  }

  // add friend to friends list of current user then added to firebase
  void addFriend(Person friend) {
    friends.add(friend.friendToFirestore());
  }

  // add friend by friends username to friends list of current user
  void addFriendByString(String friendUName) {
    if (!friends.contains(friendUName)) {
      friends.add(friendUName);
    }
  }

  // remove friend from friends by friends username
  void removeFriend(Person friend) {
    friends.removeWhere((element) => element["userName"] == friend.uname);
  }

  // remove friend by the friends username
  void removeFriendByString(String frienduName) {
    friends.removeWhere((element) => element == frienduName);
  }
}
