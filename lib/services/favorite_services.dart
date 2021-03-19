import 'dart:convert';

import 'package:storedoor/constants.dart';
import 'package:storedoor/controllers/user_controller.dart';
import 'package:storedoor/helper/check_connection.dart';
import 'package:http/http.dart' as http;

class FavoriteServices {
  static Future<Map<String, dynamic>> fetchData() async {
    bool isHaveConnection = await CheckConnection.checkConnection();
    if (isHaveConnection) {
      print("fetching favorite data");
      var response = await http.get(
        apiUrl + "users/${UserController.id.value}/favorite",
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
          'Authorization': 'Bearer ${UserController.token.value}',
        },
      );
      var jsonString = response.body;
      print("got response from fetch favorite data");
      return json.decode(jsonString);
    }
    return null;
  }

  static Future<Map<String, dynamic>> removeFromFavorite(int productId) async {
    bool isHaveConnection = await CheckConnection.checkConnection();
    if (isHaveConnection) {
      print("removing from favorite");
      var response = await http.delete(
        apiUrl + "users/${UserController.id.value}/favorite/$productId",
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
          'Authorization': 'Bearer ${UserController.token.value}',
        },
      );
      var jsonString = response.body;
      print("got response from remove favorite product");
      return json.decode(jsonString);
    }
    return null;
  }

  static Future<Map<String, dynamic>> addToFavorite(int productId) async {
    bool isHaveConnection = await CheckConnection.checkConnection();
    if (isHaveConnection) {
      print("adding to favorite");
      var response = await http.post(
        apiUrl + "users/${UserController.id.value}/favorite",
        headers: {
          'Accept': 'application/json',
          'Authorization': 'Bearer ${UserController.token.value}',
        },
        body: {
          "product_id": productId.toString(),
        },
      );
      var jsonString = response.body;
      print("got response from adding favorite product service");
      return json.decode(jsonString);
    }
    return null;
  }
}
