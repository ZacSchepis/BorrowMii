import 'dart:async';

import 'package:app_links/app_links.dart';
import 'package:borrow_mii/data/datasources/app_linkstate_datasource.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

class LinkController extends StatefulWidget {
  final Widget child;
  const LinkController({super.key, required this.child});

  @override
  State<LinkController> createState() => _LinkControllerWidgetState();
}

class _LinkControllerWidgetState extends State<LinkController> {
  // final Widget child;
  // const LinkController({super.key, required this.child});
  final AppLinks appLinks = AppLinks();
  StreamSubscription? _sub;

  AppLinkState? appLink;
  String handleLink(Uri uri, BuildContext context) {
    switch (uri.scheme) {
      case "borrowmii1337":
        final route = "/${uri.host}" + (uri.hasQuery ? "?${uri.query}" : "");
        print("Route we got ADASD: $route");
        return route;
      default:
        return "";
    }
  }

  @override
  void initState() {
    super.initState();

  }

  void _handleInconmingLink(Uri uri) {
    // final appLink = context.read<AppLinkState>();
    // if (appLink.currentLink != null) {
      print("Updating link via didChange");
      // final uri = appLink.currentLink!;
      String route = handleLink(uri, context);
      if (route.isNotEmpty) {
        WidgetsBinding.instance.addPostFrameCallback((_) {
          context.push(route);
          // appLink.clear();
        });
      }
    // }
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
        appLinks.getInitialLink().then((uri) {
      if (uri != null) {
        _handleInconmingLink(uri);
      }
    });
  _sub = appLinks.uriLinkStream.listen((uri) {
      print("Got: ${uri.toString()}");
      if(uri != null) {
        // context.go(route);
        _handleInconmingLink(uri);
      }
      // linkState.setLink(uri);
      // handleLink(uri);
      // linkState.clear();
    });
  }

  @override
  Widget build(BuildContext context) {
    return widget.child;
  }
  @override
  void dispose() {
    _sub?.cancel();
    super.dispose();
  
  }
  // @override
  // void dispose() {
  //   super.dispose();
  //   AppLinkState? ap = appLink;
  //   if(ap !=null) {
  //     ap.dispose();
  //   }
  // }
}
