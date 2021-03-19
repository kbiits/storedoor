import 'dart:convert';
import 'dart:io';

import 'package:flutter/widgets.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:storedoor/constants.dart';
import 'package:http/http.dart' as http;
import 'package:storedoor/controllers/user_controller.dart';
// import 'dart:io' show Platform;

import 'package:storedoor/helper/check_connection.dart';
import 'package:storedoor/view/widgets/no_internet.dart';

class ProductServices {
  static Future<Map<String, dynamic>> fetchProducts() async {
    bool isHaveConnection = await CheckConnection.checkConnection();

    if (isHaveConnection) {
      print("fetching products");
      var response = await http.get(
        apiUrl + "products",
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
          'Authorization': 'Bearer ${UserController.token.value}',
        },
      );
      var jsonString = response.body;
      return json.decode(jsonString);
    }
    return null;
  }

  // Products with particular seller
  static Future<Map<String, dynamic>> fetchProductsWithId() async {
    bool isHaveConnection = await CheckConnection.checkConnection();

    if (isHaveConnection) {
      var response = await http.post(
        Uri.parse(apiUrl + "users/${UserController.id}/products"),
        body: {
          'token': UserController.token,
        },
      );
      var jsonString = response.body;
      // print(jsonString);
      return json.decode(jsonString);
    }
    return null;
  }

  static Future<Map<String, dynamic>> addingProduct({
    String path,
    String title,
    String description,
    String price,
    String categoryId,
  }) async {
    bool isHaveConnection = await CheckConnection.checkConnection();
    String imgExtension = (path.split("/").last);
    imgExtension = imgExtension.split(".").last;
    if (isHaveConnection) {
      Uri addingProduct =
          Uri.parse(apiUrl + "users/${UserController.id}/products");
      File image = File(path);
      var request = new http.MultipartRequest("POST", addingProduct);
      request.headers.addEntries([
        MapEntry("Accept", "application/json"),
        MapEntry("Authorization", "Bearer ${UserController.token}"),
      ]);
      var bytes = image.readAsBytesSync();
      request.fields.addAll({
        "img": base64Encode(bytes),
      });
      request.fields.addAll({
        "title": title,
        "description": description,
        "price": price,
        "category_id": categoryId,
      });

      var res = await request.send();
      var response = await http.Response.fromStream(res);

      if (response.statusCode == 200) {
        print("Product added");
      }
      return json.decode(response.body);
    }
    EasyLoading.dismiss();
    noInternet();
    return null;
  }

  static Future<Map<String, dynamic>> removeProduct(int productId) async {
    bool isHaveConnection = await CheckConnection.checkConnection();

    if (isHaveConnection) {
      var response = await http.delete(
        apiUrl + "users/${UserController.id}/products/$productId",
        headers: {
          "Accept": "application/json",
          "Authorization": "Bearer ${UserController.token}",
        },
      );

      if (response.statusCode == 200) {
        print("Product Removed");
      }
      return json.decode(response.body);
    }
    EasyLoading.dismiss();
    noInternet();
    return null;
  }

  static Future<Map<String, dynamic>> updateProduct({
    String categoryId,
    String title,
    String price,
    String path,
    String description,
    int productId,
    @required bool useDefaultImg,
  }) async {
    bool isHaveConnection = await CheckConnection.checkConnection();
    String imgExtension = (path.split("/").last);
    imgExtension = imgExtension.split(".").last;
    if (isHaveConnection) {
      Uri updatingProductUrl = Uri.parse(apiUrl +
          "users/${UserController.id}/products/$productId?_method=PUT");
      var request = new http.MultipartRequest("POST", updatingProductUrl);
      request.headers.addEntries([
        MapEntry("Accept", "application/json"),
        MapEntry("Authorization", "Bearer ${UserController.token}"),
      ]);
      if (!useDefaultImg) {
        var bytes = File(path).readAsBytesSync();
        request.fields.addAll({
          "img": base64Encode(bytes),
        });
      }
      request.fields.addAll({
        "title": title,
        "description": description,
        "price": price,
        "category_id": categoryId,
      });

      var res = await request.send();
      var response = await http.Response.fromStream(res);
      if (response.statusCode == 200) {
        print("Product Updated");
      }
      // Di catch oleh product controller dgn cek value dari key (is_error)
      // else {
      //   print(response);
      //   if (!Get.isDialogOpen && !Get.isSnackbarOpen) {
      //     Get.snackbar(
      //       "Gagal",
      //       "Terjadi kesalahan, silahkan coba lagi",
      //       barBlur: 8,
      //       overlayBlur: 1.5,
      //     );
      //   }
      // }
      return json.decode(response.body);
    }
    EasyLoading.dismiss();
    noInternet();
    return null;
  }
}
