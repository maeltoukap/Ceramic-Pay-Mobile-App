import 'dart:convert';

import 'package:ceramicpay/api/api.dart';
import 'package:http/http.dart' as http;

import 'package:ceramicpay/models/user_model.dart';

class CouponModel {
  String idScan;
  String idUser;
  String idCode;
  String valider;
  String date;

  CouponModel({
    this.idScan,
    this.idUser,
    this.idCode,
    this.valider,
    this.date,
  });
  // UserModel(this.id, this.name, this.phone);

  static CouponModel couponModel;

  factory CouponModel.fromJson(Map<String, dynamic> map) {
    return CouponModel(
      idScan: map['idScan'] ?? '',
      idUser: map['idUser'] ?? '',
      idCode: map['idCode'] ?? '',
      valider: map['valider'] ?? '',
      date: map['date_scan'] ?? '',
      // date: DateTime.fromMillisecondsSinceEpoch(map['date_scan']),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'idScan': idScan,
      'idUser': idUser,
      'idCode': idCode,
      'valider': valider,
      'date_scan': date,
    };
  }

  @override
  String toString() {
    return '$idScan';
  }
}
