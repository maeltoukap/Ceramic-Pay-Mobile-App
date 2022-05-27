import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

import 'package:ceramicpay/models/user_model.dart';
import 'package:http/http.dart' as http;
import 'package:ceramicpay/api/api.dart';

class QrModel {
  String id;
  String qrCode;
  String coupons;
  String gagne;

  QrModel({this.id, this.qrCode, this.coupons, this.gagne});
  // UserModel(this.id, this.name, this.phone);

  static QrModel sessionUser;

  factory QrModel.fromJson(Map<String, dynamic> i) => QrModel(
      id: i['idQr'],
      qrCode: i['qrCode'],
      coupons: i['nbreCoupon'],
      gagne: i['nbreWin']);

  Map<String, dynamic> toMap() =>
      {"id": id, "qrCode": qrCode, 'nbreCoupon': coupons, 'nbreWin': gagne};

  static getQrFromJson(QrModel qr) async {
    var data = json.encode(qr.toMap());
    return data;
    // pref.setString("user", data);
    // pref.commit();
  }
}
