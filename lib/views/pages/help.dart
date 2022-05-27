import 'package:flutter/material.dart';
import 'package:ceramicpay/const/constants.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class Help extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 10.0,
        title: Text(
          "Aide",
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
      body: Container(
        child: SingleChildScrollView(
          child: SafeArea(
            child: Column(
              children: [
                Image(image: AssetImage('assets/images/ceramic-w.jpg')),
                Container(
                  // margin: EdgeInsets.fromLTRB(0.0, 15.0, 15.0, 0.0),
                  // margin: EdgeInsets.only(left: 5.0, right: 5.0, bottom: 3.0), //This is the true code
                  width: MediaQuery.of(context).size.width,
                  margin: EdgeInsets.fromLTRB(10, 10, 10, 20),
                  padding: EdgeInsets.fromLTRB(15, 25, 15, 0),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10.0),
                    color: kwhite,
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
                    padding: const EdgeInsets.all(20.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "Ceramic Pay",
                                style: TextStyle(
                                  fontSize: 24.0,
                                  fontWeight: FontWeight.w200,
                                  fontFamily: 'Poppins',
                                  color: kbrown,
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          height: 7.0,
                        ),
                        Text(
                          "Decembre 7, 2021",
                          style: TextStyle(fontSize: 18.0),
                        ),
                        SizedBox(
                          height: 17.0,
                        ),
                        Text(
                          "QU'EST CE QUE C'EST ?",
                          style: TextStyle(
                            fontSize: 20.0,
                            fontWeight: FontWeight.w500,
                            fontFamily: 'Montserat',
                            color: kblack,
                          ),
                        ),
                        SizedBox(
                          height: 7.0,
                        ),
                        Text(
                          "Est une application d'envoi de coupons gagnant pour l'entreprise CERAMIC SERVICES SARL.",
                          style: TextStyle(fontSize: 18.0),
                        ),
                        SizedBox(
                          height: 17.0,
                        ),
                        Text(
                          "C'EST QUOI EXACTEMENT ?",
                          style: TextStyle(
                            fontSize: 20.0,
                            fontWeight: FontWeight.w500,
                            fontFamily: 'Montserat',
                            color: kblack,
                          ),
                        ),
                        SizedBox(
                          height: 7.0,
                        ),
                        Text(
                          "Simplement, a l'aide d'un telephone portable ou d'une tablette, il est desormais possible de scanner et envoyer vos coupons et de suivre vos gains.",
                          style: TextStyle(fontSize: 18.0),
                        ),
                        SizedBox(
                          height: 17.0,
                        ),
                        Text(
                          "QUELS SONT LES ATOUTS ?",
                          style: TextStyle(
                            fontSize: 20.0,
                            fontWeight: FontWeight.w500,
                            fontFamily: 'Montserat',
                            color: kblack,
                          ),
                        ),
                        SizedBox(
                          height: 7.0,
                        ),
                        Text(
                          "Faciliter la gestion des coupons gagnants.",
                          style: TextStyle(fontSize: 18.0),
                        ),
                        Text(
                          "Faciliter la gestions des gains.",
                          style: TextStyle(fontSize: 18.0),
                        ),
                        Text(
                          "Avoir une tracabilité de vos coupons gagnants.",
                          style: TextStyle(fontSize: 18.0),
                        ),
                      ],
                    ),
                  ),
                ),
                // ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
