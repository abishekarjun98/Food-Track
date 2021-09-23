import 'package:flutter/material.dart';
import 'package:food_track/feeds_page.dart';
import 'package:food_track/search_page.dart';
import 'package:geolocator/geolocator.dart';

class UtilsManager {
  static List<Widget> buyerNavPage() => <Widget>[
        FeedsPage(),
        SearchPage(),
        Text(
          'Index 2: Cart',
        ),
        Text(
          'Index 3: Profile',
        ),
      ];

  static List<BottomNavigationBarItem> buyerNavButton() => [
        BottomNavigationBarItem(
          icon: Icon(Icons.home),
          label: 'Feed',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.search),
          label: 'Search',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.shopping_cart),
          label: 'Cart',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.face),
          label: 'Profile',
        ),
      ];
  static List<Widget> sellerNavPage() => <Widget>[
        Text(
          'Index 0: Store',
        ),
        Text(
          'Index 1: Scan',
        ),
        Text(
          'Index 2: Orders',
        ),
        Text(
          'Index 3: Profile',
        ),
      ];

  static List<BottomNavigationBarItem> sellerNavButton() => [
        BottomNavigationBarItem(
          icon: Icon(Icons.store),
          label: 'Store',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.qr_code_scanner),
          label: 'Scan',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.shopping_cart),
          label: 'Orders',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.face),
          label: 'Profile',
        ),
      ];
  Future<Position> getPosition() async {
    bool serviceEnabled;
    LocationPermission permission;

    // Test if location services are enabled.
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      // Location services are not enabled don't continue
      // accessing the position and request users of the
      // App to enable the location services.
      return Future.error('Location services are disabled.');
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        // Permissions are denied, next time you could try
        // requesting permissions again (this is also where
        // Android's shouldShowRequestPermissionRationale
        // returned true. According to Android guidelines
        // your App should show an explanatory UI now.
        return Future.error('Location permissions are denied');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      // Permissions are denied forever, handle appropriately.
      return Future.error(
          'Location permissions are permanently denied, we cannot request permissions.');
    }

    // When we reach here, permissions are granted and we can
    // continue accessing the position of the device.
    return await Geolocator.getCurrentPosition();
  }
}
