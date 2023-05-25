import 'package:scspay/const/constants.dart';
import 'package:flutter/material.dart';
import 'package:scspay/widgets/drawer_menu.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class AppBarWidget extends StatelessWidget {
  String? title;

  AppBarWidget({
    @required this.title,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Text(
        title!,
        textAlign: TextAlign.center,
        style: TextStyle(
          fontSize: 20.0,
          fontWeight: FontWeight.w200,
          fontFamily: 'Poppins',
          color: kwhite,
        ),
      ),
      backgroundColor: kbrown,
    );
  }
}
