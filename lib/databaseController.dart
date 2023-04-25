// import 'dart:/ffi';
import 'dart:io';
import 'package:team_d_project/current_user.dart';
import 'package:team_d_project/person.dart';
import 'package:team_d_project/item.dart';
import 'package:team_d_project/Notifiers/item_notifier.dart';
import 'package:team_d_project/Notifiers/user_notifier.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

String username = "";
List<dynamic> userItems = <Item>[];
List<dynamic> borrowedItems = <Item>[];
List<dynamic> friendList = <dynamic>[];
List<dynamic> allItems = <dynamic>[];
// List<dynamic> friendsItems = <dynamic>[];
CurrentUser cuser = CurrentUser();
FirebaseFirestore reference = FirebaseFirestore.instance;

Item getItemFromMap(Map<String, dynamic> itemMap) {
  // String name = itemMap['itemName'] as String;
  // itemMap['owner'];
  // itemMap['status'];
  return Item(itemMap["itemName"] as String, itemMap["owner"] as String,
      itemMap["status"] as String);
}

Person getPersonFromMap(Map<String, dynamic> personmap) {
  return Person(personmap["userName"], personmap["password"]);
}

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

Future<List<dynamic>> getAllUserNames() async {
  List<dynamic> allUsers = [];

  QuerySnapshot querySnapshot =
      await FirebaseFirestore.instance.collection("users").get();

  for (var doc in querySnapshot.docs) {
    if (doc.id != "ADMIN" && doc.id != "admin") {
      allUsers.add(doc.id);
    }
  }

  print(allUsers);
  // await FirebaseFirestore.instance.collection("users").get().then((query) => null)

  return allUsers;
}

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

Future getAllInventory() async {
  await getBorrowedInventory();
  await getUserInventory();
  await getFriends();
}

// add item function
void addItemToDatabase(Item item) async {
  await getAllInventory();
  cuser.addItem(item);
  reference.collection("users").doc(cuser.uname).set(cuser.toFirestore());
}

//remove item function
void removeItemFromDatabase(Item item) async {
  await getAllInventory();
  cuser.removeItem(item);
  reference.collection("users").doc(cuser.uname).set(cuser.toFirestore());
}

void removeItemByStringFromDatabase(String itemName) async {
  await getAllInventory();
  cuser.removeItemFromName(itemName);
  reference.collection("users").doc(cuser.uname).set(cuser.toFirestore());
}

void borrowItemDatabase(Item item) async {
  await getAllInventory();
  String itemOwner = item.getOwner();
  if (friendList.contains(itemOwner)) {
    cuser.borrowAItem(item);
  }
  reference.collection("users").doc(cuser.uname).set(cuser.toFirestore());

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
          itemMap["status"] = "Borrowed";
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

void returnItemDatabase(Item item) async {
  await getAllInventory();
  cuser.returnItem(item);
  reference.collection("users").doc(cuser.uname).set(cuser.toFirestore());

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
          itemMap["status"] = "Available";
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

void removeFriend(Person friend) async {
  await getAllInventory();
  cuser.removeFriend(friend);
  reference.collection("users").doc(cuser.uname).set(cuser.toFirestore());
}

void changeName(String name) async {
  cuser.setName(name);
  reference.collection("users").doc(cuser.uname).set(cuser.toFirestore());
}

void changeUserName(String newuName) async {
  reference.collection("users").doc(cuser.uname).delete();
  cuser.setUserName(newuName);
  cuser.setCUName(newuName);
  reference.collection("users").doc(cuser.uname).set(cuser.toFirestore());
}

void updatePassword(String newpassword) async {
  cuser.setPassword(newpassword);
  cuser.setCUPassword(newpassword);
  reference.collection("users").doc(cuser.uname).set(cuser.toFirestore());
}
