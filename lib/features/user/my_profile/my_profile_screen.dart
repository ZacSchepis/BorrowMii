import 'package:borrow_mii/data/datasources/user_datasource.dart';
import 'package:borrow_mii/data/repositories/item_repository.dart';
import 'package:borrow_mii/data/repositories/storage_repository.dart';
import 'package:borrow_mii/features/items/widgets/view_item/item_image.dart';
import 'package:borrow_mii/widgets/button.dart';
import 'package:borrow_mii/widgets/form_control.dart';
import 'package:borrow_mii/widgets/images/image_modal.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

class MyProfileScreen extends StatefulWidget {
  MyProfileScreen({super.key});

  @override
  State<MyProfileScreen> createState() => _MyProfileScreenWidgetState();
}

class _MyProfileScreenWidgetState extends State<MyProfileScreen> {
  String displayName = "";
  String imageUrl = "";
  int friends = 0;
  StorageRepository storage = StorageRepository();
  XFile? file;
  // ImageSource imageSource;
  void _onUserUpdate() {
    final UserState user = Provider.of<UserState>(context, listen: true);
    final profile = user.user;

    if (profile != null) {
      setState(() {
        displayName = profile.displayName ?? "";
        imageUrl = profile.photoURL ?? "";
      });
    } else {
      displayName = "";
      imageUrl = "";
      friends = 0;
    }
  }

  @override
  void didChangeDependencies() {
    _onUserUpdate();
    super.didChangeDependencies();
  }

  Future<void> setUserProfilePic(ImageSource mode) async {
    // 1. Open file picker/camera
    // storage.uploadImageToPath(file, userId, path)
    // 2. Do the thing

    // 3.
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Profile"),
        ),
        body: Padding(
            padding: EdgeInsets.all(8.0),
            child: Column(children: [
              Row(
                children: [
                  TapRegion(
                    child: ItemImage(
                      itemId: imageUrl,
                      isGCSImage: false,
                    ),
                    onTapInside: (e) => showDialog(
                        context: context,
                        builder: (_) => Dialog(
                              child: IntrinsicHeight(
                                child: ImageModal(
                                    onSelectImage: (XFile? f) => {},
                                    selectedImage: file,
                                    pickImage: setUserProfilePic,
                                    imagePath: ""),
                              ),
                            )),
                  )
                ],
              ),
              Row(
                children: [Text("Name: $displayName")],
              ),
              Row(
                children: [Text("$friends Friends")],
              ),
              Row(
                children: [
                  FormControl(
                    label: "Display name",
                    onChanged: (value) => {
                      if (value != null && value != displayName)
                        {
                          FirebaseAuth.instance.currentUser
                              ?.updateDisplayName(value)
                        }
                    },
                  ),
                  
                ],
              ),
                Row(children: [
                  Button(
                      text: "Logout",
                      onPressed: () => {FirebaseAuth.instance.signOut()})
                ],)
            ])));
  }
}
