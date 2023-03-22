import 'package:flutter/material.dart';
import 'Menu.dart';
import 'panel.dart';
import 'profileMenu.dart';

void main() {
  runApp(const MaterialApp(
    title: 'Navigation Basics',
    home: MyApp(),
  ));
}

class MyApp extends StatelessWidget {

  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    Widget titleSection = Container();
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
              return IconButton(onPressed: () => {
                  Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const profileMenu().build(context)))
                }, icon: Icon(Icons.account_circle_rounded),
              );
            },
          ),
          actions: [
            IconButton(onPressed: () => {
            Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const Menu().build(context)))
            }, icon: Icon(Icons.more_vert)),
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
