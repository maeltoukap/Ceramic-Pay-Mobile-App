import 'dart:convert';

import 'package:ceramicpay/api/api.dart';
import 'package:ceramicpay/const/constants.dart';
import 'package:ceramicpay/models/scan_model.dart';
import 'package:ceramicpay/models/userScan_model.dart';
import 'package:ceramicpay/models/user_model.dart';
import 'package:ceramicpay/models/qrCode_model.dart';
import 'package:ceramicpay/services/globals.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:ceramicpay/const/constants.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';

class Profile extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return ProfileState();
  }
}

class ProfileState extends State<Profile> {
  TextEditingController _password = TextEditingController();

  int _phoneNumber;

  var id;
  var name;
  var phone;
  var coupons = 0;
  var valider;
  var nonValider;
  var gagne = 0;
  bool isLoading = false;
  bool isLoad = false;
  void getUserInfo() async {
    var user = await UserModel.getCurrentUserData();
    setState(() {
      id = user.id;
      name = user.name;
      phone = user.phone;
    });
  }

  List<CouponModel> couponModel = [];
  getUserData() async {
    var user = await UserModel.getCurrentUserData();
    setState(() {
      id = user.id;
      isLoading = true;
    });
    var data = await Api.getCoupons(id);
    if (data != null) {
      couponModel.clear();
      for (Map i in data) {
        setState(() {
          couponModel.add(CouponModel.fromJson(i));
          isLoading = false;
        });
      }
    }
    print(couponModel);
    setState(() {
      isLoading = false;
    });
  }

