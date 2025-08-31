import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:team_d_project/data/datasources/user_datasource.dart';
import 'package:team_d_project/features/items/create_item/create_item_flow.dart';
import 'package:team_d_project/logIn.dart';
import 'menu.dart';
import 'panel.dart';
import 'profileMenu.dart';
import 'modelViewController.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

void main() async {
  final user = new UserState();
  user.setUser("12312", "123123");
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(
    MultiProvider(providers: [
      ChangeNotifierProvider(create: (_) => UserState()),
    ],
    child: const MaterialApp(
        title: 'Log In',
        home: LogIn(),
      ),
    )
  );
}

class MyApp extends StatelessWidget {
  ModelViewController mvc = ModelViewController();
  MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    Widget panelSection = Panel();
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
                          builder: (context) => ProfileMenu().build(context)))
                },
                icon: const Icon(Icons.account_circle_rounded),
              );
            },
          ),
          actions: [
            IconButton(
                onPressed: () => {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => CreateItemFlow()))
                    },
                icon: const Icon(Icons.more_vert)),
          ],
        ),
        body: Column(
          children: [
            //titleSection,
            Expanded(child: panelSection),
          ],
        ),
      ),
    );
  }
}
