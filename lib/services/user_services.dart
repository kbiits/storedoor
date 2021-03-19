import 'dart:convert';
import 'dart:io';

import 'package:get/get.dart';
import 'package:storedoor/constants.dart';
import 'package:storedoor/controllers/user_controller.dart';
import 'package:http/http.dart' as http;
import 'package:storedoor/helper/check_connection.dart';

class UserServices {
  static Future<Map<String, dynamic>> updateUser(
      String fullname, String email, String username, String password) async {
    bool isHaveConnection = await CheckConnection.checkConnection();
    if (isHaveConnection) {
      var response = await http.put(
        Uri.parse(apiUrl + "users/${UserController.id}"),
        body: {
          "fullname": "$fullname",
          "email": email,
          "username": username,
          "password": password
        },
        headers: {
          "Accept": "application/json",
          "Authorization": "Bearer ${UserController.token}"
        },
      );
      var jsonString = response.body;
      return json.decode(jsonString);
    }
    return null;
  }

  static Future<Map<String, dynamic>> updateProfilePict(String path) async {
    bool isHaveConnection = await CheckConnection.checkConnection();
    String imgExtension = (path.split("/").last);
    imgExtension = imgExtension.split(".").last;
    if (isHaveConnection) {
      Uri uploadProfilePictURI =
          Uri.parse(apiUrl + "users/${UserController.id}/updatePhoto");
      File image = File(path);
      var request = new http.MultipartRequest("POST", uploadProfilePictURI);
      request.headers.addEntries([
        MapEntry("Accept", "application/json"),
        MapEntry("Authorization", "Bearer ${UserController.token}"),
      ]);
      var bytes = image.readAsBytesSync();
      request.fields.addAll({
        "image": base64Encode(bytes),
      });
      var res = await request.send();
      var response = await http.Response.fromStream(res);

      if (response.statusCode == 200) {
        print("Image uploaded");
      } else {
        print(response);
        if (!Get.isDialogOpen && !Get.isSnackbarOpen) {
          Get.snackbar(
            "Failed",
            "Foto gagal diupload, silahkan coba kembali",
            barBlur: 8,
            overlayBlur: 1.5,
          );
          return json.decode(response.body);
        }
      }
      return json.decode(response.body);
    }
    return null;
  }
}
