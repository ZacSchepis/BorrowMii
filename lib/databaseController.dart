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
CurrentUser cuser = CurrentUser();
FirebaseFirestore reference = FirebaseFirestore.instance;

// Future<List<dynamic>> getUserInventory(String uname) async {
//   // print('here1');
//   // print(uname);
//   await FirebaseFirestore.instance
//       .collection("users")
//       .doc(uname)
//       .get()
//       .then((DocumentSnapshot documentSnapshot) {
//     if (documentSnapshot.exists) {
//       List<dynamic> items = documentSnapshot.get("myItems");
//       userItems = items;
//       // print('here2');
//     }
//   });
//   return userItems;
// }

void getUserInventory() async {
  // print('here1');
  // print(uname);
  await FirebaseFirestore.instance
      .collection("users")
      .doc(cuser.uname)
      .get()
      .then((DocumentSnapshot documentSnapshot) {
    if (documentSnapshot.exists) {
      List<dynamic> items = documentSnapshot.get("myItems");
      userItems = items;
      // print('here2');
    }
  });
  print(userItems);
  // return userItems;
}

getUserItems() {
  return userItems;
}

Future<List<dynamic>> getBorrowedInventory(String uname) async {
  await FirebaseFirestore.instance
      .collection("users")
      .doc(uname)
      .get()
      .then((DocumentSnapshot documentSnapshot) {
    if (documentSnapshot.exists) {
      List<dynamic> items = documentSnapshot.get("borrowedItems");
      borrowedItems = items;
    }
  });
  return userItems;
}

// add item function
void addItemToDatabase(Item item) async {
  cuser.addItem(item);
  print(cuser.myItems);
  var doc = await reference.collection("users").doc(cuser.uname).get();
  if (doc.exists) {
    reference.collection("users").doc(cuser.uname).set(cuser.toFirestore());
  }
}

//remove item function
void removeItemFromDatabase(Item item) async {
  cuser.removeItem(item);
  print(cuser.myItems);
  var doc = await reference.collection("users").doc(cuser.uname).get();
  if (doc.exists) {
    reference.collection("users").doc(cuser.uname).set(cuser.toFirestore());
  }
}

void borrowItem(Item item) async {
  cuser.borrowItem(item);
  var doc = await reference.collection("users").doc(cuser.uname).get();
  if (doc.exists) {
    reference.collection("users").doc(cuser.uname).set(cuser.toFirestore());
  }
}

void returnItem(Item item) async {
  cuser.returnItem(item);
  var doc = await reference.collection("users").doc(cuser.uname).get();
  if (doc.exists) {
    reference.collection("users").doc(cuser.uname).set(cuser.toFirestore());
  }
}
