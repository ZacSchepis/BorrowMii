import 'dart:async';
// import 'package:borrow_mii/core/controllers/link_controller.dart';
import 'package:borrow_mii/data/datasources/app_linkstate_datasource.dart';
import 'package:borrow_mii/data/datasources/app_state.dart';
import 'package:borrow_mii/data/datasources/friends_state.dart';
import 'package:borrow_mii/data/models/user_model.dart';
import 'package:borrow_mii/router.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/foundation.dart';

import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:borrow_mii/data/datasources/user_datasource.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

const _kShouldTestAsyncErrorOnInit = false;
// Toggle this for testing Crashlytics in your app locally.
const _kTestingCrashlytics = true;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await dotenv.load(fileName: "lib/.env");
  String? mode = dotenv.env["MODE"];
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  // if(mode != null && mode != "PRODUCTION") {
  //   const String host = "10.34.188.177";
  //   final int auth_port = 9099;
  //   final int firestore_port = 8080;
  //   FirebaseFirestore.instance.useFirestoreEmulator(host, firestore_port);
  //   // FirebaseFirestore.instance.settings = Settings(
  //   //   host: "$host:8080",
  //   //   sslEnabled: false,
  //   //   persistenceEnabled: false
  //   // );
  //   await FirebaseAuth.instance.useAuthEmulator(host, auth_port);
  //   // FirebaseFirestore.instance.useFirestoreEmulator(host, firestore_port);
  // }
  // await Firebase.initializeApp(
  //   options: DefaultFirebaseOptions.currentPlatform
  // );
  const fatalError = true;
  FlutterError.onError = (errorDetails) {
    if(fatalError) {
      FirebaseCrashlytics.instance.recordFlutterFatalError(errorDetails);
    } else {
      FirebaseCrashlytics.instance.recordFlutterError(errorDetails);
    }
  };
  PlatformDispatcher.instance.onError = (error, stack) {
    if(fatalError) {
      FirebaseCrashlytics.instance.recordError(error, stack, fatal: true);
    } else {
      FirebaseCrashlytics.instance.recordError(error, stack);
    }
    return true;
  };

  final user = new UserState();
  FirebaseAuth.instance.authStateChanges().listen((User? _user) {
    user.setUser(_user);
  });

  final router = AppRouter().router;
  final friends = FriendsState();
  friends.addFriend(UserModel(name: "Zac", id: "6LY6Dm1W0HXmQ1IjxpB1dP9iQNz1", image: ""));
  friends.addFriend(UserModel(name: "Lester", id: "ochu6hYRe8aydF9Cbmf8vKpDbWZ2", image: ""));
runApp(
    MultiProvider(providers: [
      ChangeNotifierProvider(create: (_) => user),
      ChangeNotifierProvider(create: (_) => friends)
      // ChangeNotifierProvider(create: (_) => appLinkState),
      // ChangeNotifierProvider(create: (_) => appState)
    ], child: MyApp(),),
  );

}

class BorrowMiiApp extends StatefulWidget {
  const BorrowMiiApp({
    super.key
  });

  @override
  State<BorrowMiiApp> createState() => _BorrowMiiAppWidgetState();
}

class _BorrowMiiAppWidgetState extends State<BorrowMiiApp> {
  final GoRouter _router = AppRouter().router;
  bool _showLogin = false;
  void _updateUser() {
    final user = Provider.of<UserState>(context, listen: false);
  }

  @override
  void didChangeDependencies() {
    _updateUser();
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    
      return MaterialApp.router(routerConfig: _router,
    // builder: (ctx, child) {
    //   return 
    // },
    );
  }
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<StatefulWidget> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {

  @override 
  Widget build(BuildContext context) {
    final router = AppRouter().router;
    return MaterialApp.router(routerConfig: router,

    );
  }
}