// @dart=2.9
import 'dart:async';
import 'package:flutter/material.dart';
import 'package:food_track/cache/cache_manager.dart';
import 'package:food_track/models/user_type.dart';
import 'package:food_track/screens/authentication/authentication_wrapper.dart';
import 'package:food_track/screens/authentication/splash_screen.dart';
import 'package:food_track/screens/authentication/user_type_screen.dart';
import 'package:food_track/view/main_page.dart';

class App extends StatefulWidget {
  final String type;
  const App({Key key, this.type}) : super(key: key);
  @override
  State<StatefulWidget> createState() {
    return AppState();
  }
}

class AppState extends State<App> {
  CacheManager _cache;
  UserType userType;
  @override
  void initState() {
    super.initState();
    userType = widget.type == "sellers" ? UserType.store : UserType.customer;
    store();
  }

  Future<void> store() async {
    _cache = await CacheManager().cache();
    await _cache.storetype(widget.type);
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "FoodTruck",
      debugShowCheckedModeBanner: false,

      // initialRoute: '/splash',
      initialRoute: '/splash',
      routes: {
        '/splash': (context) => SplashScreen(),
        '/auth': (context) => AuthenticationScreen(userType: userType),
        '/home': (context) => MainScreen(type: widget.type)
      },
    );
  }
}
