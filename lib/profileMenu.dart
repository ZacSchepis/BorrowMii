import 'package:flutter/material.dart';
//menu for editing profile features
class ProfileMenu extends StatelessWidget {
  const ProfileMenu({super.key});
  //String text = "hello";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Profile'),
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            Navigator.pop(context);
          },
          child: const Text('Back'),
        ),
      ),
    );
  }
}