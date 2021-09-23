// @dart=2.9
import 'dart:async';
import 'package:flutter/material.dart';
import 'package:food_track/cache/cache_manager.dart';
import 'package:food_track/models/user_type.dart';
import 'package:food_track/screens/authentication/authentication_wrapper.dart';
import 'package:food_track/screens/authentication/splash_screen.dart';
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
      initialRoute: '/splash',
      routes: {
        '/splash': (context) => SplashScreen(),
        '/auth': (context) => AuthenticationScreen(userType: userType),
        '/home': (context) => MainScreen(type: widget.type)
      },
    );
  }
}

//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//         debugShowCheckedModeBanner: false,
//         title: 'HERE SDK for Flutter - Hello Map!',
//         home: FutureBuilder<Position>(
//             future: _currentPosition,
//             builder: (BuildContext context, AsyncSnapshot<Position> snapshot) {
//               if (snapshot.hasData) {
//                 pos = snapshot.data;
//                 return HereMap(onMapCreated: _onMapCreated);
//               }
//               return const CircularProgressIndicator();
//             }));
//   }

//   Future<void> _onMapCreated(HereMapController hereMapController) async {
//     hereMapController.setWatermarkPosition(WatermarkPlacement.bottomLeft, 0);

//     hereMapController.mapScene.addMapArrow(MapArrow(
//         GeoPolyline(<GeoCoordinates>[
//           GeoCoordinates(pos.latitude, pos.longitude),
//           GeoCoordinates(pos.latitude, pos.longitude)
//         ]),
//         27,
//         Colors.purple));
//     hereMapController.mapScene.addMapArrow(MapArrow(
//         GeoPolyline(<GeoCoordinates>[
//           GeoCoordinates(pos.latitude + 0.002, pos.longitude),
//           GeoCoordinates(pos.latitude + 0.002, pos.longitude)
//         ]),
//         27,
//         Colors.deepOrange));
//     hereMapController.mapScene.loadSceneForMapScheme(MapScheme.normalDay,
//         (MapError error) async {
//       if (error != null) {
//         print('Map scene not loaded. MapError: ${error.toString()}');
//         return;
//       }
//       const double distanceToEarthInMeters = 8000;
//       hereMapController.camera.lookAtPointWithDistance(
//           GeoCoordinates(pos.latitude, pos.longitude), distanceToEarthInMeters);

//       hereMapController.mapScene.addMapPolyline(MapPolyline(
//           GeoPolyline(<GeoCoordinates>[
//             GeoCoordinates(pos.latitude, pos.longitude),
//             GeoCoordinates(pos.latitude + 0.002, pos.longitude)
//           ]),
//           10,
//           Colors.blue));
//     });
//   }
// }
