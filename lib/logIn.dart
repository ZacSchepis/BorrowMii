import 'package:flutter/material.dart';
import 'package:team_d_project/main.dart';
//menu for login
class LogIn extends StatelessWidget {
  const LogIn({super.key});
  //String text = "hello";
  void startApp(){
    runApp(MaterialApp(
      title: 'Navigation Basics',
      home: MyApp(),
    ));
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Log In'),
      ),
      body: Center(
        child: Column(
          children: [
            SizedBox( // <-- SEE HERE
              width: 200,
              child: TextField(
                decoration: InputDecoration(
                  labelText: 'Enter User Name',
                  border: OutlineInputBorder(),
                ),
              ),
            ),
            SizedBox( // <-- SEE HERE
              width: 200,
              child: TextField(
                obscureText: true,
                decoration: InputDecoration(
                  labelText: 'Enter Password',
                  border: OutlineInputBorder(),
                ),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  onPressed: () {
                    startApp();
                  },
                  child: const Text('Log In'),
                ),
                ElevatedButton(
                  onPressed: () {
                    startApp();
                  },
                  child: const Text('Sign up'),
                ),
              ],
            )
          ],
        )



      ),
    );
  }
}