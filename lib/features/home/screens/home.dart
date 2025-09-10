
import 'dart:async';

import 'package:app_links/app_links.dart';
import 'package:borrow_mii/data/datasources/app_linkstate_datasource.dart';
import 'package:borrow_mii/data/datasources/app_state.dart';
import 'package:borrow_mii/features/items/create_item/create_item_flow.dart';
import 'package:borrow_mii/features/items/view_item/item_scan.dart';
import 'package:borrow_mii/features/items/view_item/item_view.dart';
import 'package:borrow_mii/features/items/widgets/view_item/item_404.dart';
import 'package:borrow_mii/modelViewController.dart';
import 'package:borrow_mii/panel.dart';
import 'package:borrow_mii/profileMenu.dart';
import 'package:borrow_mii/router.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';


class Home extends StatefulWidget {
  const Home({super.key});
  @override
  State<Home> createState() => _HomeWidgetState();

}

class _HomeWidgetState extends State<Home> {
  ModelViewController mvc = ModelViewController();
  final AppLinks appLinks = AppLinks();
  // late final AppState appState;
  StreamSubscription? _sub;
  String? _latestLink;
  Uri? _uri;

  @override
  void initState() {
    super.initState();

    _sub = appLinks.uriLinkStream.listen((uri) {
      print("Got: ${uri.toString()}");
            //       if(appState.itemOpened) {
            //   return;
            // }
      // linkState.setLink(uri);
      handleLink(uri);
      // appState.setItemOpened();
      // linkState!.clear();
    });
  }
  // @override
  // void didChangeDependencies() {
  //   super.didChangeDependencies();
  //     AppLinkState linkState = Provider.of<AppLinkState>(context, listen: false);
  //   appLinks.getInitialLink().then((uri) {
  //     if(uri != null) {
  //       print("Initial link: ${uri.toString()}");
        
  //       linkState.setLink(uri);

            
  //       // appState.setItemOpened();
  //       // handleLink(uri);
  //       // linkState!.clear();

  //     }
  //   });

  // }
  // @override
  // void didChangeDependencies() {
  //   super.didChangeDependencies();
  //   // linkState = Provider.of<AppLinkState>(context, listen: false);
  //   appLinks.getInitialLink().then((uri) {
  //     if(uri != null) {
  //       print("Initial link: ${uri.toString()}");
  //       // _uri = uri;
  //       // linkState.setLink(uri);
  //       handleLink(uri);
  //       // linkState.clear();

  //     }
  //   });
  //   _sub = appLinks.uriLinkStream.listen((uri) {
  //     print("Got: ${uri.toString()}");
  //     // linkState.setLink(uri);
  //     handleLink(uri);
  //     // linkState.clear();
  //   });
  // }

  void handleLink(Uri? uri) {
    if(uri == null) return;

    switch(uri.scheme) {
      case "borrowmii1337": 
        final route = "/${uri.host}" + (uri.hasQuery ? "?${uri.query}" : "");
        final uid = uri.queryParameters["uuid"] ?? "";
        if(uid.isNotEmpty) {
          AppRouter.item(context, uid);
          // Navigator.push(context,);
        }
        print("Route we got: $route");
        // context.go(route);
        break;
      default:
        break;
    }
  }


  @override
  Widget build(BuildContext context) {
    Widget panelSection = Panel();
    return  Scaffold(
        appBar: AppBar(
          title: const Text('Borrow Mii'),
          centerTitle: true,
          leading: Builder(
            builder: (BuildContext context) {
              return IconButton(
                onPressed: () => {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => ProfileMenu().build(context)))
                },
                icon: const Icon(Icons.account_circle_rounded),
              );
            },
          ),
          actions: [
            IconButton(
                onPressed: () => {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => ItemScan()))
                    },
                icon: const Icon(Icons.more_vert)),
          ],
        ),
        // body: handleLink(_uri!)
        body: Column(
          children: [
            //titleSection,
            Expanded(child: panelSection),
          ],
        ),
    
    );
  }
}