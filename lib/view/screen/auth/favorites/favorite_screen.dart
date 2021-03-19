import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:storedoor/controllers/favorite_product_controller.dart';
import 'package:storedoor/size_config.dart';
import 'package:storedoor/view/screen/auth/favorites/widgets/body_favorite_screen.dart';

class FavoriteScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar(context),
      body: BodyFavoriteScreen(),
    );
  }

  Widget buildAppBar(BuildContext context) {
    final FavoriteProductController favoriteProductController =
        Get.find<FavoriteProductController>(tag: "favorite-product-controller");
    return PreferredSize(
      preferredSize: Size.fromHeight(getProportionateScreenHeight(60)),
      child: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios_rounded),
          onPressed: () => Get.back(),
        ),
        title: Padding(
          padding:
              EdgeInsets.symmetric(horizontal: getProportionateScreenWidth(20)),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Favorite Products",
                style: TextStyle(color: Colors.black),
              ),
              Obx(
                () => Text(
                  "${favoriteProductController.favoriteProducts.length} items",
                  style: Theme.of(context).textTheme.caption,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
