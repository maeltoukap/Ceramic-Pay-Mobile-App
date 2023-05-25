import 'package:flutter/material.dart';
import 'package:scspay/const/constants.dart';

class AboutUs extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 10.0,
        title: Text(
          "A Propos",
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
        child: SafeArea(
          child: Column(
            children: [
              Image(image: AssetImage('assets/images/ceramic-w.jpg')),
              Padding(
                padding: const EdgeInsets.only(left: 10.0, top: 10.0),
                child: Wrap(
                  spacing: 10.0,
                  runSpacing: 7.0,
                  children: [
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        "Ceramic Pay",
                        style: TextStyle(
                          fontSize: 20.0,
                          fontWeight: FontWeight.w200,
                          fontFamily: 'Poppins',
                          color: kblack,
                        ),
                      ),
                    ),
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        "Fait le 7 Decembre 2021",
                        textAlign: TextAlign.left,
                        style: TextStyle(
                          fontSize: 20.0,
                          fontWeight: FontWeight.w200,
                          fontFamily: 'Montserrat',
                          color: kblack,
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 10.0,
                    ),
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        "PAR",
                        style: TextStyle(
                          fontSize: 20.0,
                          fontWeight: FontWeight.w200,
                          fontFamily: 'Poppins',
                          color: kblack,
                        ),
                      ),
                    ),
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        "Le developpeur web et mobile Mael Toukap",
                        style: TextStyle(
                          fontSize: 20.0,
                          fontWeight: FontWeight.w200,
                          fontFamily: 'Montserrat',
                          color: kblack,
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 10.0,
                    ),
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        "POUR",
                        style: TextStyle(
                          fontSize: 20.0,
                          fontWeight: FontWeight.w200,
                          fontFamily: 'Poppins',
                          color: kblack,
                        ),
                      ),
                    ),
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        "L'entreprise de production et vente de ciment colle",
                        style: TextStyle(
                          fontSize: 20.0,
                          fontWeight: FontWeight.w200,
                          fontFamily: 'Montserrat',
                          color: kblack,
                        ),
                      ),
                    ),
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        "CERAMIC SERVICES SARL",
                        style: TextStyle(
                          fontSize: 20.0,
                          fontWeight: FontWeight.w200,
                          fontFamily: 'Poppins',
                          color: kbrown,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              // ],
              // ),
              Padding(
                padding: const EdgeInsets.only(top: 100.0),
                child: Align(
                  alignment: FractionalOffset.bottomCenter,
                  child: Text(
                    "Copyright 💡 Mael Toukap | 2021",
                    style: TextStyle(
                      fontSize: 13.0,
                      fontWeight: FontWeight.w200,
                      fontFamily: 'Poppins',
                      color: kblack,
                    ),
                  ),
                ),
              ),
              // ),
            ],
          ),
        ),
        // ),
      ),
    );
  }
}
