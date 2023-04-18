import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'databaseController.dart';

//menu for editing profile features
class ProfileMenu extends StatelessWidget {
  ProfileMenu({super.key});
  final nameController = TextEditingController();
  final friendController = TextEditingController();
  final pwController = TextEditingController();
  //String text = "hello";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Profile'),
      ),
      body: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Row(
                children: [
                  Text("Change name:   "),
                  SizedBox(
                    // <-- SEE HERE
                    width: 200,
                    child: TextField(
                      textInputAction: TextInputAction.done,
                      onSubmitted: (value) {
                        changeName(value);
                      },
                      controller: nameController,
                      decoration: InputDecoration(
                        labelText: 'Enter New Name',
                        border: OutlineInputBorder(),
                      ),
                    ),
                  ),
                ],
              ),
              Row(
                children: [
                  Text("Add friend:   "),
                  SizedBox(
                    // <-- SEE HERE
                    width: 200,
                    child: TextField(
                      controller: friendController,
                      textInputAction: TextInputAction.done,
                      onSubmitted: (value) {
                        print("friend");
                      },
                      decoration: InputDecoration(
                        labelText: 'Enter User Name',
                        border: OutlineInputBorder(),
                      ),
                    ),
                  ),
                ],
              ),
              Row(
                children: [
                  Text("Reset Password:   "),
                  SizedBox(
                    // <-- SEE HERE
                    width: 200,
                    child: TextField(
                      controller: pwController,
                      textInputAction: TextInputAction.done,
                      onSubmitted: (value) {
                        updatePassword(value);
                        // print("pw");
                      },
                      obscureText: true,
                      decoration: InputDecoration(
                        labelText: 'Enter Password',
                        border: OutlineInputBorder(),
                      ),
                    ),
                  ),
                ],
              ),
              // ElevatedButton(
              //   onPressed: () {
              //     Navigator.pop(context);
              //   },
              //   child: const Text('Back'),
              // ),
            ],
          )
        ],
      ),
    );
  }
}
