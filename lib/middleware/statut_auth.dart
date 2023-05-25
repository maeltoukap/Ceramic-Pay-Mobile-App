import 'package:flutter/material.dart';
import 'package:scspay/views/forms/login.dart';
import 'package:scspay/views/forms/register.dart';
import 'package:scspay/views/pages/home.dart';
import 'package:scspay/models/user_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class StatutAuth extends StatefulWidget {
  @override
  _StatutAuthState createState() => _StatutAuthState();
}

class _StatutAuthState extends State<StatutAuth> {
  bool visible = true;
  bool login = false;

  isConnected() async {
    var User = UserModel.getUser();
    SharedPreferences pref = await SharedPreferences.getInstance();
    bool? isLogin = pref.getBool("isLogin");

    // if (UserModel.sessionUser == null) {
    if (isLogin != null && isLogin) {
      setState(() {
        login = false;
      });
    } else {
      // print(User['name']);
      setState(() {
        login = true;
      });
    }
  }

  toggle() {
    setState(() {
      visible = !visible;
    });
  }

  isLoggin() {
    setState(() {
      login = !login;
    });
  }

  @override
  void initState() {
    isConnected();
  }

  Widget build(BuildContext context) {
    return login
        ? Home()
        : visible
            ? LoginScreen()
            : RegisterScreen();
  }
}
