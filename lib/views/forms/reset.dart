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
import 'package:scspay/models/user_model.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:scspay/const/loading.dart';
import 'package:scspay/const/routes.dart';
import 'package:http/http.dart' as http;

class ResetScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return ResetScreenState();
  }
}

class ResetScreenState extends State<ResetScreen> {
  int? _phoneNumber;

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  String error = "";
  bool isLoggin = false;

  void getPhone(int phone) async {
    try {
      setState(() {
        isLoggin = true;
      });
      final response = await http.post(Uri.parse(Url.ApiLink + "/getPhone.php"),
          body: {"phone": phone.toString()});
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
              Routes.PasswordNavigator(context);
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
            error = "Telephone ou mot de passe incorrect";
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

  Widget _buildPhoneNumber() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12.0),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.grey[600]!.withOpacity(0.5),
          borderRadius: BorderRadius.circular(16),
        ),
        child: TextFormField(
          decoration: InputDecoration(
            contentPadding: const EdgeInsets.symmetric(vertical: 20),
            border: InputBorder.none,
            hintText: "Telephone",
            prefixIcon: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Icon(
                FontAwesomeIcons.phoneAlt,
                color: Colors.white,
                size: 25,
              ),
            ),
          ),
          keyboardType: TextInputType.number,
          validator: (String? value) {
            if (value!.isEmpty) {
              return 'Le telephone est requis';
            }

            return null;
          },
          onChanged: (value) => _phoneNumber = int.parse(value),
        ),
      ),
    );
  }

  // Initially password is obscure
  bool obscureText = true;

  // Toggles the password show status
  void _toggle() {
    setState(() {
      obscureText = !obscureText;
    });
  }

  // AuthService auth = AuthService();
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Scaffold(
          backgroundColor: Colors.white,
          body: SingleChildScrollView(
            child: SafeArea(
              child: Column(
                children: [
                  Container(
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
                      "Saisissez votre numero de telephone pour reinitialiser votre mdp et acceder a votre compte",
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
                    margin: EdgeInsets.all(24),
                    child: Form(
                      key: _formKey,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          _buildPhoneNumber(),
                          Column(
                            children: [
                              SizedBox(
                                height: 30,
                              ),
                              InkWell(
                                onTap: () {
                                  if (_formKey.currentState!.validate()) {
                                    getPhone(_phoneNumber!);
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
                                                FontAwesomeIcons.user,
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
                                        "Vous n'avez pas de compte ?",
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                          fontSize: 15.0,
                                          fontFamily: 'Poppins',
                                          color: kblack,
                                        ),
                                      ),
                                      TextButton(
                                          child: Text(
                                            "S'inscrire",
                                            textAlign: TextAlign.center,
                                            style: TextStyle(
                                              fontSize: 15.0,
                                              fontFamily: 'Poppins',
                                              color: kblue,
                                            ),
                                          ),
                                          onPressed: () =>
                                              Routes.RegisterNavigator(
                                                  context)),
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
