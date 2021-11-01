import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:foodla/Tools/encryption.dart';
import 'package:foodla/models/restaurant_model.dart';
import 'package:foodla/pages/Homepage/homepage.dart';
import 'package:foodla/pages/Restaurant/restaurant_detail.dart';
import 'package:provider/src/provider.dart';
// import 'package:qr_code_scanner/qr_code_scanner.dart';

class Scanner extends StatefulWidget {
  const Scanner({Key? key }) : super(key: key);

  @override
  _ScannerState createState() => _ScannerState();
}

class _ScannerState extends State<Scanner> {
  Timer timer = Timer.periodic(const Duration(milliseconds: 0), (_) {});
  AESEncryption encryption = AESEncryption();
  String? scanResult;

  @override
  void initState() {
    getQrData();
    super.initState();
  }

  @override
  void dispose() {
    timer.cancel();
    super.dispose();
  }

  getQrData() {
    scanCode();

    timer = Timer.periodic(const Duration(milliseconds: 100), (_) {
      if (scanResult != null) {
        var splitedData = scanResult!.split(' ');
        var decodedData =
            encryption.decryptData(encryption.getCode(splitedData[0]));
        context
            .read<RestaurantModel>()
            .getRestaurantId(decodedData, splitedData[1]);
        timer.cancel();
      }
    });
  }

  Future scanCode() async {
    String scanResult;
    try {
      scanResult = await FlutterBarcodeScanner.scanBarcode(
        '#495261',
        'Cancel',
        true,
        ScanMode.QR,
      );
      // ignore: nullable_type_in_catch_clause
    } on PlatformException {
      scanResult = 'failed';
    }
    if (!mounted) return;

    setState(() => this.scanResult = scanResult);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body:
            scanResult != null ? const RestaurantDetails() : const SizedBox());
  }

// Stack(
//         children: [
//           RawMaterialButton(
//             onPressed: () => scanCode(),
//             child: const Text('asdfafds'),
//           ),
//           Text(scanResult.toString())

//           // buildQrView(width),
//         ],
//       ),

  // Widget buildQrView(double width) {
  //   return QRView(
  //     key: qrKey,
  //     overlay: QrScannerOverlayShape(
  //         cutOutSize: width * 0.8,
  //         borderRadius: 15,
  //         borderWidth: 10,
  //         borderLength: 25),
  //     onQRViewCreated: (QRViewController controller) {
  //       setState(() => this.controller = controller);
  //     },
  //   );
  // }
}
