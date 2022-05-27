import 'package:ceramicpay/api/api.dart';
import 'package:ceramicpay/models/scan_model.dart';
import 'package:ceramicpay/models/userScan_model.dart';
import 'package:ceramicpay/models/user_model.dart';
import 'package:flutter/material.dart';
import 'package:ceramicpay/const/constants.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class Codes extends StatefulWidget {
  @override
  _CodesState createState() => _CodesState();
}

class _CodesState extends State<Codes> {
  var id;
  var coupons;
  var valider;
  var date;
  var gagne;
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
    var data = await Api.listCoupons(id);
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

  String dropdownValue = 'Tous';

  @override
  Widget build(BuildContext context) {
    getUserInfo();
    return Scaffold(
      // backgroundColor: bgColor,
      appBar: AppBar(
        elevation: 10.0,
        title: Text(
          "Mes Codes",
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
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Container(
              alignment: Alignment.topRight,
              margin: new EdgeInsets.only(top: 20.0, right: 10.0, bottom: 15.0),
              child: DropdownButton<String>(
                value: dropdownValue,
                icon: Icon(
                  FontAwesomeIcons.filter,
                  color: kblue,
                ),
                iconSize: 24,
                elevation: 16,
                style: const TextStyle(color: Colors.deepPurple),
                underline: Container(
                  height: 2,
                  color: Colors.deepPurpleAccent,
                ),
                onChanged: (String newValue) {
                  setState(() {
                    dropdownValue = newValue;
                  });
                },
                items: <String>['Tous', 'Payés', 'Non Payés']
                    .map<DropdownMenuItem<String>>((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
              ),
            ),
            dropdownValue == 'Non Payés'
                ? _buildBuy()
                : dropdownValue == "Payés"
                    ? _buildBuy()
                    : _buildBuy(),
          ],
        ),
      ),
    );
    // );
  }

  Widget _buildNoBuy() {
    return SingleChildScrollView(
      child: SafeArea(
        child: Column(
          children: [
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
                          return Card(
                            color: kgrey,
                            child: Container(
                              margin: EdgeInsets.only(top: 20, bottom: 20),
                              padding: EdgeInsets.all(10),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text("$coupons",
                                          style: TextStyle(
                                            fontSize: 18.0,
                                            fontWeight: FontWeight.w900,
                                            fontFamily: 'Montserrat',
                                            color: kblack,
                                          )),
                                      valider == 1
                                          ? Icon(
                                              FontAwesomeIcons.check,
                                              color: Colors.green,
                                            )
                                          : Icon(
                                              FontAwesomeIcons.times,
                                              color: Colors.red,
                                            ),
                                    ],
                                  ),
                                  SizedBox(
                                    height: 30,
                                  ),
                                  Text("$date",
                                      style: TextStyle(
                                        fontSize: 18.0,
                                        fontWeight: FontWeight.w900,
                                        fontFamily: 'Montserrat',
                                        color: kblack,
                                      )),
                                ],
                              ),
                            ),
                          );
                        }),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 15,
            ),
            RaisedButton(onPressed: () => print(valider)),
          ],
        ),
      ),
    );
  }

  Widget _buildBuy() {
    return isLoading == false
        ? SingleChildScrollView(
            child: SafeArea(
              child: Column(
                children: [
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
                                return Card(
                                  color: kgrey,
                                  child: Container(
                                    margin:
                                        EdgeInsets.only(top: 20, bottom: 20),
                                    padding: EdgeInsets.all(10),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text("$coupons",
                                                style: TextStyle(
                                                  fontSize: 18.0,
                                                  fontWeight: FontWeight.w900,
                                                  fontFamily: 'Montserrat',
                                                  color: kblack,
                                                )),
                                            valider == 0
                                                ? Icon(
                                                    FontAwesomeIcons.times,
                                                    color: Colors.red,
                                                  )
                                                : Icon(FontAwesomeIcons.check,
                                                    color: Colors.green),
                                          ],
                                        ),
                                        SizedBox(
                                          height: 30,
                                        ),
                                        Text("$date",
                                            style: TextStyle(
                                              fontSize: 18.0,
                                              fontWeight: FontWeight.w900,
                                              fontFamily: 'Montserrat',
                                              color: kblack,
                                            )),
                                      ],
                                    ),
                                  ),
                                );
                              }),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  RaisedButton(onPressed: () => print(valider)),
                ],
              ),
            ),
          )
        : Container(
            width: MediaQuery.of(context).size.width,
            margin: const EdgeInsets.only(left: 30.0, right: 30.0, top: 180.0),
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
          );
  }
}
