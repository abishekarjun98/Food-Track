//@dart=2.9
import 'dart:convert';

import 'package:barcode_scan/barcode_scan.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:food_track/api/api_manager.dart';
import 'package:food_track/models/inventory_response.dart';
import 'package:food_track/models/result_response.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io' as Io;

class Inventory extends StatefulWidget {
  @override
  _InventoryState createState() => _InventoryState();
}

class _InventoryState extends State<Inventory> {
  Future<ResultResponse<InventoryResponse, String>> _inventory;
  String barcode = "";
  int stage = 1;

  @override
  void initState() {
    super.initState();
    _inventory = ApiManager().getInventory();
  }

  void scanner() {
    switch (stage) {
      case 1:
        barcodeScanning();
        break;
      case 2:
        foodpicCapturing();
        break;
      case 3:
        nutritionScanning();
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
          onPressed: () {
            scanner();
          },
          child: Icon(Icons.add)),
      body: FutureBuilder<ResultResponse<InventoryResponse, String>>(
          future: _inventory,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              var foods = snapshot.data.response as InventoryResponse;
              print(snapshot.data.message);
              if (foods.message == "success") {
                return ListView.builder(
                    itemCount: foods.response.length,
                    itemBuilder: (context, index) {
                      return Card(
                        child: Row(
                          children: [
                            Flexible(
                                flex: 1,
                                child: Image.network(
                                    foods.response.elementAt(index).imageUrl)),
                            Flexible(
                                flex: 2,
                                child: Column(
                                  children: [
                                    Text(foods.response.elementAt(index).name),
                                    Text(foods.response
                                        .elementAt(index)
                                        .quantity)
                                  ],
                                ))
                          ],
                        ),
                      );
                    });
              } else
                return Text("Error");
            }
            return CircularProgressIndicator();
          }),
    );
  }

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

  void foodpicCapturing() {}

  Future<void> nutritionScanning() async {
    final imagefile = await ImagePicker().pickImage(
        source: ImageSource.gallery, preferredCameraDevice: CameraDevice.rear);
    var bytes = Io.File(imagefile.path.toString()).readAsBytesSync();
    String img64 = await base64Encode(bytes);
    ApiManager().textRecognition(img64);
  }
}
