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

void borrowItem(Item item) async {
  await getAllInventory();
  cuser.borrowAItem(item);
  reference.collection("users").doc(cuser.uname).set(cuser.toFirestore());
}

void returnItem(Item item) async {
  await getAllInventory();
  cuser.returnItem(item);
  // print(cuser.bItems);
  reference.collection("users").doc(cuser.uname).set(cuser.toFirestore());
}

void addFriend(Person friend) async {
  await getAllInventory();
  await FirebaseFirestore.instance
      .collection("users")
      .doc(friend.uname)
      .get()
      .then((DocumentSnapshot documentSnapshot) {
    if (documentSnapshot.exists) {
      cuser.addFriend(friend);
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
