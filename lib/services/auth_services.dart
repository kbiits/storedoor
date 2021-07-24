import 'dart:convert';

// import 'package:data_connection_checker/data_connection_checker.dart';
// import 'package:device_info/device_info.dart';
import 'package:flutter/widgets.dart';
import 'package:get_storage/get_storage.dart';
import 'package:storedoor/constants.dart';
import 'package:http/http.dart' as http;
// import 'dart:io' show Platform;

import 'package:storedoor/helper/check_connection.dart';

class AuthServices {
  static Future<Map<String, dynamic>> registerUser(
      String fullname, String email, String username, String password) async {
    bool isHaveConnection = await CheckConnection.checkConnection();

    if (isHaveConnection) {
      var response = await http.post(
        Uri.parse(apiUrl + "register"),
        body: {
          "fullname": fullname,
          "email": email,
          "username": username,
          "password": password
        },
      );
      var jsonString = response.body;
      return json.decode(jsonString);
    }
    return null; 
  }

  static Future<String> _getId() async {
    // DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();
    // if (Platform.isIOS) {
    //   IosDeviceInfo iosDeviceInfo = await deviceInfo.iosInfo;
    //   return iosDeviceInfo.identifierForVendor; // unique ID on iOS
    // } else if (Platform.isIOS) {
    //   AndroidDeviceInfo androidDeviceInfo = await deviceInfo.androidInfo;
    //   return androidDeviceInfo.androidId; // unique ID on Android
    // } else {
    UniqueKey uuid = UniqueKey();
    return uuid.toString();
    // }
  }

  static Future<Map<String, dynamic>> loginUser(
      String accountData, String password) async {
    bool isHaveConnection = await CheckConnection.checkConnection();

    if (isHaveConnection) {
      var response = await http.post(
        Uri.parse(apiUrl + "login"),
        body: {
          "account_data": accountData,
          "password": password,
          "device_name": await _getId(),
        },
      );
      var jsonString = response.body;
      Map<String, dynamic> decoded = json.decode(jsonString);
      GetStorage storage = new GetStorage();
      print(response.body);
      if (response.statusCode == 200) {
        storage.write("token", decoded["token"]);

        storage.write("isLogged", true);

        storage.write("fullname", decoded["data"]["user"]["fullname"]);

        storage.write("username", decoded["data"]["user"]["username"]);

        storage.write("email", decoded["data"]["user"]["email"]);

        storage.write("id", decoded["data"]["user"]["id"]);

        storage.write("avatar", decoded["data"]["user"]["avatar"]);
      } else {
        storage.write("isLogged", false);
      }
      return decoded;
    } else {
      return null;
    }
  }
}
