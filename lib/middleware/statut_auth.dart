import 'package:flutter/material.dart';
import 'package:ceramicpay/views/forms/login.dart';
import 'package:ceramicpay/views/forms/register.dart';
import 'package:ceramicpay/views/pages/home.dart';
import 'package:ceramicpay/models/user_model.dart';

class StatutAuth extends StatefulWidget {
  @override
  _StatutAuthState createState() => _StatutAuthState();
}

class _StatutAuthState extends State<StatutAuth> {
  bool visible = true;
  bool login = false;

  isConnected() async {
    var User = await UserModel.getUser();

    if (UserModel.sessionUser == null) {
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
