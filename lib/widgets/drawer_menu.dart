import 'package:ceramicpay/api/api.dart';
import 'package:ceramicpay/models/qrCode_model.dart';
import 'dart:convert';

import 'package:ceramicpay/models/user_model.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:ceramicpay/const/constants.dart';
import 'package:ceramicpay/const/routes.dart';

class DrawerMenu extends StatefulWidget {
  @override
  _DrawerMenuState createState() => _DrawerMenuState();
}

class _DrawerMenuState extends State<DrawerMenu> {
  // List<QrModel> qrList = [];
  bool isLoading = false;
  String error = "";
  void setScan(String qrCode) async {
    // setState(() {
    //   error = "";
    //   // _loading = true;
    // });
    var User = await UserModel.getCurrentUser();
    try {
      setState(() {
        isLoading = true;
      });
      final Response = await http
          .post(Url.setScan, body: {"qrCode": qrCode, "idUser": User});

      print(Response.body);
      if (Response.statusCode == 200) {
        var data = jsonDecode(Response.body);
        var result = data['data'];
        int succes = result[1];

        if (succes == 1) {
          setState(() {
            error = result[0];
            isLoading = false;
          });
        } else {
          setState(() {
            error = result[0];
            isLoading = false;
          });
        }
      } else {
        print(Response.statusCode);
      }
    } catch (e) {
      print('erreur: $e');
    }
    print(error);
    print(isLoading);
    setState(() {
      isLoading = false;
    });
  }

  getData(String localQrCode) async {
    var User = await UserModel.getCurrentUser();
    List data = await Api.scanQrCode();
    if (data != null) {
      // if (data.contains(localQrCode) && error == "Succes insert") {
      if (data.contains(localQrCode)) {
        setScan(localQrCode);
        if (isLoading == false) {
          if (error == "Succes insert") {
            showDialog<String>(
              context: context,
              builder: (BuildContext context) => AlertDialog(
                title: const Text('Enregistré avec success'),
                content: Text('$localQrCode'),
                actions: <Widget>[
                  TextButton(
                    onPressed: () => Navigator.pop(context, 'OK'),
                    child: const Text('OK'),
                  ),
                ],
              ),
            );
          } else if (error == "qr Code already exist") {
            showDialog<String>(
              context: context,
              builder: (BuildContext context) => AlertDialog(
                title: const Text('Desole code incorrect'),
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
          } else {
            showDialog<String>(
              context: context,
              builder: (BuildContext context) => Container(
                width: MediaQuery.of(context).size.width,
                margin:
                    const EdgeInsets.only(left: 30.0, right: 30.0, top: 180.0),
                alignment: Alignment.center,
                child: Center(
                  child: SizedBox(
                    child: CircularProgressIndicator(
                      backgroundColor: kbrown,
                    ),
                    height: 200.0,
                    width: 200.0,
                  ),
                ),
              ),
            );
          }
        } else {
          showDialog<String>(
            context: context,
            builder: (BuildContext context) => Container(
              width: MediaQuery.of(context).size.width,
              margin:
                  const EdgeInsets.only(left: 30.0, right: 30.0, top: 180.0),
              alignment: Alignment.center,
              child: Center(
                child: SizedBox(
                  child: CircularProgressIndicator(
                    backgroundColor: kbrown,
                  ),
                  height: 200.0,
                  width: 200.0,
                ),
              ),
            ),
          );
        }
      } else {
        showDialog<String>(
          context: context,
          builder: (BuildContext context) => AlertDialog(
            title: const Text('Desole code incorrect'),
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
  String qrCode = 'Unknown';
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          DrawerHeader(
            decoration: BoxDecoration(
              color: kbrown,
            ),
            child: Icon(
              FontAwesomeIcons.user,
              size: 70.0,
              color: kwhite,
            ),
          ),
          ListTile(
            title: Row(
              children: [
                Icon(FontAwesomeIcons.home),
                SizedBox(
                  width: 30.0,
                ),
                Text(
                  'Acceuil',
                  style: TextStyle(fontSize: 19.0),
                ),
              ],
            ),
            onTap: () {
              Routes.HomeNavigator(context);
            },
          ),
          Divider(),
          ListTile(
            title: Row(
              children: [
                Icon(FontAwesomeIcons.qrcode),
                SizedBox(
                  width: 30.0,
                ),
                Text(
                  'Scanner Code',
                  style: TextStyle(fontSize: 19.0),
                ),
              ],
            ),
            onTap: () => scanQRCode(),
          ),
          Divider(),
          ListTile(
            title: Row(
              children: [
                Icon(FontAwesomeIcons.stream),
                SizedBox(
                  width: 30.0,
                ),
                Text(
                  'Mes Codes',
                  style: TextStyle(fontSize: 19.0),
                ),
              ],
            ),
            onTap: () {
              Routes.CodesNavigator(context);
            },
          ),
          Divider(),
          ListTile(
            title: Row(
              children: [
                Icon(FontAwesomeIcons.userCog),
                SizedBox(
                  width: 30.0,
                ),
                Text(
                  'Mon Profil',
                  style: TextStyle(fontSize: 19.0),
                ),
              ],
            ),
            onTap: () {
              Routes.ProfileNavigator(context);
            },
          ),
          Divider(),
          ListTile(
            title: Row(
              children: [
                Icon(FontAwesomeIcons.cogs),
                SizedBox(
                  width: 30.0,
                ),
                Text(
                  'Parametres',
                  style: TextStyle(fontSize: 19.0),
                ),
              ],
            ),
            onTap: () {
              Routes.SettingsNavigator(context);
            },
          ),
          Divider(),
          ListTile(
            title: Row(
              children: [
                Icon(FontAwesomeIcons.solidEnvelope),
                SizedBox(
                  width: 30.0,
                ),
                Text(
                  'A Propos',
                  style: TextStyle(fontSize: 19.0),
                ),
              ],
            ),
            onTap: () {
              Routes.AboutNavigator(context);
            },
          ),
          Divider(),
          ListTile(
            title: Row(
              children: [
                Icon(FontAwesomeIcons.infoCircle),
                SizedBox(
                  width: 30.0,
                ),
                Text(
                  'Aide',
                  style: TextStyle(fontSize: 19.0),
                ),
              ],
            ),
            onTap: () {
              Routes.HelpNavigator(context);
            },
          ),
          Divider(),
          ListTile(
            title: Row(
              children: [
                Icon(FontAwesomeIcons.signOutAlt),
                SizedBox(
                  width: 30.0,
                ),
                Text(
                  'Deconnexion',
                  style: TextStyle(fontSize: 19.0),
                ),
              ],
            ),
            onTap: () {
              Routes.LoginNavigator(context);
              UserModel.logOut();
            },
          ),
          Padding(
            padding: const EdgeInsets.only(top: 70.0),
            child: Align(
              alignment: FractionalOffset.bottomCenter,
              child: Text(
                "Copyright 💡 Mael Toukap | 2021",
                style: TextStyle(
                  fontSize: 10.0,
                  fontWeight: FontWeight.w200,
                  fontFamily: 'Poppins',
                  color: kblack,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

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

      setScan(this.qrCode);
      getData(this.qrCode);
    } on PlatformException {
      qrCode = 'Plateforme non prise en charge';
    }
  }
}
