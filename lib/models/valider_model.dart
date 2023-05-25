import 'dart:convert';

import 'package:scspay/api/api.dart';
import 'package:http/http.dart' as http;

import 'package:scspay/models/user_model.dart';

class ValiderModel {
  String? valider;

  ValiderModel({this.valider});
  // UserModel(this.id, this.name, this.phone);

  static ValiderModel? couponModel;

  factory ValiderModel.fromJson(Map<String, dynamic> map) {
    return ValiderModel(valider: map['valider'] ?? ''
        // date: DateTime.fromMillisecondsSinceEpoch(map['date_scan']),
        );
  }

  Map<String, dynamic> toMap() {
    return {'valider': valider};
  }

  @override
  String toString() {
    return '$valider';
  }
}
