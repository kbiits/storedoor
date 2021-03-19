import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:storedoor/controllers/bottom_navbar_controller.dart';
import 'package:storedoor/controllers/product_controller.dart';
import 'package:storedoor/controllers/user_controller.dart';
import 'package:storedoor/enums.dart';
import 'package:storedoor/size_config.dart';
import 'package:storedoor/view/screen/auth/widgets/list_product_widget.dart';

class SellerOptionScreen extends StatelessWidget {
  final ProductController productController =
      Get.find<ProductController>(tag: "product-controller");

  final BottomNavbarController bottomNavbarController =
      Get.put(BottomNavbarController());

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: getProportionateScreenWidth(20),
        vertical: getProportionateScreenHeight(20),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.max,
        children: [
          Expanded(
            child: Obx(
              () {
                final productsWithSpecificUser = ProductController.products
                    .where((p) => p.userId == UserController.id.value)
                    .toList();
                return productsWithSpecificUser.length > 0
                    ? ListView.builder(
                        shrinkWrap: true,
                        itemBuilder: (context, index) {
                          return ListProductWidget(
                            product: productsWithSpecificUser[index],
                            dismissible: false,
                            sellerOptions: true,
                          );
                        },
                        itemCount: productsWithSpecificUser.length,
                      )
                    : Padding(
                        padding: EdgeInsets.all(
                          getProportionateScreenWidth(20),
                        ),
                        child: Center(
                          child: Material(
                            elevation: 10,
                            child: Container(
                              height: getProportionateScreenHeight(
                                  SizeConfig.screenHeight * 0.25),
                              padding: EdgeInsets.symmetric(
                                vertical: getProportionateScreenHeight(30),
                                horizontal: getProportionateScreenWidth(20),
                              ),
                              child: Column(
                                children: [
                                  Text(
                                    "Anda belum memiliki product untuk dijual, silahkan tambahkan terlebih dahulu",
                                    textAlign: TextAlign.center,
                                    style: GoogleFonts.montserrat(
                                      color: Colors.black,
                                      fontSize: 16,
                                    ),
                                  ),
                                  SizedBox(
                                    height: getProportionateScreenHeight(10),
                                  ),
                                  // ignore: deprecated_member_use
                                  FlatButton(
                                    onPressed: () {
                                      bottomNavbarController.selectedMenu =
                                          ScreenBottomBar.add_product;
                                    },
                                    child: Text(
                                      "Tambahkan Product",
                                      style: TextStyle(
                                        color: Colors.blue,
                                        fontSize: 14,
                                      ),
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ),
                        ),
                      );
              },
            ),
          )
        ],
      ),
    );
  }
}
