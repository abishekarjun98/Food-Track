import 'package:barcode_scan/barcode_scan.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class AddInventory extends StatefulWidget {
  @override
  _AddInventoryState createState() => _AddInventoryState();
}

class _AddInventoryState extends State<AddInventory> {
  String barcode = "";

  @override
  initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
      child: Column(
        children: <Widget>[
          Container(
            child: ElevatedButton(
              onPressed: barcodeScanning,
              child: Text(
                "Capture Image",
                style: TextStyle(fontSize: 20, color: Colors.white),
              ),
            ),
            padding: const EdgeInsets.all(10.0),
            margin: EdgeInsets.all(10),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
          ),
          Text(
            "Scanned Barcode Number",
            style: TextStyle(fontSize: 20),
          ),
          Text(
            barcode,
            style: TextStyle(fontSize: 25, color: Colors.green),
          ),
        ],
      ),
    ));
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
