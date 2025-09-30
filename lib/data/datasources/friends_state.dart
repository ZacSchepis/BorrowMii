import 'package:borrow_mii/core/errors/friend_errors.dart';
import 'package:borrow_mii/data/models/user_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:collection/collection.dart';

import 'package:flutter/material.dart';

class FriendsState extends ChangeNotifier {
  final List<UserModel> _friends = List.empty(growable: true);
  final Set<String> _friendIds = Set();
  List<UserModel> get friends => List.unmodifiable(_friends);

  void addFriend(UserModel user) {
    final id = user.id;
    if(id == null || id.isEmpty) {
      throw FriendException("Couldn't add user");
    }
      if(!hasFriend(id)) {
        _friends.add(user);
        _friendIds.add(id);
        notifyListeners();
      }
  }
  void removeFriend(String id) {
    _friends.removeWhere((u) => u.id == id);
    _friendIds.remove(id);
    notifyListeners();
  }
  bool hasFriend(String id) => _friendIds.contains(id);
  UserModel? getFriendById(String id) => _friends.firstWhereOrNull((u) => u.id == id);
  
}