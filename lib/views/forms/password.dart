// import 'package:flutter/material.dart';

// class Home extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text("Home"),
//       ),
//     );
//   }
// }

import 'dart:convert';

import 'package:scspay/api/api.dart';
import 'package:scspay/const/constants.dart';
import 'package:scspay/crypt/encrypt.dart';
import 'package:scspay/widgets/loading.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:scspay/const/routes.dart';
import 'package:scspay/const/loading.dart';
import 'package:scspay/models/user_model.dart';
import 'package:http/http.dart' as http;

class PasswordScreen extends StatefulWidget {
  // final Function visible, login;
  // LoginScreen(this.visible, this.login);
  @override
  State<StatefulWidget> createState() {
    return PasswordScreenState();
  }
}

class PasswordScreenState extends State<PasswordScreen> {
  TextEditingController _town = TextEditingController();
  TextEditingController _password = TextEditingController();
  TextEditingController _cpassword = TextEditingController();
  // int _phoneNumber;
  var phone;
  String? ville;

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  var id;
  String error = "";
  bool isLoggin = false;

  getUserData() async {
    var user = await UserModel.getCurrentUserData();
    setState(
      () {
        id = user.id;
        phone = user.phone;
        UserModel.logOut();
        // ville = user.ville;
        print(phone);
      },
    );
  }

  void resetPassword(String phone, String ville, String password) async {
    try {
      setState(() {
        isLoggin = true;
      });
      final response = await http.post(
          Uri.parse(Url.ApiLink + "/setPassword.php"),
          body: {"phone": phone, "ville": ville, "pass": password});
      print(response.body);
      if (response.statusCode == 200) {
        try {
          var data = jsonDecode(response.body);
          var result = data['data'];
          int succes = result[1];

          if (succes == 1) {
            setState(() {
              error = result[0];
              isLoggin = false;
              print(result[2]);
              UserModel.saveUser(UserModel.fromJson(result[2]));
              // widget.login.call();
              Routes.HomeNavigator(context);
              // _loading = false;
            });
            // setState(() {
            //   error = "Connexion etabli";
            // });
          } else {
            setState(() {
              error = result[0];
              isLoggin = false;
              // print(error);
              // _loading = false;
            });
            // print(error);
          }
          // var decodedJSON = json.decode(response.body);
          // decodeSucceeded = true;
        } on FormatException catch (e) {
          print('erreur: $e');
          setState(() {
            error = "Ville incorrecte reessayer svp";
          });
          // error = "erreur";
          print('The provided string is not valid JSON');
        }
      } else {
        error = "Erreur de serveur reessayez svp";
      }
    } catch (e) {
      error = "Veuillez verifier votre connexion internet";
    }
    setState(() {
      isLoggin = false;
    });
  }

  // Initially password is obscure
  bool obscureText = true;

  // Toggles the password show status
  void _toggle() {
    setState(() {
      obscureText = !obscureText;
    });
  }

