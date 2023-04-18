import 'package:flutter/material.dart';
import 'package:team_d_project/main.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'current_user.dart';
import 'person.dart';
import 'Notifiers/user_notifier.dart';
import 'current_user.dart';

class LogIn extends StatefulWidget {
  const LogIn({Key? key}) : super(key: key);

  @override
  LogInPage createState() => LogInPage();
}

class LogInPage extends State<LogIn> {
  TextEditingController userNameController = TextEditingController();
  TextEditingController userPasswordController = TextEditingController();
  final reference = FirebaseFirestore.instance;

  void startApp() {
    runApp(MaterialApp(
      title: 'Navigation Basics',
      home: MyApp(),
    ));
  }

  void formSignUp() async {
    var doc =
        await reference.collection("users").doc(userNameController.text).get();
    if (!doc.exists) {
      CurrentUser currentUser = CurrentUser();
      currentUser.setUName(userNameController.text);
      currentUser.setUPassword(userPasswordController.text);
      reference
          .collection("users")
          .doc(userNameController.text)
          .set(currentUser.toFirestore());
      // .set({"password": userPasswordController.text});
      // CurrentUser currentUser = CurrentUser();
      // currentUser.setUName(userNameController.text);
      // currentUser.setUPassword(userPasswordController.text);
      // currentUser.setHasItems(false);
      // currentUser.setHasBItems(false);
      currentUser.setNewUser(true);
      // currentUser.toFirestore();
      // currentUser.setUItems();
      // currentUser.setBItems();
      startApp();
    } else {
      _showSignUpErrorMessage();
    }
  }

  void formValidation() async {
    await reference
        .collection('users')
        .doc(userNameController.text)
        .get()
        .then((DocumentSnapshot documentSnapshot) {
      if (documentSnapshot.exists) {
        if (documentSnapshot.get('password') == userPasswordController.text) {
          CurrentUser currentUser = CurrentUser();
          currentUser.setUName(userNameController.text);
          currentUser.setUPassword(userPasswordController.text);
          // currentUser.toFirestore();
          // currentUser.setUItems();
          // currentUser.setBItems();
          startApp();
        } else {
          _showErrorMessage();
        }
      } else {
        _showErrorMessage();
      }
    });
  }

  Future<void> _showErrorMessage() async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Error'),
          content: SingleChildScrollView(
            child: ListBody(
              children: const <Widget>[
                Text('Incorrect User Name or Password!'),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('Ok'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  Future<void> _showSignUpErrorMessage() async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Error'),
          content: SingleChildScrollView(
            child: ListBody(
              children: const <Widget>[
                Text(
                    'User name already exists! Please create a different one.'),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('Ok'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
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
          SizedBox(
            // <-- SEE HERE
            width: 200,
            child: TextFormField(
                controller: userNameController,
                decoration: InputDecoration(
                  labelText: 'Enter User Name',
                  border: OutlineInputBorder(),
                ),
                validator: (input) {
                  if (input!.isEmpty) {
                    return 'Enter User Name';
                  }
                  return null;
                }),
          ),
          SizedBox(
            // <-- SEE HERE
            width: 200,
            child: TextFormField(
              obscureText: true,
              controller: userPasswordController,
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
                  formValidation();
                },
                child: const Text('Log In'),
              ),
              ElevatedButton(
                onPressed: () {
                  formSignUp();
                },
                child: const Text('Sign up'),
              ),
            ],
          )
        ],
      )),
    );
  }
}