  String error = "";
  void setPhone(int newPhone, var currentPhone) async {
    setState(() {
      error = "";
      // _loading = true;
      isLoad = true;
    });
    // DateTime now = new DateTime.now();
    // DateTime date = new DateTime(now.year, now.month, now.day);
    // var b = date.toString();
    // print(date.toString());
    // print(b.runtimeType);
    // date = date.toString();
    final response = await http.post(Uri.parse(Url.ApiLink + "/setPhone.php"),
        // "http://localhost/api/php/register.php"),
        body: {
          // "name": name,
          "currentPhone": currentPhone.toString(),
          "newPhone": newPhone.toString()
          // "pass": password,
          // "date": date.toString()
        });
    print(response.body);
    if (response.statusCode == 200) {
      try {
        var data = jsonDecode(response.body);
        var result = data['data'];
        int succes = result[1];

        if (succes == 1) {
          setState(() {
            error = result[0];
            isLoad = false;
            print(result[2]);
            UserModel.saveUser(UserModel.fromJson(result[2]));
          });
          showDialog<String>(
            context: context,
            builder: (BuildContext context) => AlertDialog(
              title: const Text(
                "Modifications enregistrées avec succes",
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 16.0),
              ),
              // title: const Text('Desole code incorrect'),
              content: Icon(
                FontAwesomeIcons.check,
                color: Colors.green,
                size: 40.0,
              ),
              actions: <Widget>[
                // TextButton(
                //   onPressed: () {
                //     Navigator.pop(context);
                //     scanQRCode();
                //   },
                //   child: const Text('Reessayer'),
                // ),
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
            builder: (BuildContext context) => AlertDialog(
              title: const Text(
                "Une erreur est survenu ressayer",
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 16.0),
              ),
              // title: const Text('Desole code incorrect'),
              content: Icon(
                FontAwesomeIcons.exclamationTriangle,
                color: Colors.red,
                size: 40.0,
              ),
              actions: <Widget>[
                // TextButton(
                //   onPressed: () {
                //     Navigator.pop(context);
                //     scanQRCode();
                //   },
                //   child: const Text('Reessayer'),
                // ),
                TextButton(
                  onPressed: () => Navigator.pop(context, 'OK'),
                  child: const Text('OK'),
                ),
              ],
            ),
          );
          setState(() {
            error = result[0];
            isLoad = false;
          });
        }
      } on FormatException catch (e) {
        print('erreur: $e');
        setState(() {
          showDialog<String>(
            context: context,
            builder: (BuildContext context) => AlertDialog(
              title: const Text(
                "Un compte a deja ete crée avec ce numero de telephone",
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 16.0),
              ),
              // title: const Text('Desole code incorrect'),
              content: Icon(
                FontAwesomeIcons.exclamationTriangle,
                color: Colors.red,
                size: 40.0,
              ),
              actions: <Widget>[
                // TextButton(
                //   onPressed: () {
                //     Navigator.pop(context);
                //     scanQRCode();
                //   },
                //   child: const Text('Reessayer'),
                // ),
                TextButton(
                  onPressed: () => Navigator.pop(context, 'OK'),
                  child: const Text('OK'),
                ),
              ],
            ),
          );
          // error = "Connexion internet instable veuillez reessayer";
        });
        print('The provided string is not valid JSON');
      }
    } else {
      showDialog<String>(
        context: context,
        builder: (BuildContext context) => AlertDialog(
          title: const Text(
            "Une erreur est survenu ressayer",
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 16.0),
          ),
          // title: const Text('Desole code incorrect'),
          content: Icon(
            FontAwesomeIcons.exclamationTriangle,
            color: Colors.red,
            size: 40.0,
          ),
          actions: <Widget>[
            // TextButton(
            //   onPressed: () {
            //     Navigator.pop(context);
            //     scanQRCode();
            //   },
            //   child: const Text('Reessayer'),
            // ),
            TextButton(
              onPressed: () => Navigator.pop(context, 'OK'),
              child: const Text('OK'),
            ),
          ],
        ),
      );
      // error = "Erreur de serveur reessayez svp";
    }
    setState(() {
      isLoad = false;
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getUserInfo();
    getUserData();
  }

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  Widget _buildPhoneNumber() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12.0),
      child: Container(
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
          color: Colors.grey[600].withOpacity(0.5),
          borderRadius: BorderRadius.circular(16),
        ),
        child: TextFormField(
          maxLength: 9,
          decoration: InputDecoration(
            contentPadding: const EdgeInsets.symmetric(vertical: 20),
            border: InputBorder.none,
            hintText: "Telephone",
            prefixIcon: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Icon(
                FontAwesomeIcons.phoneAlt,
                color: Colors.white,
                // size: 30,
                size: 25,
              ),
            ),
          ),
          keyboardType: TextInputType.number,
          validator: (String value) {
            if (value.isEmpty) {
              return 'Le telephone est requis';
            }

            return null;
          },
          onChanged: (value) => _phoneNumber = int.parse(value),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    getUserInfo();
    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        title: Text(
          "Profil",
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
      body: isLoading == false
          ? SingleChildScrollView(
              child: SafeArea(
                child: Column(
                  children: [
                    Container(
                      width: MediaQuery.of(context).size.width,
                      decoration: BoxDecoration(
                        color: kbrown,
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.5),
                            spreadRadius: 5,
                            blurRadius: 7,
                            offset: Offset(0, 3), // changes position of shadow
                          ),
                        ],
                      ),
                      child: Padding(
                        padding: const EdgeInsets.only(bottom: 70),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(
                              height: 7.0,
                            ),
                            Center(
                              child: CircleAvatar(
                                radius: 55.0,
                                backgroundColor: kgrey,
                                child: Icon(
                                  FontAwesomeIcons.user,
                                  size: 70.0,
                                  color: kbrown,
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 9.0,
                            ),
                            Center(
                              child: Column(
                                children: [
                                  Text(
                                    "$name",
                                    style: TextStyle(
                                      fontSize: 20.0,
                                      fontWeight: FontWeight.w900,
                                      fontFamily: 'Montserrat',
                                      color: kwhite,
                                    ),
                                  ),
                                  SizedBox(
                                    height: 9.0,
                                  ),
                                  Text(
                                    "$phone",
                                    style: TextStyle(
                                      fontSize: 20.0,
                                      fontWeight: FontWeight.w500,
                                      fontFamily: 'Montserrat',
                                      color: kwhite,
                                    ),
                                  ),
                                  SizedBox(
                                    height: 35.0,
                                  ),
                                  Container(
                                    height: MediaQuery.of(context).size.height /
                                        24.5,
                                    child: ListView.builder(
                                      itemCount: couponModel.length,
                                      itemBuilder: (context, i) {
                                        final coupon = couponModel[i];

                                        coupons = couponModel.length;

                                        gagne = coupons * 300;

                                        return Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceAround,
                                          children: [
                                            Column(
                                              children: [
                                                Text(
                                                  "Coupons",
                                                  style: TextStyle(
                                                    fontSize: 14.0,
                                                    fontWeight: FontWeight.w200,
                                                    fontFamily: 'Montserrat',
                                                    color: kwhite,
                                                  ),
                                                ),
                                                Text(
                                                  "$coupons",
                                                  // coupon.idScan,
                                                  style: TextStyle(
                                                    fontSize: 14.0,
                                                    fontWeight: FontWeight.w200,
                                                    fontFamily: 'Montserrat',
                                                    color: kwhite,
                                                  ),
                                                ),
                                              ],
                                            ),
                                            Column(
                                              children: [
                                                Text(
                                                  "Gains",
                                                  style: TextStyle(
                                                    fontSize: 14.0,
                                                    fontWeight: FontWeight.w200,
                                                    fontFamily: 'Montserrat',
                                                    color: kwhite,
                                                  ),
                                                ),
                                                Text(
                                                  "$gagne",
                                                  style: TextStyle(
                                                    fontSize: 14.0,
                                                    fontWeight: FontWeight.w200,
                                                    fontFamily: 'Montserrat',
                                                    color: kwhite,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ],
                                        );
                                      },
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Center(
                      child: Container(
                        padding: EdgeInsets.only(top: 20),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                              vertical: 20, horizontal: 30),
                          child: Text(
                            "Modifier votre numero de telephone",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 20.0,
                              fontWeight: FontWeight.bold,
                              fontFamily: 'Montserrat',
                              color: kblack,
                            ),
                          ),
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
                            _buildPhoneNumber(),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 30,
                    ),
                    InkWell(
                      onTap: () {
                        if (_formKey.currentState.validate()) {
                          setPhone(this._phoneNumber, this.phone);
                        }
                      },
                      child: Container(
                          padding: EdgeInsets.symmetric(
                              horizontal: 30.0, vertical: 10),
                          decoration: BoxDecoration(
                              color: kbrown,
                              borderRadius: BorderRadius.circular(15.0)),
                          child: isLoad == false
                              ? Row(mainAxisSize: MainAxisSize.min, children: [
                                  Text(
                                    "MODFIER",
                                    style: TextStyle(
                                        fontSize: 16.0, color: kwhite),
                                  ),
                                  SizedBox(
                                    width: 15.0,
                                  ),
                                  Icon(
                                    FontAwesomeIcons.user,
                                    color: kwhite,
                                  )
                                ])
                              : Row(mainAxisSize: MainAxisSize.min, children: [
                                  Text(
                                    "VEUILLEZ PATIENTER",
                                    style: TextStyle(
                                        fontSize: 16.0, color: kwhite),
                                  ),
                                  SizedBox(
                                    width: 15.0,
                                  ),
                                  CircularProgressIndicator(
                                    backgroundColor: kbrown,
                                  ),
                                ])),
                    ),
                  ],
                ),
              ),
            )
          : Container(
              width: MediaQuery.of(context).size.width,
              margin:
                  const EdgeInsets.only(left: 30.0, right: 30.0, top: 150.0),
              alignment: Alignment.center,
              child: Center(
                child: Column(
                  children: [
                    SizedBox(
                      child: CircularProgressIndicator(
                        backgroundColor: kbrown,
                      ),
                      height: 200.0,
                      width: 200.0,
                    ),
                    SizedBox(
                      height: 50.0,
                    ),
                    Text(
                      "Veuillez patienter svp...",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 18.0,
                        fontFamily: 'Poppins',
                        color: kblack,
                      ),
                    ),
                    Text(
                      error,
                      style: TextStyle(color: Colors.red),
                    ),
                  ],
                ),
              ),
            ),
    );
  }
}
