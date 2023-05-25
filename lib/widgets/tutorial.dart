import 'package:scspay/const/constants.dart';
import 'package:flutter/material.dart';

class TutorialWidget extends StatelessWidget {
  String? img;
  String? text;

  TutorialWidget({@required this.img, @required this.text});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Image(
          image: AssetImage('assets/images/tutorial/$img'),
          // width: 60.0,
          height: 60.0,
        ),
        SizedBox(
          height: 20.0,
        ),
        Padding(
          padding: const EdgeInsets.fromLTRB(12, 0, 12, 0),
          child: Text(
            "$text",
            textAlign: TextAlign.justify,
            style: TextStyle(
              fontSize: 17.0,
              // fontWeight: FontWeight.w900,
              fontFamily: 'Montserat',
              color: kblack,
            ),
          ),
        ),
      ],
    );
  }
}
