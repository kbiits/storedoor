import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:storedoor/controllers/favorite_product_controller.dart';
import 'package:storedoor/size_config.dart';
import 'package:storedoor/view/screen/auth/widgets/list_product_widget.dart';

class BodyFavoriteScreen extends StatelessWidget {
  final FavoriteProductController favoriteProductController =
      Get.find<FavoriteProductController>(tag: "favorite-product-controller");

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Padding(
        padding: EdgeInsets.symmetric(
          horizontal: getProportionateScreenWidth(20),
          vertical: getProportionateScreenHeight(20)
        ),
        child: favoriteProductController.favoriteProducts.length <= 0
            ? AlertDialog(
                content: Text(
                  "Tidak ada produk favorit",
                  style: TextStyle(fontSize: 16, color: Colors.black),
                ),
                actions: [
                  // ignore: deprecated_member_use
                  FlatButton(
                      onPressed: () => Get.back(), child: Text("Kembali")),
                ],
              )
            : ListView.builder(
                itemCount: favoriteProductController.favoriteProducts.length,
                itemBuilder: (context, index) => ListProductWidget(
                  product: favoriteProductController.favoriteProducts[index],
                  dismissible: true,
                ),
              ),
      ),
    );
  }
}
