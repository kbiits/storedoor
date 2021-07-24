import 'dart:async';

import 'package:cool_alert/cool_alert.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:storedoor/controllers/product_controller.dart';
import 'package:storedoor/models/CartItem.dart';
import 'package:storedoor/services/cart_services.dart';
import 'package:storedoor/view/widgets/no_internet.dart';

class CartController extends GetxController {
  final carts = <CartItem>[].obs;
  final _totalPriceInCart = 0.0.obs;
  final formatCurrency = new NumberFormat.compactCurrency(
    locale: "id",
    decimalDigits: 2,
    symbol: "Rp",
  );

  String get totalPriceInCart {
    // fetchData();
    sumTotalPrice();
    return formatCurrency.format(_totalPriceInCart);
  }

  static var totalItemInCart = 0.obs;

  @override
  void onInit() async {
    super.onInit();
  }

  Future<Null> fetchData() async {
    var jsonString = await CartServices.fetchCartData();
    // print(jsonString);
    if (jsonString == null) {
      // CoolAlert.show(
      //   context: Get.context,
      //   type: CoolAlertType.error,
      //   title: "Tidak ada koneksi internet",
      //   text: "Harap coba lagi dan pastikan anda terhubung ke internet",
      // );
      noInternet();
      return;
    }

    // If there's something error, show alert
    if (jsonString["is_error"]) {
      CoolAlert.show(
        context: Get.context,
        type: CoolAlertType.error,
        title: "Error memuat data",
        text: jsonString["message"],
      );
      return;
    }

    // if list of product just contain 1 object, dart detect it as Map, but if list of product contain more than 1 object, dart will cast is as list<dynamic>

    // Check if products from json response contain 1 object or not
    // if (jsonString["data"]["products"] is Map<String, dynamic>) {
    //   print("products from response is map");
    //   Map.of(jsonString["data"]["products"]).entries.forEach((e) {
    //     // print(e.runtimeType);
    //     newData.add(e);
    //   });
    // } else {
    //   newData = jsonString["data"]["products"];
    // }

    // Clear old data
    carts.clear();
    // print(jsonString["data"]["products"]);
    // add new data
    jsonString["data"]["products"].forEach((e) {
      carts.add(CartItem.fromJson(e));
    });

    sumTotalPrice();
    totalItemInCart.value = carts.fold(
        0, (previousValue, element) => element.count + previousValue);
    print("total item in cart " + carts.length.toString());
    print("Selesai fetch cart data");
  }

  void sumTotalPrice() {
    _totalPriceInCart.value = 0;
    carts.forEach(
      (element) {
        _totalPriceInCart.value +=
            double.parse(element.product.price) * element.count;
      },
    );
  }

  addToCart(int productId) async {
    CartItem isAlreadyInCart = carts.firstWhere(
        (element) => element.product.id == productId,
        orElse: () => null);
    if (isAlreadyInCart != null) {
      int idx = carts.indexOf(isAlreadyInCart);
      if (idx >= 0) {
        carts[idx].count += 1;
      }
    } else {
      carts.add(
        CartItem(
          count: 1,
          product: ProductController.products
              .firstWhere((element) => element.id == productId),
        ),
      );
    }
    carts.refresh();
    if (!Get.isSnackbarOpen && !Get.isDialogOpen) {
      Get.snackbar(
        "Success",
        "Product telah ditambahkan ke Keranjang",
        snackPosition: SnackPosition.TOP,
        dismissDirection: SnackDismissDirection.HORIZONTAL,
        animationDuration: Duration(milliseconds: 500),
        isDismissible: true,
        duration: Duration(milliseconds: 1200),
        overlayBlur: 1,
        barBlur: 10,
      );
    }
    var jsonString = await CartServices.addToCart(productId);
    if (jsonString == null) {
      noInternet();
      // CoolAlert.show(
      //   context: Get.context,
      //   type: CoolAlertType.error,
      //   title: "Tidak ada koneksi internet",
      //   text: "Harap coba lagi dan pastikan anda terhubung ke internet",
      // );
      return;
    }

    if (jsonString["is_error"]) {
      CoolAlert.show(
        context: Get.context,
        type: CoolAlertType.error,
        text: "Error memuat data, harap coba lagi",
        title: jsonString["message"],
      );
      return;
    }
    // fetchData();
  }

  void removeFromCart(int productId) async {
    var cart = carts.firstWhere((element) => element.product.id == productId);
    if (cart.count > 1) {
      cart.count -= 1;
    } else {
      removeProductFromCart(productId);
      return;
    }
    carts.refresh();
    var jsonString = await CartServices.removeFromCart(productId);
    if (jsonString == null) {
      noInternet();
      return;
    }

    if (jsonString["is_error"]) {
      CoolAlert.show(
        context: Get.context,
        type: CoolAlertType.error,
        title: "Terjadi kesalahan",
        text: jsonString["message"],
      );
      return;
    }
  }

  void removeProductFromCart(int productId) async {
    var jsonString = await CartServices.removeProductFromCart(productId);
    if (jsonString == null) {
      // CoolAlert.show(
      //   context: Get.context,
      //   type: CoolAlertType.error,
      //   title: "Tidak ada koneksi internet",
      //   text: "Harap coba lagi dan pastikan anda terhubung ke internet",
      // );
      noInternet();
      return;
    }

    if (jsonString["is_error"]) {
      CoolAlert.show(
        context: Get.context,
        type: CoolAlertType.error,
        title: "Terjadi kesalahan",
        text: jsonString["message"],
      );
      return;
    }
    fetchData();
  }
}
