import 'dart:io';

// import 'package:adminpanel/model/allmodels.dart';
// import 'package:adminpanel/model/user.dart';
import 'package:team_d_project/person.dart';
import 'package:team_d_project/item.dart';
import 'package:team_d_project/Notifiers/item_notifier.dart';
import 'package:team_d_project/Notifiers/user_notifier.dart';
// import 'package:adminpanel/notifier/auth_notifier.dart';
// import 'package:adminpanel/notifier/teacher_notifier.dart';
// import 'package:adminpanel/notifier/student_notifier.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:firebase_storage/firebase_storage.dart';
// import 'package:path/path.dart' as path;
// import 'package:uuid/uuid.dart';

// Future getUsers(UserNotifier userNotifier) async {
//   QuerySnapshot snapshot = await FirebaseFirestore.instance
//       .collection('Students')
//       .orderBy("createdAt", descending: true)
//       .get();

//   List<Person> _userList = [];

//   snapshot.docs.forEach((document) {
//     Person user = Person.fromMap(document.data());
//     _userList.add(user);
//   });

//   userNotifier.userList= _userList;
// }

// Future uploadUser(Person user, bool isUpdating, File localFile, Function userUploaded) async {
//   if (localFile != null) {
//     print("uploading image");

//     var fileExtension = path.extension(localFile.path);
//     print(fileExtension);

//     var uuid = Uuid().v4();

//     final Reference firebaseStorageRef =
//         FirebaseStorage.instance.ref().child('students/images/$uuid$fileExtension');
//   UploadTask uploadTask = firebaseStorageRef.putFile(localFile);
//      print('aaa');
//   print(uploadTask);
//   var imageUrl = await (await uploadTask).ref.getDownloadURL();
//   String url = imageUrl.toString();
//   print(url);




   
//     print("download url: $url");
//     _uploadUser(user, isUpdating, userUploaded, imageUrl: url);
//   } else {
//     print('...skipping image upload');
//     _uploadUser(user, isUpdating, userUploaded);
//   }
// }

// Future _uploadUser(Person user, bool isUpdating, Function userUploaded, {String imageUrl}) async {
//   CollectionReference userRef = FirebaseFirestore.instance.collection('Users');

//   if (imageUrl != null) {
//     user.image = imageUrl;
//   }

//   if (isUpdating) {
//     user.updatedAt = Timestamp.now();

//     await userRef.doc(user.name).update(user.toMap());

// studentUploaded(user);
//     print('updated student with id: ${user.name}');
//   } else {
//   user.createdAt = Timestamp.now();

//     DocumentReference documentRef = await userRef.add(user.toMap());

//  user.name = documentRef.id;

//     print('uploaded food successfully: ${user.toString()}');

//     await documentRef.set(user.toMap(), SetOptions(merge: true));

//    userUploaded(user);
//   }
// }

// Future deleteUser(Person user, Function userDeleted) async {
//   if (user.image != null) {
//   Reference storageReference =
//       FirebaseStorage.instance.refFromURL(user.image);

//     // print(storageReference.path);

//     await storageReference.delete();

//     print('image deleted');
//   }

//   await FirebaseFirestore.instance.collection('Users').doc(user.name).delete();
// userDeleted(user);
// }
