import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

class UserModel {
  String? id;
  String? name;
  String? phone;
  String? ville;

  UserModel({this.id, this.name, this.phone, this.ville});
  // UserModel(this.id, this.name, this.phone);

  static UserModel? sessionUser;
  static UserModel? userName;
  static UserModel? phoneNumer;
  static UserModel? town;

  factory UserModel.fromJson(Map<String, dynamic> i) =>
      UserModel(id: i['idUser'], name: i['nom'], phone: i['telephone'], ville: i['ville']);

  Map<String, dynamic> toMap() => {"idUser": id, "nom": name, "telephone": phone, "ville": ville};

  static void saveUser(UserModel user) async {
    SharedPreferences pref = await SharedPreferences.getInstance();

    var data = json.encode(user.toMap());
    pref.setString("user", data);
    pref.setBool("isLogin", true);
    pref.commit();
  }

  static void getUser() async {
    SharedPreferences pref = await SharedPreferences.getInstance();

    var data = pref.getString("user");
    var isLogin = pref.getBool("isLogin");

    if (isLogin != null && isLogin) {
      var decode = jsonDecode(data!);
      // Map<String, dynamic> decode = jsonDecode(data);
      // String id = decode['id'];
      // String name = decode['name'];
      // String phone = decode['phone'];

      // UserModel sessionUser = new UserModel(id, name, phone);
      // var decode = json.decode(data);
      var user = await UserModel.fromJson(decode);
      sessionUser = user;
      print(sessionUser!.name);
      print(sessionUser!.id);
      // print(decode['id']);
    } else {
      sessionUser = null;
    }

  }

  static getCurrentUserData() async {
    SharedPreferences pref = await SharedPreferences.getInstance();

    var data = pref.getString("user");

    if (data != null) {
      var decode = jsonDecode(data);

      var user = await UserModel.fromJson(decode);
      sessionUser = user;
      
      return user;
    } else {
      sessionUser = null;
    }

  }

  static getCurrentUser() async {
    SharedPreferences pref = await SharedPreferences.getInstance();

    var data = pref.getString("user");

    if (data != null) {
      var decode = jsonDecode(data);
      
      var user = await UserModel.fromJson(decode);
      sessionUser = user;
      print(decode);
      // return decode['id'];
      return user.id;
    } else {
      sessionUser = null;
    }

  }

  static void logOut() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    pref.setString("user", "");
    pref.setBool("user", false);
    sessionUser == null;
    pref.commit();
  }
}
