// @dart=2.9
import 'dart:async';
import 'package:barcode_scan/barcode_scan.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:food_track/screens/authentication/user_type_screen.dart';
import 'package:food_track/view/inventory.dart';

void main() {
  runApp(App());
}

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        home: Scaffold(
            appBar: AppBar(
              title: Text('FoodTrack'),
            ),
            body: Inventory()));
  }
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  String barcode = "";

  @override
  initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: UserTypeScreen(),
      // home: Scaffold(
      //   appBar: AppBar(
      //     title: Text('Barcode Scanner - googleflutter.com'),
      //   ),
      //   body: Center(
      //     child: Column(
      //       children: <Widget>[
      //         Container(
      //           child: ElevatedButton(
      //             onPressed: barcodeScanning,
      //             child: Text(
      //               "Capture Image",
      //               style: TextStyle(fontSize: 20, color: Colors.white),
      //             ),
      //           ),
      //           padding: const EdgeInsets.all(10.0),
      //           margin: EdgeInsets.all(10),
      //         ),
      //         Padding(
      //           padding: const EdgeInsets.all(8.0),
      //         ),
      //         Text(
      //           "Scanned Barcode Number",
      //           style: TextStyle(fontSize: 20),
      //         ),
      //         Text(
      //           barcode,
      //           style: TextStyle(fontSize: 25, color: Colors.green),
      //         ),
      //       ],
      //     ),
      //   ),
      // ),
    );
  }

  //scan barcode asynchronously
  Future barcodeScanning() async {
    try {
      var barcoder = (await BarcodeScanner.scan());
      String barcode = barcoder.rawContent;
      setState(() => this.barcode = barcode);
    } on PlatformException catch (e) {
      if (e.code == BarcodeScanner.cameraAccessDenied) {
        setState(() {
          this.barcode = 'No camera permission!';
        });
      } else {
        setState(() => this.barcode = 'Unknown error: $e');
      }
    } on FormatException {
      setState(() => this.barcode = 'Nothing captured.');
    } catch (e) {
      setState(() => this.barcode = 'Unknown error: $e');
    }
  }
}
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
