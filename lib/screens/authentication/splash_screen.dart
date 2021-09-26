//@dart=2.9
import 'dart:async';

import 'package:flutter/material.dart';
import 'package:food_track/cache/cache_manager.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  AnimationController controller;
  Animation<double> animIn;
  CacheManager cache;
  var id;

  @override
  void initState() {
    super.initState();
    anim().whenComplete(() {
      controller.dispose();
      callCache();
    });
  }

  Future<void> anim() async {
    controller = AnimationController(
        vsync: this, duration: Duration(milliseconds: 1000));
    animIn = Tween<double>(
      begin: 1.0,
      end: 0.0,
    ).animate(CurvedAnimation(
        parent: controller,
        curve: Interval(0.75, 1.0, curve: Curves.elasticIn)));
    await controller.forward();
  }

  Future callCache() async {
    cache = await CacheManager().cache();
    id = await cache.getUID();
    if (id != null)
      return Timer(Duration(milliseconds: 500),
          () => Navigator.of(context).popAndPushNamed('/home'));
    else
      return Timer(Duration(milliseconds: 500),
          () => Navigator.of(context).popAndPushNamed('/auth'));
  }

  @override
  Widget build(BuildContext context) {
    return Center(child: Text("FoodTrack"));
  }
}
