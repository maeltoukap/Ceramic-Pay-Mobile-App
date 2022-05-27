import 'dart:convert';

import 'package:ceramicpay/api/api.dart';
import 'package:ceramicpay/const/constants.dart';
import 'package:ceramicpay/models/userScan_model.dart';
import 'package:ceramicpay/models/user_model.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';
import 'package:http/http.dart' as http;

class Archives extends StatefulWidget {
  const Archives({Key key}) : super(key: key);

  @override
  _ArchivesState createState() => _ArchivesState();
}

class _ArchivesState extends State<Archives> {
  var id;
  var coupons;
  var valider;
  var date;
  var gagne;
  var price = 0;
  bool isLoading = false;
  bool isNull = false;
  bool isLoad = false;
  void getUserInfo() async {
    var user = await UserModel.getCurrentUserData();
    setState(() {
      id = user.id;
    });
  }

  List<ListScanModel> listScanModel = [];
  getUserData() async {
    setState(() {
      isLoading = true;
    });
    var user = await UserModel.getCurrentUserData();
    setState(() {
      id = user.id;
    });
    var data = await Api.listArchives(id);
    if (data != null) {
      listScanModel.clear();
      for (Map i in data) {
        setState(() {
          listScanModel.add(ListScanModel.fromJson(i));
          isLoading = false;
        });
      }
    }
    setState(() {
      isLoading = false;
    });
    print(listScanModel);
  }

