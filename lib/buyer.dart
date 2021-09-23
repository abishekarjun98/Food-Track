//@dart=2.9
import 'package:flutter/material.dart';
import 'main.dart';

void main() {
  runApp(Buyer());
}

class Buyer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        home: Scaffold(body: App(type: "buyers")));
  }
}
