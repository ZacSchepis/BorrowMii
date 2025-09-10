import 'package:flutter/material.dart';

class AppState extends ChangeNotifier {
  bool _itemOpened = false;
  bool get itemOpened => _itemOpened;
  // const AppState({})
  void setItemOpened() {
    _itemOpened = true;
    notifyListeners();
  }
}