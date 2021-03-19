import 'dart:convert';

import 'package:storedoor/constants.dart';
import 'package:storedoor/controllers/user_controller.dart';
import 'package:storedoor/helper/check_connection.dart';
import 'package:http/http.dart' as http;

class CartServices {
  static Future<Map<String, dynamic>> fetchCartData() async {
    bool isHaveConnection = await CheckConnection.checkConnection();
    if (isHaveConnection) {
      print("fetching cart data");
      var response = await http.get(
        apiUrl + "users/${UserController.id.value}/cart",
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

  static Future<Map<String, dynamic>> addToCart(int productId) async {
    bool isHaveConnection = await CheckConnection.checkConnection();
    if (isHaveConnection) {
      print("prepare to adding product to cart");
      var response = await http.post(
          apiUrl + "users/${UserController.id.value}/cart",
          headers: {
            'Accept': 'application/json',
            'Authorization': 'Bearer ${UserController.token.value}',
          },
          body: {
            'product_id': productId.toString(),
          });
      var jsonString = response.body;
      print("got response from adding product to cart");
      return json.decode(jsonString);
    }
    return null;
  }

  static Future<Map<String, dynamic>> removeFromCart(int productId) async {
    bool isHaveConnection = await CheckConnection.checkConnection();
    if (isHaveConnection) {
      print("prepare to removing product from cart");
      var response = await http.delete(
        apiUrl + "users/${UserController.id.value}/cart/$productId",
        headers: {
          'Accept': 'application/json',
          'Authorization': 'Bearer ${UserController.token.value}',
        },
      );
      var jsonString = response.body;
      print("got response of remove product from cart");
      return json.decode(jsonString);
    }
    return null;
  }

  static Future<Map<String, dynamic>> removeProductFromCart(
      int productId) async {
    bool isHaveConnection = await CheckConnection.checkConnection();
    if (isHaveConnection) {
      print("prepare to removing product from cart");
      var response = await http.delete(
        apiUrl + "users/${UserController.id.value}/cart/$productId/all",
        headers: {
          'Accept': 'application/json',
          'Authorization': 'Bearer ${UserController.token.value}',
        },
      );
      var jsonString = response.body;
      print("got response of remove product from cart");
      return json.decode(jsonString);
    }
    return null;
  }
}
