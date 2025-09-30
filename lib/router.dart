import 'package:borrow_mii/core/errors/link_errors.dart';
import 'package:borrow_mii/data/datasources/user_datasource.dart';
import 'package:borrow_mii/features/home/screens/home.dart';
import 'package:borrow_mii/features/items/view_item/item_view.dart';
import 'package:borrow_mii/logIn.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

class AppRouter {
  final GoRouter router = GoRouter(
    initialLocation: "/"
    ,routes: [
    GoRoute(path: "/", name: "home", builder: (BuildContext context, __) {
      // final user = context.read<UserState>();
      UserState user = Provider.of<UserState>(context, listen: true);
      if(user.getUserID() == null) {
        return const LogIn();
      }
      return const Home();
    }),
    GoRoute(
      path: "/item",
      // name: "item",
      builder: (context, state) {
        final itemUUID = state.uri.queryParameters["uuid"];
        if (itemUUID == null || itemUUID.isEmpty) {
          return const Scaffold(
            body: Center(
              child: Text("No item id provided"),
            ),
          );
        }
        return ItemViewWidget(itemId: itemUUID);
      },
    )
  ]);
  static void handleLink(BuildContext ctx, Uri? uri) {
    if(uri == null) return;
    switch(uri.scheme) {
      case "borrowmii1337": 
        final route = "/${uri.host}" + (uri.hasQuery ? "?${uri.query}" : "");
        final uid = uri.queryParameters["uuid"] ?? "";
        if(uid.isNotEmpty) {
          AppRouter.item(ctx, uid);
        }
        print("Route we got: $route");
        break;
      default:
        throw LinkException("URL is not recognized");
    }
  }
  static void item(BuildContext context, String uid) {
    Navigator.push(context,  MaterialPageRoute(builder: (ctx) => ItemViewWidget(itemId: uid)));
  }
  
}
