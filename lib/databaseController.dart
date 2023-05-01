// import 'dart:/ffi';
import 'dart:io';
import 'package:team_d_project/current_user.dart';
import 'package:team_d_project/person.dart';
import 'package:team_d_project/item.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

String username = "";
List<dynamic> userItems = <Item>[];
List<dynamic> borrowedItems = <Item>[];
List<dynamic> friendList = <dynamic>[];
List<dynamic> allItems = <dynamic>[];
CurrentUser cuser = CurrentUser();
FirebaseFirestore reference = FirebaseFirestore.instance;

// Creates an Item object from a map (from the database)
Item getItemFromMap(Map<String, dynamic> itemMap) {
  return Item(itemMap["itemName"] as String, itemMap["owner"] as String,
      itemMap["status"] as String);
}

// Creates a Person from a map (from the database)
Person getPersonFromMap(Map<String, dynamic> personmap) {
  return Person(personmap["userName"], personmap["password"]);
}

// Gets all the items of the current user from the database
Future<List<dynamic>> getUserInventory() async {
  await FirebaseFirestore.instance
      .collection("users")
      .doc(cuser.uname)
      .get()
      .then((DocumentSnapshot documentSnapshot) {
    if (documentSnapshot.exists) {
      List<dynamic> items = documentSnapshot.get("myItems");
      cuser.setItems(items);
      userItems = items;
    }
  });
  return userItems;
}

// Gets all the borrowed items of the current user from the database
Future<List<dynamic>> getBorrowedInventory() async {
  await FirebaseFirestore.instance
      .collection("users")
      .doc(cuser.uname)
      .get()
      .then((DocumentSnapshot documentSnapshot) {
    if (documentSnapshot.exists) {
      List<dynamic> items = documentSnapshot.get("borrowedItems");
      cuser.setborrowedItems(items);
      borrowedItems = items;
    }
  });
  return borrowedItems;
}

// Gets all the user names in the database
Future<List<dynamic>> getAllUserNames() async {
  List<dynamic> allUsers = [];

  QuerySnapshot querySnapshot =
      await FirebaseFirestore.instance.collection("users").get();

  for (var doc in querySnapshot.docs) {
    if (doc.id != "ADMIN" && doc.id != "admin") {
      allUsers.add(doc.id);
    }
  }

  return allUsers;
}

// Gets all items within the database
Future<List<dynamic>> getAllItemsInDatabase() async {
  QuerySnapshot querySnapshot =
      await FirebaseFirestore.instance.collection("users").get();

  // Get data from docs and convert map to List
  List<dynamic> allData = querySnapshot.docs.map((doc) => doc.data()).toList();

  for (int idx = 0; idx < allData.length; idx++) {
    Map<String, dynamic> map = allData[idx];
    if (map["myItems"].length != 0) {
      for (int j = 0; j < map["myItems"].length; j++) {
        allItems.add(map["myItems"][j]);
      }
    }
  }
  return allItems;
}

// get all the items owned by the current user within the database
Future<List<dynamic>> getFriendsItemsInDatabase() async {
  QuerySnapshot querySnapshot =
      await FirebaseFirestore.instance.collection("users").get();

  // Get data from docs and convert map to List
  List<dynamic> allData = querySnapshot.docs.map((doc) => doc.data()).toList();

  List<dynamic> friends = [];
  List<dynamic> friendsItems = [];

  for (int idx = 0; idx < allData.length; idx++) {
    Map<String, dynamic> map = allData[idx];
    if (map["userName"] == cuser.uname) {
      for (int j = 0; j < map["friends"].length; j++) {
        friends.add(map["friends"][j]);
      }
    }
  }

  for (int idx = 0; idx < allData.length; idx++) {
    Map<String, dynamic> map = allData[idx];
    if (map["myItems"].length != 0 && friends.contains(map["userName"])) {
      for (int j = 0; j < map["myItems"].length; j++) {
        friendsItems.add(map["myItems"][j]);
      }
    }
  }
  return friendsItems;
}

