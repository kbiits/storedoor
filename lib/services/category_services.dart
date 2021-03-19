import 'dart:convert';

import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:storedoor/constants.dart';
import 'package:storedoor/controllers/user_controller.dart';
import 'package:storedoor/helper/check_connection.dart';
import 'package:storedoor/view/widgets/no_internet.dart';

class CategoryServices {
  static Future<Map<String, dynamic>> fetchData() async {
    bool isHaveConnection = await CheckConnection.checkConnection();
    if (isHaveConnection) {
      print("fetching categories data");
      var response = await http.get(
        apiUrl + "categories",
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
          'Authorization': 'Bearer ${UserController.token.value}',
        },
      );
      var jsonString = response.body;
      print("got response from fetch data cart");
      return json.decode(jsonString);
    }
    return null;
  }

  static Future<Map<String, dynamic>> addCategory(String slug) async {
    bool isHaveConnection = await CheckConnection.checkConnection();
    if (isHaveConnection) {
      print("adding category");
      var response = await http.post(
        apiUrl + "categories",
        headers: {
          'Accept': 'application/json',
          'Authorization': 'Bearer ${UserController.token.value}',
        },
        body: {
          "slug": slug,
        },
      );
      print("got response from add category function in services module");

      if (response.statusCode == 200) {
        print("Success");
      } else {
        print(response.body);
        if (!Get.isDialogOpen && !Get.isSnackbarOpen) {
          Get.snackbar(
            "Gagal menambahkan kategori",
            "Silahkan coba kembali",
            barBlur: 8,
            overlayBlur: 1.5,
          );
        }
      }
      var jsonString = response.body;
      return json.decode(jsonString);
    }
    EasyLoading.dismiss();
    noInternet();
    return null;
  }

  static Future<Map<String, dynamic>> removeCategory(int categoryId) async {
    bool isHaveConnection = await CheckConnection.checkConnection();
    if (isHaveConnection) {
      print("removing category");
      var response = await http.delete(
        apiUrl + "categories/$categoryId",
        headers: {
          'Accept': 'application/json',
          'Authorization': 'Bearer ${UserController.token.value}',
        },
      );
      print("got response from remove category function in services module");

      if (response.statusCode == 200) {
        print("Success");
      } else {
        print(response.body);
        if (!Get.isDialogOpen && !Get.isSnackbarOpen) {
          Get.snackbar(
            "Gagal menghapus kategori",
            "Silahkan coba kembali",
            barBlur: 8,
            overlayBlur: 1.5,
          );
        }
      }
      var jsonString = response.body;
      return json.decode(jsonString);
    }
    EasyLoading.dismiss();
    noInternet();
    return null;
  }

  static Future<Map<String, dynamic>> updateCategory(
      int categoryId, String slug) async {
    bool isHaveConnection = await CheckConnection.checkConnection();
    if (isHaveConnection) {
      print("updating category");
      var response = await http.put(
        apiUrl + "categories/$categoryId",
        headers: {
          'Accept': 'application/json',
          'Authorization': 'Bearer ${UserController.token.value}',
        },
        body: {
          "slug": slug,
        },
      );
      print("got response from update category function in services module");

      if (response.statusCode == 200) {
        print("Success");
      } else {
        print(response.body);
        if (!Get.isDialogOpen && !Get.isSnackbarOpen) {
          Get.snackbar(
            "Gagal memperbarui kategori",
            "Silahkan coba kembali",
            barBlur: 8,
            overlayBlur: 1.5,
          );
        }
      }
      var jsonString = response.body;
      return json.decode(jsonString);
    }
    EasyLoading.dismiss();
    noInternet();
    return null;
  }
}
