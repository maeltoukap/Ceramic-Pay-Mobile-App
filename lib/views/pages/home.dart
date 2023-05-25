import 'package:scspay/api/api.dart';
import 'package:scspay/const/constants.dart';
import 'package:scspay/models/nonValider_model.dart';
import 'package:scspay/models/scan_model.dart';
import 'package:scspay/models/userScan_model.dart';
import 'package:scspay/models/valider_model.dart';
import 'package:scspay/services/globals.dart';
import 'package:scspay/views/pages/profile.dart';
import 'package:scspay/views/pages/qr_scan.dart';
import 'package:scspay/models/user_model.dart';
import 'package:scspay/widgets/tutorial.dart';
import 'package:flutter/material.dart';
import 'package:scspay/widgets/drawer_menu.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:new_version/new_version.dart';

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
      for (Map<String, dynamic> i in data) {
        setState(() {
          nonVal = NonValiderModel.fromJson(i).nonValider;
          price = (nonVal != null ? int.parse(nonVal) : 0) * 300;
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
      for (Map<String, dynamic> i in data2) {
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
    _checkVersion();
    getUserData();
    getUserData2();
    getUserInfo();
  }

  void _checkVersion() async {
    final newVersion = NewVersion(
      androidId: "scspay.com",
      // context: context,
      // dialogTitle: "Mise A Jour !",
      // dismissText: "Annuler",
      // dialogText:
      //     "Mettez a jour votre application de la version afin de profiter des nouveaux correctifs de securite et ameliorations",
      // dismissAction: () {
      //   SystemNavigator.pop();
      // },
      // updateText: "Installer",
    );
    newVersion.showAlertIfNecessary(context: context);
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
          "Ceramic Pay",
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
                            "Bienvenu $name",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 18.0,
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
                SizedBox(
                  height: 20.0,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      FontAwesomeIcons.readme,
                      size: 50.0,
                      color: kbrown,
                    ),
                    SizedBox(
                      width: 18.0,
                    ),
                    Text(
                      "Didactitiel",
                      // textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 25.0,
                        fontWeight: FontWeight.w200,
                        fontFamily: 'Poppins',
                        color: kbrown,
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 20.0,
                ),
                TutorialWidget(
                  img: "home.png",
                  text:
                      "Accedez a l'accueil et suivez le didactitiel pour apprendre a utiliser l'application Ceramic Pay.",
                ),
                SizedBox(
                  height: 20.0,
                ),
                TutorialWidget(
                  img: "scan.png",
                  text:
                      "Scannez vos coupons. Attendez quelques secondes afin de recevoir le message de confirmation. Vos coupons scannés sont automatiquement enregisté et archivé.",
                ),
                SizedBox(
                  height: 20.0,
                ),
                TutorialWidget(
                  img: "archives.png",
                  text:
                      "Visualisez vous derniers coupons scanné et archivé et demandez a etre payé pour ces coupons et vous recevrez votre paiement quelques heure apres.",
                ),
                SizedBox(
                  height: 20.0,
                ),
                TutorialWidget(
                  img: "coupon.png",
                  text:
                      "Vous avez acces au numero de vos coupons, la date et l'heure de vos scan dans un format unique.",
                ),
                SizedBox(
                  height: 20.0,
                ),
                TutorialWidget(
                  img: "buy-btn.png",
                  text:
                      "Cliquez sur le boutton 'FAIRE PAYER' afin de demander a etre payer pour vos coupons deja scannés et archivés.",
                ),
                SizedBox(
                  height: 20.0,
                ),
                TutorialWidget(
                  img: "paiement.png",
                  text:
                      "Visualisez vos coupons dont vous avez demandé un paiement et qui n'ont pas encore été payé.",
                ),
                SizedBox(
                  height: 20.0,
                ),
                TutorialWidget(
                  img: "paid.png",
                  text:
                      "Visualisez vos coupons dont le paiement vous a deja été versé et voyez combien vous avez deja gagné sur Ceramic Pay.",
                ),
                SizedBox(
                  height: 20.0,
                ),
                TutorialWidget(
                  img: "profile.png",
                  text:
                      "Accedez a vos informations utilisateur tels que votre nom et votre numero de telephone et modifiez votre numero de telephone a votre guise.",
                ),
                SizedBox(
                  height: 20.0,
                ),
              ],
            ),
          ),
        ],
      ),
      drawer: DrawerMenu(),
    );
  }
}
