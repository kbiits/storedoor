import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:storedoor/controllers/bottom_navbar_controller.dart';
import 'package:storedoor/controllers/cart_controller.dart';
import 'package:storedoor/controllers/product_controller.dart';
import 'package:storedoor/enums.dart';
import 'package:storedoor/view/screen/auth/profile_screen/profile_screen.dart';
import 'package:storedoor/view/screen/auth/search_screen/search_screen.dart';
import 'package:storedoor/view/screen/auth/widgets/body_home_screen.dart';
import 'package:storedoor/view/widgets/bottom_navbar.dart';

class CustomerHomeScreen extends StatelessWidget {
  final BottomNavbarController bottomNavbarController =
      Get.put(BottomNavbarController());

  final ProductController productController =
      Get.put(ProductController(), tag: "product-controller");

  final CartController cartController =
      Get.put(CartController(), tag: "cart-controller");

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:
          Obx(
        () => SafeArea(
          child: bottomNavbarController.selectedMenu == ScreenBottomBar.home
              ? BodyHomeScreen()
              : bottomNavbarController.selectedMenu == ScreenBottomBar.search
                  ? SearchScreen()
                  : ProfileScreen(),
        ),
        // );
      ),
      // ),
      bottomNavigationBar: Obx(
        () => BottomNavbar(
          selectedMenu: bottomNavbarController.selectedMenu,
          forSeller: false,
        ),
      ),
    );
  }
}
