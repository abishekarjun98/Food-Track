//@dart=2.9
import 'package:flutter/material.dart';
import 'package:here_sdk/core.dart';
import 'main.dart';

void main() {
  SdkContext.init(IsolateOrigin.main);
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