// Gets all the friends usernames of the current user
Future<List<dynamic>> getFriends() async {
  await FirebaseFirestore.instance
      .collection("users")
      .doc(cuser.uname)
      .get()
      .then((DocumentSnapshot documentSnapshot) {
    if (documentSnapshot.exists) {
      List<dynamic> friends = documentSnapshot.get("friends");
      cuser.setFriendList(friends);
      friendList = friends;
    }
  });
  return friendList;
}

// calls all getter function to instantiate local variables --- avoided overwriting
Future getAllInventory() async {
  await getBorrowedInventory();
  await getUserInventory();
  await getFriends();
}

// add item function to the database
void addItemToDatabase(Item item) async {
  await getAllInventory();
  cuser.addItem(item);
  reference.collection("users").doc(cuser.uname).set(cuser.toFirestore());
}

// remove item function from the database
void removeItemFromDatabase(Item item) async {
  await getAllInventory();
  cuser.removeItem(item);
  reference.collection("users").doc(cuser.uname).set(cuser.toFirestore());
}

// remove the item by the item name from the database
void removeItemByStringFromDatabase(String itemName) async {
  await getAllInventory();
  cuser.removeItemFromName(itemName);
  reference.collection("users").doc(cuser.uname).set(cuser.toFirestore());
}

// borrow an item, updates database
void borrowItemDatabase(Item item) async {
  await getAllInventory();
  String itemOwner = item.getOwner();
  if (friendList.contains(itemOwner)) {
    cuser.borrowAItem(item);
  }
  reference.collection("users").doc(cuser.uname).set(cuser.toFirestore());

  editFriendsDatabase(item, "Borrowed");
}

void editFriendsDatabase(Item item, String status) async {
  String itemOwner = item.getOwner();
  List<dynamic> friendsItems = [];
  await FirebaseFirestore.instance
      .collection("users")
      .doc(itemOwner)
      .get()
      .then((DocumentSnapshot documentSnapshot) {
    if (documentSnapshot.exists) {
      friendsItems = documentSnapshot.get("myItems");
      for (var itemMap in friendsItems) {
        if (itemMap["itemName"] == item.itemname) {
          itemMap["status"] = status;
        }
      }
    } else {
      print("Friend not found in Database");
    }
  });
  reference
      .collection("users")
      .doc(item.getOwner())
      .update({"myItems": friendsItems});
}

// returns item, updates database
void returnItemDatabase(Item item) async {
  await getAllInventory();
  cuser.returnItem(item);
  reference.collection("users").doc(cuser.uname).set(cuser.toFirestore());

  editFriendsDatabase(item, "Available");
}

void addFriend(String friendUName) async {
  await getAllInventory();
  await FirebaseFirestore.instance
      .collection("users")
      .doc(friendUName)
      .get()
      .then((DocumentSnapshot documentSnapshot) {
    if (documentSnapshot.exists) {
      cuser.addFriendByString(friendUName);
      reference.collection("users").doc(cuser.uname).set(cuser.toFirestore());
    } else {
      print("Friend not found in Database");
    }
  });
}

// remove a friend of the current user within the database
void removeFriend(Person friend) async {
  await getAllInventory();
  cuser.removeFriend(friend);
  reference.collection("users").doc(cuser.uname).set(cuser.toFirestore());
}

// current user can change their name
void changeName(String name) async {
  cuser.setName(name);
  reference.collection("users").doc(cuser.uname).set(cuser.toFirestore());
}

// current user can change their username
void changeUserName(String newuName) async {
  reference.collection("users").doc(cuser.uname).delete();
  cuser.setUserName(newuName);
  cuser.setCUName(newuName);
  reference.collection("users").doc(cuser.uname).set(cuser.toFirestore());
}

// current user can change their password
void updatePassword(String newpassword) async {
  cuser.setPassword(newpassword);
  cuser.setCUPassword(newpassword);
  reference.collection("users").doc(cuser.uname).set(cuser.toFirestore());
}
