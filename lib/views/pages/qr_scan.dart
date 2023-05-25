import 'package:scspay/api/api.dart';
import 'package:scspay/const/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:scspay/const/routes.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class QRScanPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _QRScanPageState();
}

class _QRScanPageState extends State<QRScanPage> {
  String qrCode = 'Unknown';
  getData(String localQrCode) async {
    List data = await Api.scanQrCode();
    if (data != null) {
      if (data.contains(localQrCode)) {
        showDialog<String>(
          context: context,
          builder: (BuildContext context) => AlertDialog(
            title: const Text('Felicitation vous avez gagné '),
            content: Text('$localQrCode'),
            actions: <Widget>[
              TextButton(
                onPressed: () => Navigator.pop(context, 'OK'),
                child: const Text('OK'),
              ),
            ],
          ),
        );
      } else if (this.qrCode != "2911de3d4a559c3b27bdaea12021") {
        showDialog<String>(
          context: context,
          builder: (BuildContext context) => AlertDialog(
            title: const Text('Desole qr code incorrect'),
            content: qrCode == "-1" ? Text('') : Text('$localQrCode'),
            actions: <Widget>[
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                  scanQRCode();
                },
                child: const Text('Reessayer'),
              ),
              TextButton(
                onPressed: () => Navigator.pop(context, 'OK'),
                child: const Text('OK'),
              ),
            ],
          ),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) => Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            SizedBox(height: 40),
            InkWell(
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 30.0, vertical: 10),
                decoration: BoxDecoration(
                    color: kbrown, borderRadius: BorderRadius.circular(15.0)),
                child: Row(mainAxisSize: MainAxisSize.min, children: [
                  Text(
                    "Scanner le QR-Code",
                    style: TextStyle(fontSize: 16.0, color: kwhite),
                  ),
                  SizedBox(
                    width: 15.0,
                  ),
                  Icon(
                    FontAwesomeIcons.qrcode,
                    color: kwhite,
                  )
                ]),
              ),
              onTap: () => scanQRCode(),
            ),
          ],
        ),
      );

  Future<void> scanQRCode() async {
    try {
      final qrCode = await FlutterBarcodeScanner.scanBarcode(
        '#ff6666',
        'Cancel',
        true,
        ScanMode.QR,
      );

      if (!mounted) return;

      setState(() {
        this.qrCode = qrCode;
      });

      getData(this.qrCode);
    } on PlatformException {
      qrCode = 'Failed to get platform version.';
    }
  }
}
