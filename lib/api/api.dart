import 'dart:convert';

import 'package:ceramicpay/models/user_model.dart';
import 'package:http/http.dart' as http;

class Api {
  static scanQrCode() async {
    try {
      final Response = await http.get(Url.getQrCode);

      if (Response.statusCode == 200) {
        var data = jsonDecode(Response.body);
        // var result = data['data'];
        return data;
      } else {
        // return null;
      }
    } catch (e) {
      print("Erreur de serveur");
    }
  }

  static getCoupons(String idUser) async {
    try {
      final response =
          await http.post(Url.getCoupons, body: {"idUser": idUser});
      print(response.statusCode);
      if (response.statusCode == 200) {
        return jsonDecode(response.body);
      } else {
        return null;
      }
    } catch (e) {}
  }

  static listCoupons(String idUser) async {
    try {
      final response =
          await http.post(Url.listCoupons, body: {"idUser": idUser});
      if (response.statusCode == 200) {
        return jsonDecode(response.body);
      } else {
        return null;
      }
    } catch (e) {}
  }
  
  static listArchives(String idUser) async {
    try {
      final response =
          await http.post(Url.listArchives, body: {"idUser": idUser});
      if (response.statusCode == 200) {
        return jsonDecode(response.body);
      } else {
        return null;
      }
    } catch (e) {}
  }

  static listPaid(String idUser) async {
    try {
      final response =
          await http.post(Url.listPaid, body: {"idUser": idUser});
      if (response.statusCode == 200) {
        return jsonDecode(response.body);
      } else {
        return null;
      }
    } catch (e) {}
  }

  static listLoad(String idUser) async {
    try {
      final response =
          await http.post(Url.listLoad, body: {"idUser": idUser});
      if (response.statusCode == 200) {
        return jsonDecode(response.body);
      } else {
        return null;
      }
    } catch (e) {}
  }
  
  static countNonValider(String idUser) async {
    try {
      final response =
          await http.post(Url.countNonValider, body: {"idUser": idUser});
      if (response.statusCode == 200) {
        print(jsonDecode(response.body));
        return jsonDecode(response.body);
      } else {
        return null;
      }
    } catch (e) {}
  }

  static countValider(String idUser) async {
    try {
      final response =
          await http.post(Url.countValider, body: {"idUser": idUser});
      if (response.statusCode == 200) {
        return jsonDecode(response.body);
      } else {
        return null;
      }
    } catch (e) {}
  }

  static getAmount(String idUser) async {
    try {
      final response = await http.post(Url.getAmount, body: {"idUser": idUser});
      if (response.statusCode == 200) {
        return jsonDecode(response.body);
      } else {
        return null;
      }
    } catch (e) {}
  }
  // static countRows(String idUser) async {
  //   // var resultat;
  //   try {
  //     final Response =
  //         await http.post(Url.countCoupons, body: {"idUser": idUser});
  //     print(Response.statusCode);
  //     if (Response.statusCode == 200) {
  //       final data = jsonDecode(Response.body);
  //       final result = data['data'];
  //       // print(Response.statusCode);
  //       print(result);
  //       final resultat = result[2];
  //       return resultat;
  //     }
  //     // return resultat;
  //   } catch (e) {
  //     print("Erreur: $e");
  //     print("Erreur de serveur");
  //   }
  // }
  // static getCodeId() async {
  //   try {
  //     final Response = await http.get(Url.getCodeId);

  //     if (Response.statusCode == 200) {
  //       var data = jsonDecode(Response.body);
  //       // var result = data['data'];
  //       return data;
  //     } else {
  //       return null;
  //     }
  //   } catch (e) {
  //     print("Erreur de serveur");
  //   }
  // }

  // static void setScan(String qrCode) async {
  //   var User = await UserModel.getCurrentUser();
  //   try {
  //     final Response = await http
  //         .post(Url.setScan, body: {"qrCode": qrCode, "idUser": User});

  //     print(Response.body);
  //     if (Response.statusCode == 200) {
  //       var data = jsonDecode(Response.body);
  //       var result = data['data'];
  //       // print(data);
  //       // int succes = result[1];
  //       // return data;
  //       print(result[0]);
  //       // return result;
  //     } else {
  //       print(Response.statusCode);
  //       // return null;
  //     }
  //   } catch (e) {
  //     print('erreur: $e');
  //     // print("Erreur de serveur ressayer");
  //   }
  // }
}

class Url {
  // static const String ApiLink = "http://api-ceramic.jifitech.com/api";
  static const String ApiLink = "https://ceramic-pay.000webhostapp.com/php";
  // "http://localhost/api/php";
  // "https://ceramic-services.000webhostapp.com/ceramic";
  static String getQrCode = ApiLink + "/qrCode.php";
  static String getCodeId = ApiLink + "getCodeId.php";
  static String setScan = ApiLink + "/insertScan.php";
  static String getCoupons = ApiLink + "/countRows.php";
  static String listCoupons = ApiLink + "/getUserScan.php";
  static String listArchives = ApiLink + "/getUserArchives.php";
  static String listPaid = ApiLink + "/getUserPaidScan.php";
  static String listLoad = ApiLink + "/getUserLoadScan.php";
  static String countNonValider = ApiLink + "/countNonValider.php";
  static String countValider = ApiLink + "/countValider.php";
  static String getAmount = ApiLink + "/getAmount.php";
  // https://ceramic-services.000webhostapp.com/ceramic/insertScan.php
  // static const String ApiLink =
  //     "https://ceramic-services.000webhostapp.com/ceramic/qrCode.php";
  // static String getQrCode =
  //     "https://ceramic-services.000webhostapp.com/ceramic/qrCode.php";
  // static String getCodeId =
  //     "https://ceramic-services.000webhostapp.com/ceramic/getCodeId.php";
  // static String setScan =
  //     "https://ceramic-services.000webhostapp.com/ceramic/insertScan.php";
  // static String getCoupons =
  //     "https://ceramic-services.000webhostapp.com/ceramic/countRows.php";
  // static String listCoupons =
  //     "https://ceramic-services.000webhostapp.com/ceramic/getUserScan.php";
  // // https://ceramic-services.000webhostapp.com/ceramic/insertScan.php
}
