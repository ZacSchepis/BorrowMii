import 'package:borrow_mii/data/datasources/storage_datasource.dart';
import 'package:borrow_mii/data/datasources/user_datasource.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

class StorageRepository {
  StorageDatasource _storage;
  StorageRepository() :
      _storage = StorageDatasource()
      ;
    Future<String?> uploadImage(XFile file, BuildContext context) async{
      try {
        final userId = context.read<UserState>().getUserID();
        return _storage.uploadImageToGCS(file, userId!);
      } catch (e) {
        rethrow;
      }
    }
    Future<String> getImageFromGCS(String childPath)  async{
      return _storage.getImageFromGCS(childPath);
    }
    Future<String?> deleteImage(String childPath) async {
      try {
        await _storage.deleteImageFromGCS(childPath);
        return null;
      } catch (e) {
        return "Image could not be deleted";
      }
    }
    // void uploadImage
}