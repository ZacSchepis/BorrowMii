import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'modelViewController.dart';
import 'databaseController.dart';

//menu for editing profile features
class ProfileMenu extends StatelessWidget {
  ProfileMenu({super.key});
  final nameController = TextEditingController();
  final friendController = TextEditingController();
  final pwController = TextEditingController();
  final ModelViewController mvc = ModelViewController();
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
                  const Text("Change name:   "),
                  SizedBox(
                    // <-- SEE HERE
                    width: 200,
                    child: TextField(
                      textInputAction: TextInputAction.done,
                      onSubmitted: (value) {
                        changeName(value);
                        nameController.text = "";
                      },
                      controller: nameController,
                      decoration: const InputDecoration(
                        labelText: 'Enter New Name',
                        border: OutlineInputBorder(),
                      ),
                    ),
                  ),
                ],
              ),
              Row(
                children: [
                  const Text("Add friend:   "),
                  SizedBox(
                    // <-- SEE HERE
                    width: 200,
                    child: TextField(
                      controller: friendController,
                      textInputAction: TextInputAction.go,
                      onSubmitted: (value) {
                        print(value);
                        addFriend(value);
                        friendController.text = "";
                      },
                      decoration: const InputDecoration(
                        labelText: 'Enter User Name',
                        border: OutlineInputBorder(),
                      ),
                    ),
                  ),
                ],
              ),
              Row(
                children: [
                  const Text("Reset Password:   "),
                  SizedBox(
                    // <-- SEE HERE
                    width: 200,
                    child: TextField(
                      controller: pwController,
                      textInputAction: TextInputAction.done,
                      onSubmitted: (value) {
                        updatePassword(value);
                        pwController.text = "";
                      },
                      obscureText: true,
                      decoration: const InputDecoration(
                        labelText: 'Enter Password',
                        border: OutlineInputBorder(),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          )
        ],
      ),
    );
  }
}
