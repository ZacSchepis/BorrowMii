import 'package:flutter/material.dart';
import 'Menu.dart';

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
    Widget titleSection = Container(
      padding: const EdgeInsets.all(32),

        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
              Container(
                padding: const EdgeInsets.only(left:50),
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const Menu().build(context)),
                    );
                  },
                  // style: ButtonStyle(elevation: MaterialStateProperty(12.0 )),
                  style: ElevatedButton.styleFrom(
                      elevation: 12.0,
                      textStyle: const TextStyle(color: Colors.white)),

                  child: const Text('Menu'),
                ),
              ),
              Row(
                children: [
                  Container(
                    padding: const EdgeInsets.only(right: 50),
                    child: const Text(
                      'First, Last',
                      textAlign: TextAlign.right,
                      style: TextStyle(
                        color: Colors.grey,
                      ),
                    ),
                  ),
                  /*3*/
                  Container(
                    padding: const EdgeInsets.only(right: 50),
                    child: Icon(
                      Icons.person,
                      color: Colors.red[500],
                    ),
                  ),
                ],
              )

          ],
        ),
    );
    return MaterialApp(
      title: 'First UI',
      theme: ThemeData(
        // This is the theme of your application.

        primarySwatch: Colors.blue,
      ),
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Borrow Mii'),
        ),
        body: Column(
          children: [
            titleSection,
          ],
        ),
        ),
    );
  }
}
