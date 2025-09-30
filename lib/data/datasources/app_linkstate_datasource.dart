import 'package:flutter/material.dart';

class AppLinkState extends ChangeNotifier {
  Uri? _currentLink;
  Uri? get currentLink => _currentLink;
  // void _handleLink(Uri? uri) {
  //   final Uri? _uri = uri;
  //   if(_uri == null) {
  //     return;
  //   }
  //     switch(_uri.scheme) {
  //     case "borrowmii1337": 
  //       final route = "/${_uri.host}" + (_uri.hasQuery ? "?${_uri.query}" : "");
  //       print("Route we got: $route");
  //       context.go(route);
  //       break;
  //     default:
  //       break;
  //   }
  // }
  void setLink(Uri? link) {
    _currentLink = link;
    notifyListeners();
  }
  void clear() {
    _currentLink = null;
    notifyListeners();
  }
}