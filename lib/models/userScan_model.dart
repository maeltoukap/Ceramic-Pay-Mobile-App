import 'dart:convert';

import 'package:ceramicpay/api/api.dart';
import 'package:http/http.dart' as http;

import 'package:ceramicpay/models/user_model.dart';

class ListScanModel {
  String idScan;
  String idUser;
  String idCode;
  String valider;
  String qrCode;
  String date;

  ListScanModel({
    this.idScan,
    this.idUser,
    this.idCode,
    this.valider,
    this.qrCode,
    this.date,
  });
  // UserModel(this.id, this.name, this.phone);

  static ListScanModel couponModel;

  factory ListScanModel.fromJson(Map<String, dynamic> map) {
    return ListScanModel(
      idScan: map['idScan'] ?? '',
      idUser: map['idUser'] ?? '',
      idCode: map['idCode'] ?? '',
      valider: map['valider'] ?? '',
      qrCode: map['qrCode'] ?? '',
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
      'qrCode': qrCode,
      'date_scan': date,
    };
  }

  @override
  String toString() {
    return '$idScan';
  }
}
