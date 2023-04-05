import 'package:flutter/material.dart';
import 'package:team_d_project/main.dart';
//menu for login
class LogIn extends StatelessWidget {
  const LogIn({super.key});
  //String text = "hello";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Log In'),
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            runApp(MaterialApp(
              title: 'Navigation Basics',
              home: MyApp(),
            ));
          },
          child: const Text('Log In'),
        ),
      ),
    );
  }
}