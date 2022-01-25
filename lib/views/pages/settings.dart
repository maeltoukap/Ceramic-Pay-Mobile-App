import 'package:ceramicpay/const/constants.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class Settings extends StatefulWidget {
  @override
  _SettingsState createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 10.0,
        title: Text(
          "Parametres",
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 20.0,
            fontWeight: FontWeight.w200,
            fontFamily: 'Poppins',
            color: kwhite,
          ),
        ),
        backgroundColor: kbrown,
      ),
      body: Container(
        margin: EdgeInsets.fromLTRB(10, 10, 10, 320),
        padding: EdgeInsets.fromLTRB(15, 25, 15, 0),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10.0),
          color: kwhite,
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.5),
              spreadRadius: 5,
              blurRadius: 7,
              offset: Offset(0, 3), // changes position of shadow
            ),
          ],
        ),
        child: Column(
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Icon(FontAwesomeIcons.moon),
                Text(
                  "Activer le mode sombre",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 20.0,
                    fontWeight: FontWeight.w900,
                    fontFamily: 'Montserrat',
                    color: kblack,
                  ),
                ),
                SizedBox(
                  width: 20.0,
                ),
                Icon(
                  FontAwesomeIcons.toggleOn,
                  size: 30.0,
                ),
              ],
            ),
            Divider(
              height: 35,
              thickness: 1,
              indent: 2,
              endIndent: 2,
              color: kgrey,
            ),
            SizedBox(
              height: 20.0,
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Icon(FontAwesomeIcons.lock),
                Text(
                  "Changer le mot de passe",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 20.0,
                    fontWeight: FontWeight.w900,
                    fontFamily: 'Montserrat',
                    color: kblack,
                  ),
                ),
                SizedBox(
                  width: 20.0,
                ),
                Icon(
                  FontAwesomeIcons.chevronRight,
                  size: 30.0,
                ),
              ],
            ),
            Divider(
              height: 35,
              thickness: 1,
              indent: 2,
              endIndent: 2,
              color: kgrey,
            ),
            SizedBox(
              height: 20.0,
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Icon(FontAwesomeIcons.language),
                Text(
                  "Changer la langue",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 20.0,
                    fontWeight: FontWeight.w900,
                    fontFamily: 'Montserrat',
                    color: kblack,
                  ),
                ),
                SizedBox(
                  width: 20.0,
                ),
                Icon(
                  FontAwesomeIcons.chevronRight,
                  size: 30.0,
                ),
              ],
            ),
            Divider(
              height: 35,
              thickness: 1,
              indent: 2,
              endIndent: 2,
              color: kgrey,
            ),
            SizedBox(
              height: 20.0,
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Icon(FontAwesomeIcons.mapMarkerAlt),
                Text(
                  "Changer de position",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 20.0,
                    fontWeight: FontWeight.w900,
                    fontFamily: 'Montserrat',
                    color: kblack,
                  ),
                ),
                SizedBox(
                  width: 20.0,
                ),
                Icon(
                  FontAwesomeIcons.chevronRight,
                  size: 30.0,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
