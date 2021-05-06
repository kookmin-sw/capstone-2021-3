import 'dart:async';
import 'package:flutter/services.dart';
import 'package:flutter/material.dart';
import 'package:barcode_widget/barcode_widget.dart';
import 'package:barcode_scan/barcode_scan.dart';

class QRPage extends StatefulWidget {
  QRPage();
  @override
  _QRPage createState() => _QRPage();
}

class _QRPage extends State<QRPage> {
  String result = "press the camera to start the scan !";

  Future scanQR() async {
    try {
      ScanResult qrScanResult = await BarcodeScanner.scan();
      result = qrScanResult.rawContent;
    } on PlatformException catch (ex) {
      if (ex.code == BarcodeScanner.cameraAccessDenied) {
        result = "Camera was denied";
      } else {
        result = "Unknown Error $ex";
      }
    } on FormatException {
      result = "You pressed the back button before scanning anything";
    } catch (ex) {
      result = "Unknown Error $ex";
    }
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          children: [
            Text(result),
            Container(
              color: Colors.white,
              padding: EdgeInsets.all(16),
              child: BarcodeWidget(
                barcode: Barcode.code128(),
                data: "11111111" ?? "None of",
                width: 200,
                height: 200,
                // drawText: false,
              ),
            )
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        icon: Icon(Icons.camera_alt),
        label: Text("Scan"),
        onPressed: scanQR,
      ),
    );
  }
}
