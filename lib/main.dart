import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'Menu.dart';
import 'panel.dart';
import 'profileMenu.dart';
import 'modelViewController.dart';
import 'person.dart';
import 'item.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

void main() async {
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(MaterialApp(
    title: 'Navigation Basics',
    home: MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  modelViewController mvc = modelViewController();
  MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    // var db = FirebaseFirestore.instance;
    Item item = Item("Hammer", "Bill", "Bill", "in stock");
    // Item item2 = Item("screw Driver", "Bill", "Bill", "in stock");
    // Person user1 = Person("Billy Brown", "09/23/1975");
    // user1.addItem(item);
    // user1.addItem(item2);
    // db.collection("users").doc(user1.name).set(user1.toFirestore());
    Widget titleSection = item.build(context);
    Widget panelSection = const panel();
    return MaterialApp(
      title: 'First UI',
      theme: ThemeData(
        // This is the theme of your application.

        primarySwatch: Colors.blue,
      ),
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Borrow Mii'),
          centerTitle: true,
          leading: Builder(
            builder: (BuildContext context) {
              return IconButton(
                onPressed: () => {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) =>
                              const profileMenu().build(context)))
                },
                icon: Icon(Icons.account_circle_rounded),
              );
            },
          ),
          actions: [
            IconButton(
                onPressed: () => {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                                  const Menu().build(context)))
                    },
                icon: Icon(Icons.more_vert)),
          ],
        ),
        body: Column(
          children: [
            titleSection,
            Expanded(child: panelSection),
          ],
        ),
      ),
    );
  }
}
