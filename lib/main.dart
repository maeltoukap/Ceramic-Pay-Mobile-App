import 'package:ceramicpay/views/forms/login.dart';
import 'package:ceramicpay/views/forms/register.dart';
import 'package:ceramicpay/views/onboard/onboard.dart';
import 'package:ceramicpay/views/pages/home.dart';
import 'package:ceramicpay/middleware/statut_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';

int isviewed;
void main() async {
  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
    statusBarColor: Colors.transparent,
  ));
  WidgetsFlutterBinding.ensureInitialized();
  SharedPreferences prefs = await SharedPreferences.getInstance();
  isviewed = prefs.getInt('onBoard');
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Ceramic Services',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      // home: isviewed != 0 ? OnBoard() : RegisterScreen(),
      home: isviewed != 0 ? OnBoard() : StatutAuth(),
      // home: isviewed != 0 ? OnBoard() : LoginScreen(), //good syntax
      // home: isviewed != 0 ? OnBoard() : Home(),
    );
  }
}
