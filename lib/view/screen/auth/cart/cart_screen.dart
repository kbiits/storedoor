import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:storedoor/controllers/cart_controller.dart';
import 'package:storedoor/size_config.dart';
import 'package:storedoor/view/screen/auth/cart/widgets/body_cart_screen.dart';
import 'package:storedoor/view/screen/auth/cart/widgets/checkout_widget.dart';

class CartScreen extends StatelessWidget {
  final CartController cartController =
      Get.find<CartController>(tag: 'cart-controller');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar(context),
      body: BodyCartScreen(),
      bottomNavigationBar: CheckoutWidget(),
    );
  }

  Widget buildAppBar(BuildContext context) {
    return PreferredSize(
      preferredSize: Size.fromHeight(getProportionateScreenHeight(60)),
      child: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios_rounded),
          onPressed: () {
            Get.back();
          },
        ),
        title: Padding(
          padding:
              EdgeInsets.symmetric(horizontal: getProportionateScreenWidth(20)),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Your Cart",
                style: TextStyle(color: Colors.black),
              ),
              Obx(
                () => Text(
                  "${cartController.carts.fold(0, (previousValue, element) => previousValue + element.count)} items",
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
