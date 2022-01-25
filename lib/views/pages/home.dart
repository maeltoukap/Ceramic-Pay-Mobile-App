import 'package:ceramicpay/api/api.dart';
import 'package:ceramicpay/const/constants.dart';
import 'package:ceramicpay/models/nonValider_model.dart';
import 'package:ceramicpay/models/scan_model.dart';
import 'package:ceramicpay/models/userScan_model.dart';
import 'package:ceramicpay/models/valider_model.dart';
import 'package:ceramicpay/services/globals.dart';
import 'package:ceramicpay/views/pages/profile.dart';
import 'package:ceramicpay/views/pages/qr_scan.dart';
import 'package:ceramicpay/models/user_model.dart';
import 'package:flutter/material.dart';
import 'package:ceramicpay/widgets/drawer_menu.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  var id;
  var name;
  var phone;
  var coupons;
  var nonVal;
  var val;
  var price;
  bool isLoading = false;

  List<NonValiderModel> nonValider = [];
  List<ValiderModel> valider = [];
  getUserData() async {
    var user = await UserModel.getCurrentUserData();
    setState(() {
      id = user.id;
    });
    var data = await Api.countNonValider(id);
    if (data != null) {
      print(data);
      nonValider.clear();
      for (Map i in data) {
        setState(() {
          nonVal = NonValiderModel.fromJson(i).nonValider;
          price = int.parse(nonVal) * 400;
          nonValider.add(NonValiderModel.fromJson(i));
        });
      }
    }
    print(nonVal);
    print(nonValider);
  }

  getUserData2() async {
    var user = await UserModel.getCurrentUserData();
    setState(() {
      id = user.id;
    });
    var data2 = await Api.countValider(id);
    if (data2 != null) {
      print(data2);
      nonValider.clear();
      for (Map i in data2) {
        setState(() {
          val = ValiderModel.fromJson(i).valider;
          valider.add(ValiderModel.fromJson(i));
        });
      }
    }
    print(val);
    print(nonValider);
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // getUserInfo();
    getUserData();
    getUserData2();
    getUserInfo();
  }

  void getUserInfo() async {
    var user = await UserModel.getCurrentUserData();
    if (user != null) {
      setState(() {
        name = user.name;
        phone = user.phone;
      });
    } else {
      setState(() {
        name = ' ';
        phone = " ";
      });
    }
  }

  @override
  void setState(fn) {
    // TODO: implement setState
    super.setState(fn);

    coupons = Global.coupons;
    // valider = Global.valider;
    // nonValider = Global.nonValider;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 10.0,
        title: Text(
          "CERAMIC PAY",
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
      body: CustomScrollView(
        slivers: [
          SliverList(
            delegate: SliverChildListDelegate(
              <Widget>[
                Padding(
                  padding: const EdgeInsets.fromLTRB(20.0, 20.0, 20.0, 20.0),
                  child: Card(
                    elevation: 20.0,
                    margin: EdgeInsets.only(top: 20.0),
                    color: kgrey,
                    child: Padding(
                      padding: EdgeInsets.all(10.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          CircleAvatar(
                            child: Icon(
                              FontAwesomeIcons.userAlt,
                              color: kblack,
                            ),
                            backgroundColor: kwhite,
                          ),
                          SizedBox(
                            width: 20.0,
                          ),
                          Text(
                            "$name",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 20.0,
                              fontWeight: FontWeight.w200,
                              fontFamily: 'Poppins',
                              color: kblack,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                // ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(20.0, 20.0, 20.0, 20.0),
                  child: Card(
                    margin: EdgeInsets.only(top: 20.0),
                    color: kgrey,
                    child: Padding(
                      padding: EdgeInsets.all(10.0),
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Icon(
                                FontAwesomeIcons.times,
                                color: Colors.red,
                              ),
                              Text(
                                "Coupons non payés",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontSize: 20.0,
                                  fontWeight: FontWeight.w200,
                                  fontFamily: 'Poppins',
                                  color: kblack,
                                ),
                              ),
                              SizedBox(
                                width: 20.0,
                              ),
                              nonVal != null
                                  ? Text(
                                      "$nonVal",
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                        fontSize: 20.0,
                                        fontWeight: FontWeight.w200,
                                        fontFamily: 'Poppins',
                                        color: kblack,
                                      ),
                                    )
                                  : CircularProgressIndicator(
                                      backgroundColor: kbrown,
                                    ),
                            ],
                          ),
                          SizedBox(
                            height: 20.0,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Icon(
                                FontAwesomeIcons.check,
                                color: Colors.green,
                              ),
                              Text(
                                "Coupons payés",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontSize: 20.0,
                                  fontWeight: FontWeight.w200,
                                  fontFamily: 'Poppins',
                                  color: kblack,
                                ),
                              ),
                              SizedBox(
                                width: 60.0,
                              ),
                              val != null
                                  ? Text(
                                      "$val",
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                        fontSize: 20.0,
                                        fontWeight: FontWeight.w200,
                                        fontFamily: 'Poppins',
                                        color: kblack,
                                      ),
                                    )
                                  : CircularProgressIndicator(
                                      backgroundColor: kbrown,
                                    ),
                            ],
                          ),
                          SizedBox(
                            height: 20.0,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Icon(
                                FontAwesomeIcons.dollarSign,
                                color: kblack,
                              ),
                              Text(
                                "En attente",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontSize: 20.0,
                                  fontWeight: FontWeight.w200,
                                  fontFamily: 'Poppins',
                                  color: kblack,
                                ),
                              ),
                              SizedBox(
                                width: 60.0,
                              ),
                              price != null
                                  ? Text(
                                      "$price FCFA",
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                        fontSize: 20.0,
                                        fontWeight: FontWeight.w200,
                                        fontFamily: 'Poppins',
                                        color: kblack,
                                      ),
                                    )
                                  : CircularProgressIndicator(
                                      backgroundColor: kbrown,
                                    ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                Image(image: AssetImage('assets/images/ceramic-w.jpg')),
                // RaisedButton(onPressed: () async {
                //   // UserModel.getUser();
                //   // final us = await UserModel.getUser();
                //   getUserData();
                //   getUserData2();
                //   setState(() {
                //     print(Global.coupons);
                //   });
                //   // final ub = await CouponModel.getCoupons();
                //   // print(us.name);
                // })
              ],
            ),
          ),
        ],
      ),
      drawer: DrawerMenu(),
    );
  }
}
