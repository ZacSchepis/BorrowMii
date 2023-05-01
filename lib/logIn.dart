import 'package:flutter/material.dart';
import 'package:team_d_project/main.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
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

  // verifies user does not exist in database -- signs them up and writes to database.
  // if exists creates pop up window saying username already exists
  void formSignUp() async {
    var doc =
        await reference.collection("users").doc(userNameController.text).get();
    if (!doc.exists) {
      CurrentUser currentUser = CurrentUser();
      currentUser.setCUName(userNameController.text);
      currentUser.setCUPassword(userPasswordController.text);
      currentUser.setUserName(userNameController.text);
      currentUser.setPassword(userPasswordController.text);
      reference
          .collection("users")
          .doc(userNameController.text)
          .set(currentUser.toFirestore());
      startApp();
    } else {
      _showSignUpErrorMessage();
    }
  }

  // verifies existing user log in with password stored in database
  // if password incorrect shows error message
  void formValidation() async {
    await reference
        .collection('users')
        .doc(userNameController.text)
        .get()
        .then((DocumentSnapshot documentSnapshot) {
      if (documentSnapshot.exists) {
        if (documentSnapshot.get('password') == userPasswordController.text) {
          CurrentUser currentUser = CurrentUser();
          currentUser.setCUName(userNameController.text);
          currentUser.setCUPassword(userPasswordController.text);
          startApp();
        } else {
          _showErrorMessage();
        }
      } else {
        _showErrorMessage();
      }
    });
  }

  // error message for incorrect log in
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

  // error message for user already existing when trying to sign up
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
          Text(""),
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
          Text(""),
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
          Text(""),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton(
                onPressed: () {
                  formValidation();
                },
                child: const Text('Log In'),
              ),
              Text("       "),
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
