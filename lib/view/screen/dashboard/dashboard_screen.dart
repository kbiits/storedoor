import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:storedoor/constants.dart';
import 'package:storedoor/controllers/cart_controller.dart';
import 'package:storedoor/controllers/category_controller.dart';
import 'package:storedoor/controllers/favorite_product_controller.dart';
import 'package:storedoor/controllers/product_controller.dart';
import 'package:storedoor/view/screen/auth/home_screen/customer_home_screen.dart';
import 'package:storedoor/view/screen/auth/home_screen/seller_home_screen.dart';
import 'package:storedoor/view/widgets/black_button.dart';

class DashboardScreen extends StatelessWidget {
  final ProductController productController =
      Get.put(ProductController(), tag: "product-controller");

  final CartController cartController =
      Get.put(CartController(), tag: "cart-controller");

  final FavoriteProductController favoriteProductController =
      Get.put(FavoriteProductController(), tag: "favorite-product-controller");

  final CategoryController categoryController =
      Get.put(CategoryController(), tag: "category-controller");

  @override
  Widget build(BuildContext context) {
    final fetchProducts = productController.fetchProducts();
    final fetchCart = cartController.fetchData();
    final fetchFavoriteData = favoriteProductController.fetchData();
    final fetchCategories = categoryController.fetchData();
    return FutureBuilder(
        future: Future.wait(
            [fetchCart, fetchProducts, fetchFavoriteData, fetchCategories]),
        builder: (context, snapshot) {
          return snapshot.connectionState == ConnectionState.waiting
              ? Container(
                  color: Colors.white,
                  child: Center(
                    child: CircularProgressIndicator(),
                  ),
                )
              : snapshot.hasError
                  ? Get.dialog(
                      Container(
                        color: Colors.white,
                        child: Center(
                          child: Text(
                              "Terjadi kesalahan, silahkan restart aplikasi"),
                        ),
                      ),
                      barrierDismissible: true,
                      transitionDuration: Duration(milliseconds: 500),
                    )
                  :
                  // return
                  Scaffold(
                      body: Container(
                        child: ListView(
                          shrinkWrap: true,
                          children: [
                            Image.asset(
                              'assets/images/695.jpg',
                              height: MediaQuery.of(context).size.height * 0.35,
                              width: MediaQuery.of(context).size.width * 0.7,
                              fit: BoxFit.fitWidth,
                            ),
                            // SizedBox(
                            // height: 20,
                            // ),
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 30, vertical: 30),
                              child: Text(
                                'Silahkan masuk sebagai Pembeli atau Penjual',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  color: mPrimaryTextColor,
                                  fontSize: 28,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.symmetric(vertical: 30),
                              child: BlackButton(
                                hintButton: "Seller",
                                onPressed: () {
                                  Get.to(() => SellerHomeScreen());
                                },
                              ),
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 30),
                              // ignore: deprecated_member_use
                              child: FlatButton(
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(36),
                                    side: BorderSide(color: mPrimaryColor)),
                                onPressed: () {
                                  Get.to(() => CustomerHomeScreen());
                                },
                                child: Container(
                                  padding:
                                      const EdgeInsets.symmetric(vertical: 16),
                                  alignment: Alignment.center,
                                  width: double.infinity,
                                  child: Text(
                                    'Customer',
                                    style: TextStyle(
                                      color: mPrimaryColor,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
        });
  }
}
