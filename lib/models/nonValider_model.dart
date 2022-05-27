import 'dart:convert';

import 'package:ceramicpay/api/api.dart';
import 'package:http/http.dart' as http;

import 'package:ceramicpay/models/user_model.dart';

class NonValiderModel {
  String nonValider;

  NonValiderModel({
    this.nonValider
  });
  // UserModel(this.id, this.name, this.phone);

  static NonValiderModel couponModel;

  factory NonValiderModel.fromJson(Map<String, dynamic> map) {
    return NonValiderModel(
      nonValider: map['nonValider'] ?? ''
      // date: DateTime.fromMillisecondsSinceEpoch(map['date_scan']),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'nonValider': nonValider
    };
  }

  @override
  String toString() {
    return '$nonValider';
  }
}
