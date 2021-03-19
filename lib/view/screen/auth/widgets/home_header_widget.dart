import 'package:flutter/material.dart';
// import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:storedoor/controllers/cart_controller.dart';
import 'package:storedoor/controllers/favorite_product_controller.dart';
import 'package:storedoor/size_config.dart';
import 'package:storedoor/view/screen/auth/cart/cart_screen.dart';
import 'package:storedoor/view/screen/auth/favorites/favorite_screen.dart';
// import 'package:storedoor/view/screen/auth/widgets/categories_widget.dart';
import 'package:storedoor/view/screen/auth/widgets/icon_with_counter.dart';
import 'package:storedoor/view/screen/auth/widgets/search_field.dart';

class HomeHeaderWidget extends StatelessWidget {
  HomeHeaderWidget({
    Key key,
    this.forSellerScreen = false,
  }) : super(key: key);
  final CartController cartController =
      Get.find<CartController>(tag: "cart-controller");

  final bool forSellerScreen;

  final FavoriteProductController favoriteProductController =
      Get.find<FavoriteProductController>(tag: "favorite-product-controller");

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:
          EdgeInsets.symmetric(horizontal: getProportionateScreenWidth(20)),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          SearchField(
            forSellerScreen: forSellerScreen,
          ),
          if (!forSellerScreen)
            Obx(
              () => IconWithCounter(
                svgSrc: "assets/icons/Cart.svg",
                // press: () => Navigator.pushNamed(context, CartScreen.routeName),
                press: () {
                  Get.to(() => CartScreen());
                },
                numOfitem: cartController.carts
                    .fold(0, (sum, item) => sum + item.count),
              ),
            ),
          Obx(
            () => IconWithCounter(
              svgSrc: "assets/icons/favorite.svg",
              press: () {
                Get.to(() => FavoriteScreen());
              },
              numOfitem: favoriteProductController.favoriteProducts.length,
            ),
          )
        ],
      ),
    );
  }
}
