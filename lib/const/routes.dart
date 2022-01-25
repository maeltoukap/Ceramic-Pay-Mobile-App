import 'package:ceramicpay/views/forms/password.dart';
import 'package:ceramicpay/views/forms/register.dart';
import 'package:ceramicpay/views/forms/login.dart';
import 'package:ceramicpay/views/forms/reset.dart';
import 'package:ceramicpay/views/pages/home.dart';
import 'package:ceramicpay/views/pages/codes.dart';
import 'package:ceramicpay/views/pages/about.dart';
import 'package:ceramicpay/views/pages/qr_scan.dart';
import 'package:ceramicpay/views/pages/settings.dart';
import 'package:ceramicpay/views/pages/help.dart';
import 'package:ceramicpay/views/pages/profile.dart';
import 'package:flutter/material.dart';

class Routes {
  static void RegisterNavigator(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (BuildContext context) {
          return RegisterScreen();
        },
      ),
    );
  }

  static void LoginNavigator(BuildContext context) {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (BuildContext context) {
          return LoginScreen();
        },
      ),
    );
  }

  static void ResetNavigator(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (BuildContext context) {
          return ResetScreen();
        },
      ),
    );
  }

  static void HomeNavigator(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (BuildContext context) {
          // return inscPAge();
          return Home();
        },
      ),
    );
  }

  static void CodesNavigator(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (BuildContext context) {
          // return inscPAge();
          return Codes();
        },
      ),
    );
  }

  static void AboutNavigator(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (BuildContext context) {
          // return inscPAge();
          return AboutUs();
        },
      ),
    );
  }

  static void QrScanNavigator(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (BuildContext context) {
          // return inscPAge();
          return QRScanPage();
        },
      ),
    );
  }

  static void SettingsNavigator(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (BuildContext context) {
          // return inscPAge();
          return Settings();
        },
      ),
    );
  }

  static void HelpNavigator(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (BuildContext context) {
          // return inscPAge();
          return Help();
        },
      ),
    );
  }

  static void ProfileNavigator(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (BuildContext context) {
          // return inscPAge();
          return Profile();
        },
      ),
    );
  }

  static void PasswordNavigator(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (BuildContext context) {
          // return inscPAge();
          return PasswordScreen();
        },
      ),
    );
  }
}
