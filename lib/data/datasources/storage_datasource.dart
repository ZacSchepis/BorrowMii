import 'dart:io';

import 'package:borrow_mii/core/constants/firebase_collections.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:image_picker/image_picker.dart';
import 'package:uuid/uuid.dart';

class StorageDatasource {
  FirebaseStorage _storage;

  StorageDatasource() :_storage = FirebaseStorage.instanceFor(bucket: "gs://borrow-mii.firebasestorage.app");

  Future<String?> uploadImageToGCS(XFile file, String id) async{
    final ref = _storage.ref();
    final name = Uuid().v4();
    final imgPath = "$ITEM_IMAGES/$id/$name";
    print("THIS IS THE IMAGE PATH: '$imgPath'");
    final imageRef = ref.child(imgPath);
    final File file2 = File(file.path);
    await imageRef.putFile(file2);
    return imgPath;
    // return null;
  }
  Future<String> getImageFromGCS(String childPath) {
    final ref = _storage.ref().child(childPath);
    return ref.getDownloadURL();
  }
  Future<void> deleteImageFromGCS(String childPath) async {
    final ref = _storage.ref().child(childPath);
    await ref.delete();
    // if(ref.)
  }
}