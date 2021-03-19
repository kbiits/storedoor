import 'package:cool_alert/cool_alert.dart';
import 'package:get/get.dart';
import 'package:storedoor/controllers/product_controller.dart';
import 'package:storedoor/models/Product.dart';
import 'package:storedoor/services/favorite_services.dart';
import 'package:storedoor/view/widgets/no_internet.dart';

class FavoriteProductController extends GetxController {
  var favoriteProducts = <Product>[].obs;

  static var totalItemInFavoriteList = 0.obs;

  Future<Null> fetchData() async {
    var jsonString = await FavoriteServices.fetchData();
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

    // Clear old data
    favoriteProducts.clear();
    // print(jsonString["data"]["products"]);
    // add new data
    jsonString["data"]["products"].forEach((e) {
      favoriteProducts.add(Product.fromJson(e));
    });
    totalItemInFavoriteList.value = favoriteProducts.length;
    print("Selesai fetch data for favorite products");
  }

  Future<Null> removeFromFavorite(int productId) async {
    favoriteProducts.removeWhere((element) => element.id == productId);
    totalItemInFavoriteList.value = favoriteProducts.length;
    
    var jsonString = await FavoriteServices.removeFromFavorite(productId);
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

    print("Selesai remove product dari favorite list");
  }

  Future<Null> addToFavorite(int productId) async {
    favoriteProducts.add(
      ProductController.products
          .firstWhere((element) => element.id == productId),
    );
    totalItemInFavoriteList.value = favoriteProducts.length;
    var jsonString = await FavoriteServices.addToFavorite(productId);
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

    print("Selesai menambahkan product ke favorite list");
  }

  bool isFavorite(int productId) {
    var a = favoriteProducts.firstWhere((element) => element.id == productId,
        orElse: () => null);

    if (a != null)
      return true;
    else
      return false;
  }
}
