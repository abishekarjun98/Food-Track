// @dart=2.9
import 'dart:typed_data';

// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'package:here_sdk/core.dart';
// import 'package:here_sdk/mapview.dart';
// import 'package:geolocator/geolocator.dart';

// void main() {
//   SdkContext.init(IsolateOrigin.main);
//   runApp(const MyApp());
// }

// class MyApp extends StatefulWidget {
//   const MyApp({Key key}) : super(key: key);

//   @override
//   State<StatefulWidget> createState() {
//     return MyAppState();
//   }
// }

// class MyAppState extends State {
//   static Geolocator geolocator = Geolocator();
//   Future<Position> _currentPosition;
//   Position pos;

//   @override
//   void initState() {
//     super.initState();
//     setState(() {
//       _currentPosition = _getPosition();
//     });
//   }

//   Future<Position> _getPosition() async {
//     bool serviceEnabled;
//     LocationPermission permission;
//     serviceEnabled = await Geolocator.isLocationServiceEnabled();
//     if (!serviceEnabled) {
//       return Future.error('Location services are disabled.');
//     }

//     permission = await Geolocator.checkPermission();
//     if (permission == LocationPermission.denied) {
//       permission = await Geolocator.requestPermission();
//       if (permission == LocationPermission.denied) {
//         return Future.error('Location permissions are denied');
//       }
//     }

//     if (permission == LocationPermission.deniedForever) {
//       return Future.error(
//           'Location permissions are permanently denied, we cannot request permissions.');
//     }
//     return await Geolocator.getCurrentPosition();
//   }

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