  String error = "";
  void setArchiveToLoad(var idUser) async {
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
    final response =
        await http.post(Uri.parse(Url.ApiLink + "/setArchiveToLoad.php"),
            // "http://localhost/api/php/register.php"),
            body: {
          // "name": name,
          "idUser": idUser
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
        } else {
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
                "Connexion internet instable",
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

  @override
  Widget build(BuildContext context) {
    getUserInfo();
    return Scaffold(
      // backgroundColor: bgColor,
      appBar: AppBar(
        elevation: 10.0,
        title: Text(
          "Mes Archives",
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 20.0,
            fontWeight: FontWeight.w200,
            fontFamily: 'Poppins',
            color: kwhite,
          ),
        ),
        backgroundColor: kbrown,
        actions: [],
      ),
      body: isLoading == false
          ? Column(
              children: [
                SingleChildScrollView(
                  child: SafeArea(
                    child: Column(
                      children: [
                        // Padding(
                        //   padding: const EdgeInsets.only(top: 2.0, bottom: 4.0),
                        //   child: Row(
                        //     mainAxisAlignment: MainAxisAlignment.spaceAround,
                        //     children: [
                        //       Text(
                        //         "Gains",
                        //         style: TextStyle(
                        //           fontSize: 18.0,
                        //           fontWeight: FontWeight.w900,
                        //           fontFamily: 'Montserrat',
                        //           color: kblack,
                        //         ),
                        //       ),
                        //       Text(
                        //         "120 FCFA",
                        //         style: TextStyle(
                        //           fontSize: 18.0,
                        //           fontWeight: FontWeight.w900,
                        //           fontFamily: 'Montserrat',
                        //           color: kblack,
                        //         ),
                        //       ),
                        //     ],
                        //   ),
                        // ),
                        Center(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                height:
                                    MediaQuery.of(context).size.height / 1.25,
                                child: ListView.builder(
                                  itemCount: listScanModel.length,
                                  itemBuilder: (context, i) {
                                    final coupon = listScanModel[i];
                                    coupons = coupon.qrCode;
                                    date = coupon.date;
                                    valider = coupon.valider;
                                    var len = listScanModel.length;
                                    len != null
                                        ? price = len * 300
                                        : isNull = true;
                                    // price = 0;
                                    DateTime dt = DateTime.parse(date);

                                    final DateFormat dateFormatter =
                                        DateFormat('yyyy-MM-dd');
                                    final DateFormat hourFormatter =
                                        DateFormat('hh:mm');
                                    final String dateT =
                                        dateFormatter.format(dt);
                                    final String timeT =
                                        hourFormatter.format(dt);
                                    return ListTile(
                                      title: Column(
                                        children: [
                                          Container(
                                            alignment: Alignment.centerLeft,
                                            height: 40.0,
                                            color: kbrown,
                                            width: MediaQuery.of(context)
                                                .size
                                                .width,
                                            child: Padding(
                                              padding: const EdgeInsets.only(
                                                  left: 20.0, right: 20.0),
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  Text(
                                                    "Coupon",
                                                    style: TextStyle(
                                                      fontSize: 18.0,
                                                      fontWeight:
                                                          FontWeight.w900,
                                                      fontFamily: 'Montserrat',
                                                      color: kwhite,
                                                    ),
                                                  ),
                                                  Icon(
                                                    FontAwesomeIcons.ticketAlt,
                                                    color: kwhite,
                                                  )
                                                ],
                                              ),
                                            ),
                                          ),
                                          Container(
                                            alignment: Alignment.center,
                                            height: MediaQuery.of(context)
                                                    .size
                                                    .height /
                                                15,
                                            color: kbrown300,
                                            width: MediaQuery.of(context)
                                                .size
                                                .width,
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.fromLTRB(
                                                      5, 0, 5, 0),
                                              child: Text(
                                                "$coupons",
                                                textAlign: TextAlign.center,
                                                style: TextStyle(
                                                  fontSize: 15.0,
                                                  fontWeight: FontWeight.w900,
                                                  fontFamily: 'Montserrat',
                                                  color: kwhite,
                                                ),
                                              ),
                                            ),
                                          ),
                                          Container(
                                            height: 30.0,
                                            color: kgrey.withOpacity(0.8),
                                            width: MediaQuery.of(context)
                                                .size
                                                .width,
                                            child: Padding(
                                              padding: const EdgeInsets.only(
                                                  left: 20.0, right: 20.0),
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  Text(
                                                    "$dateT",
                                                    // textAlign: TextAlign.center,
                                                    style: TextStyle(
                                                      fontSize: 13.0,
                                                      fontWeight:
                                                          FontWeight.w900,
                                                      fontFamily: 'Montserrat',
                                                      color: kblack,
                                                    ),
                                                  ),
                                                  Text(
                                                    "$timeT",
                                                    // textAlign: TextAlign.center,
                                                    style: TextStyle(
                                                      fontSize: 13.0,
                                                      fontWeight:
                                                          FontWeight.w900,
                                                      fontFamily: 'Montserrat',
                                                      color: kblack,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                          SizedBox(
                                            height: 5.0,
                                          ),
                                        ],
                                      ),
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
                SizedBox(
                  height: 10.0,
                ),
                isNull == false
                    ? InkWell(
                        onTap: () {
                          setArchiveToLoad(id);
                          Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                  builder: (BuildContext context) =>
                                      super.widget));
                        },
                        child: Container(
                          padding: EdgeInsets.symmetric(
                              horizontal: 30.0, vertical: 15),
                          decoration: BoxDecoration(
                              color: kbrown,
                              borderRadius: BorderRadius.circular(10.0)),
                          child: isLoad == false
                              ? Row(mainAxisSize: MainAxisSize.min, children: [
                                  Text(
                                    "FAIRE PAYER",
                                    style: TextStyle(
                                        fontSize: 16.0,
                                        fontWeight: FontWeight.w900,
                                        fontFamily: 'Montserrat',
                                        color: kwhite),
                                  ),
                                  SizedBox(
                                    width: 15.0,
                                  ),
                                  Text(
                                    "( $price FCFA )",
                                    style: TextStyle(
                                        fontSize: 16.0,
                                        fontWeight: FontWeight.w900,
                                        fontFamily: 'Montserrat',
                                        color: kwhite),
                                  ),
                                  // Icon(
                                  //   FontAwesomeIcons.user,
                                  //   color: kwhite,
                                  // )
                                ])
                              : Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
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
                                  ],
                                ),
                        ),
                      )
                    : Container(),
              ],
            )
          : Container(
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
}