  Widget _buildVille() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12.0),
      child: Container(
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
          color: Colors.grey[600]!.withOpacity(0.5),
          borderRadius: BorderRadius.circular(16),
        ),
        child: TextFormField(
          decoration: InputDecoration(
            contentPadding: const EdgeInsets.symmetric(vertical: 20),
            border: InputBorder.none,
            hintText: 'Ville de naissance',
            prefixIcon: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Icon(
                FontAwesomeIcons.mapMarkerAlt,
                color: Colors.white,
                size: 25,
              ),
            ),
          ),
          validator: (String? value) {
            if (value!.isEmpty) {
              return 'La ville est requise';
            }

            return null;
          },
          controller: _town,
        ),
      ),
    );
  }

  Widget _buildPassword() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12.0),
      child: Container(
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
          color: Colors.grey[600]!.withOpacity(0.5),
          borderRadius: BorderRadius.circular(16),
        ),
        child: TextFormField(
          // maxLength: 15,
          decoration: InputDecoration(
            contentPadding: const EdgeInsets.symmetric(vertical: 20),
            border: InputBorder.none,
            hintText: "Mot de passe",
            prefixIcon: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Icon(
                FontAwesomeIcons.userLock,
                color: Colors.white,
                size: 25,
              ),
            ),
          ),

          keyboardType: TextInputType.visiblePassword,
          validator: (String? value) {
            if (value!.isEmpty) {
              return "Le champs mdp est requis";
            } else if (value.length < 6) {
              return "Le mot de passe doit comporter au moins 6 caractères";
            }

            return null;
          },
          controller: _password,
          obscureText: obscureText,
        ),
      ),
    );
  }

  Widget _buildCPassword() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12.0),
      child: Container(
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
          color: Colors.grey[600]!.withOpacity(0.5),
          borderRadius: BorderRadius.circular(16),
        ),
        child: TextFormField(
          decoration: InputDecoration(
            contentPadding: const EdgeInsets.symmetric(vertical: 20),
            border: InputBorder.none,
            hintText: "Confirmer le mdp",
            prefixIcon: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Icon(
                FontAwesomeIcons.lock,
                color: Colors.white,
                size: 25,
              ),
            ),
          ),
          keyboardType: TextInputType.visiblePassword,
          validator: (String? value) {
            if (value!.isEmpty) return 'Veuillez confirmer votre mdp';
            if (value != _password.text) return "Veuillez verifier votre mdp";
            return null;
          },
          controller: _cpassword,
          obscureText: obscureText,
        ),
      ),
    );
  }

  void getUserInfo() async {
    var user = await UserModel.getCurrentUserData();
    if (user != null) {
      setState(() {
        phone = user.phone;
        ville = user.ville;
        print(phone);
      });
    } else {
      setState(() {
        phone = " ";
      });
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // getUserInfo();
    getUserData();
  }

  @override
  Widget build(BuildContext context) {
    // getUserInfo();
    return Stack(
      children: [
        Scaffold(
          backgroundColor: Colors.white,
          body: SingleChildScrollView(
            child: SafeArea(
              child: Column(
                children: [
                  Container(
                    width: MediaQuery.of(context).size.width,
                    height: 150,
                    child: Center(
                      child: Text(
                        "Reinitialiser le mdp",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 25.0,
                          fontWeight: FontWeight.w900,
                          fontFamily: 'Montserrat',
                          color: kbrown,
                        ),
                      ),
                    ),
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width,
                    margin: EdgeInsets.fromLTRB(30, 0, 30, 0),
                    child: Text(
                      "Saisissez un nouveau mdp pour reinitialiser votre mdp et acceder a votre compte",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 20.0,
                        fontWeight: FontWeight.w500,
                        fontFamily: 'Montserrat',
                        color: kbrown,
                      ),
                    ),
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width,
                    margin: EdgeInsets.all(24),
                    child: Form(
                      key: _formKey,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          _buildVille(),
                          _buildPassword(),
                          _buildCPassword(),
                          Column(
                            children: [
                              SizedBox(
                                height: 30,
                              ),
                              InkWell(
                                onTap: () {
                                  if (_formKey.currentState!.validate()) {
                                    // loading(context);
                                    // setState(() {
                                    //   isLoggin = true;
                                    // });
                                    resetPassword(this.phone, this._town.text,
                                        this._password.text);
                                    // setState(() {
                                    //   isLoggin = false;
                                    // });

                                  }
                                },
                                child: Container(
                                    padding: EdgeInsets.symmetric(
                                        horizontal: 30.0, vertical: 10),
                                    decoration: BoxDecoration(
                                        color: kblue,
                                        borderRadius:
                                            BorderRadius.circular(15.0)),
                                    child: isLoggin == false
                                        ? Row(
                                            mainAxisSize: MainAxisSize.min,
                                            children: [
                                              Text(
                                                "REINITIALISER",
                                                style: TextStyle(
                                                    fontSize: 16.0,
                                                    color: kwhite),
                                              ),
                                              SizedBox(
                                                width: 15.0,
                                              ),
                                              Icon(
                                                FontAwesomeIcons.lock,
                                                color: kwhite,
                                              )
                                            ],
                                          )
                                        : Row(
                                            mainAxisSize: MainAxisSize.min,
                                            children: [
                                                Text(
                                                  "VEUILLEZ PATIENTER",
                                                  style: TextStyle(
                                                      fontSize: 16.0,
                                                      color: kwhite),
                                                ),
                                                SizedBox(
                                                  width: 15.0,
                                                ),
                                                CircularProgressIndicator(
                                                  backgroundColor: kbrown,
                                                ),
                                              ])),
                              ),
                              SizedBox(
                                height: 50,
                              ),
                              Container(
                                width: MediaQuery.of(context).size.width,
                                alignment: Alignment.center,
                                decoration: BoxDecoration(
                                  border: Border(
                                    bottom: BorderSide(
                                        color: Colors.white, width: 1),
                                  ),
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 9.5),
                                  child: Column(
                                    children: [
                                      Text(
                                        "Vous voulez annuler ?",
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                          fontSize: 15.0,
                                          fontFamily: 'Poppins',
                                          color: kblack,
                                        ),
                                      ),
                                      TextButton(
                                        child: Text(
                                          "Annuler",
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                            fontSize: 15.0,
                                            fontFamily: 'Poppins',
                                            color: kblue,
                                          ),
                                        ),
                                        onPressed: () =>
                                            Routes.LoginNavigator(context),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              Text(
                                error,
                                style: TextStyle(color: Colors.red),
                              ),
                              SizedBox(
                                height: 5,
                              ),
                            ],
                          )
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
