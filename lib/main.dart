import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:team_d_project/logIn.dart';
import 'menu.dart';
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
    title: 'Log In',
    home: LogIn(),
  ));

  // runApp(MaterialApp(
  //   title: 'Navigation Basics',
  //   home: MyApp(),
  // ));
}

class MyApp extends StatelessWidget {
  ModelViewController mvc = ModelViewController();
  MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    // FirebaseFirestore db = FirebaseFirestore.instance;
    Item item = Item("Hammer", "Bill", "in stock");
    // Person user2 = Person(name: "Jenny Robins", dob: "03-10-1999");
    // user2.addItem(item);
    // user2.setUserName("jenrob");
    // user2.setPassword("147");
    // // user1.toFirestore();
    // db.collection("users").doc(user2.uname).set(user2.toFirestore());
    Widget titleSection = item.build(context);
    Widget panelSection = const Panel();
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
                              ProfileMenu().build(context)))
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
                              builder: (context) => Menu().build(context)))
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
