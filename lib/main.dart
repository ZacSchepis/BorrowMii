import 'dart:async';
import 'package:app_links/app_links.dart';
// import 'package:borrow_mii/core/controllers/link_controller.dart';
import 'package:borrow_mii/core/errors/item_errors.dart';
import 'package:borrow_mii/data/datasources/app_linkstate_datasource.dart';
import 'package:borrow_mii/data/datasources/app_state.dart';
import 'package:borrow_mii/features/home/screens/home.dart';
import 'package:borrow_mii/features/items/view_item/item_view.dart';
import 'package:borrow_mii/features/items/widgets/view_item/item_404.dart';
import 'package:borrow_mii/router.dart';
import 'package:flutter/services.dart';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:borrow_mii/data/datasources/user_datasource.dart';
import 'package:borrow_mii/features/items/create_item/create_item_flow.dart';
import 'package:borrow_mii/logIn.dart';
import 'menu.dart';
import 'panel.dart';
import 'profileMenu.dart';
import 'modelViewController.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final user = new UserState();
  // final appLinkState = new AppLinkState();
  // final appState = AppState();
  user.setUser("12312", "123123");
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  final router = AppRouter().router;
  runApp(
    MultiProvider(providers: [
      ChangeNotifierProvider(create: (_) => user),
      // ChangeNotifierProvider(create: (_) => appLinkState),
      // ChangeNotifierProvider(create: (_) => appState)
    ],
      child:  MyApp()
    ),
      
      
    );
}

class MyApp extends StatelessWidget {
  // final GoRouter router;
  const MyApp({super.key});
  // MyApp({Key? key}) : super(key: key);

// MaterialApp(
//       title: 'First UI',
//       theme: ThemeData(
//         // This is the theme of your application.

//         primarySwatch: Colors.blue,
//       ),
//       home:
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    final router = AppRouter().router;
    return MaterialApp.router(routerConfig: router,
    // builder: (ctx, child) {
    //   return 
    // },
    );
  }
}
