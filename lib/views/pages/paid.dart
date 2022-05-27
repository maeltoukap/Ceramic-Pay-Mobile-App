import 'package:ceramicpay/api/api.dart';
import 'package:ceramicpay/const/constants.dart';
import 'package:ceramicpay/models/userScan_model.dart';
import 'package:ceramicpay/models/user_model.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';

class Paid extends StatefulWidget {
  const Paid({Key key}) : super(key: key);

  @override
  _PaidState createState() => _PaidState();
}

class _PaidState extends State<Paid> {
  var id;
  var coupons;
  var valider;
  var date;
  var gagne;
  var price = 0;
  bool isLoading = false;
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
    var data = await Api.listPaid(id);
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
          "Coupons Payées",
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
          ? SingleChildScrollView(
              child: SafeArea(
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top: 30.0, bottom: 30.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Text(
                            "Gains",
                            style: TextStyle(
                              fontSize: 18.0,
                              fontWeight: FontWeight.w900,
                              fontFamily: 'Montserrat',
                              color: kblack,
                            ),
                          ),
                          Text(
                            "$price FCFA",
                            style: TextStyle(
                              fontSize: 18.0,
                              fontWeight: FontWeight.w900,
                              fontFamily: 'Montserrat',
                              color: kblack,
                            ),
                          ),
                        ],
                      ),
                    ),

                    Center(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            height: MediaQuery.of(context).size.height / 1.25,
                            child: ListView.builder(
                              itemCount: listScanModel.length,
                              itemBuilder: (context, i) {
                                final coupon = listScanModel[i];
                                coupons = coupon.qrCode;
                                date = coupon.date;
                                valider = coupon.valider;
                                var len = listScanModel.length;
                                price = len * 300;
                                DateTime dt = DateTime.parse(date);

                                final DateFormat dateFormatter =
                                    DateFormat('yyyy-MM-dd');
                                final DateFormat hourFormatter =
                                    DateFormat('hh:mm');
                                final String dateT = dateFormatter.format(dt);
                                final String timeT = hourFormatter.format(dt);
                                return ListTile(
                                  title: Column(
                                    children: [
                                      Container(
                                        alignment: Alignment.centerLeft,
                                        height: 40.0,
                                        color: kbrown,
                                        width:
                                            MediaQuery.of(context).size.width,
                                        child: Padding(
                                          padding: const EdgeInsets.only(
                                              left: 20.0, right: 20.0),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Text(
                                                "Coupon",
                                                style: TextStyle(
                                                  fontSize: 18.0,
                                                  fontWeight: FontWeight.w900,
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
                                        height:
                                            MediaQuery.of(context).size.height /
                                                15,
                                        color: kbrown300,
                                        width:
                                            MediaQuery.of(context).size.width,
                                        child: Padding(
                                          padding: const EdgeInsets.fromLTRB(
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
                                        width:
                                            MediaQuery.of(context).size.width,
                                        child: Padding(
                                          padding: const EdgeInsets.only(
                                              left: 20.0, right: 20.0),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Text(
                                                "$dateT",
                                                // textAlign: TextAlign.center,
                                                style: TextStyle(
                                                  fontSize: 13.0,
                                                  fontWeight: FontWeight.w900,
                                                  fontFamily: 'Montserrat',
                                                  color: kblack,
                                                ),
                                              ),
                                              Text(
                                                "$timeT",
                                                // textAlign: TextAlign.center,
                                                style: TextStyle(
                                                  fontSize: 13.0,
                                                  fontWeight: FontWeight.w900,
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
                    // SizedBox(
                    //   height: 15,
                    // ),
                    // RaisedButton(onPressed: () => print(valider)),
                  ],
                ),
              ),
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
