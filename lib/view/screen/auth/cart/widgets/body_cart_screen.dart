import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:storedoor/constants.dart';
import 'package:storedoor/controllers/cart_controller.dart';
import 'package:storedoor/size_config.dart';
import 'package:storedoor/view/screen/auth/cart/widgets/cart_card.dart';

class BodyCartScreen extends StatelessWidget {
  final CartController cartController =
      Get.find<CartController>(tag: "cart-controller");

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:
          EdgeInsets.symmetric(horizontal: getProportionateScreenWidth(20)),
      child: Obx(
        () => cartController.carts.length <= 0
            ? AlertDialog(
                title: Text("Cart kosong"),
                actions: [
                  // ignore: deprecated_member_use
                  FlatButton(
                      onPressed: () => Get.back(), child: Text("Kembali")),
                ],
              )
            : ListView.builder(
                itemCount: cartController.carts.length,
                itemBuilder: (context, index) => Padding(
                  padding:
                      EdgeInsets.symmetric(vertical: 20).copyWith(right: 0),
                  child: Dismissible(
                    key: Key(cartController.carts[index].product.id.toString()),
                    direction: DismissDirection.endToStart,
                    onDismissed: (direction) {
                      cartController.removeProductFromCart(
                          cartController.carts[index].product.id);
                    },
                    background: Container(
                      padding: EdgeInsets.symmetric(horizontal: 20),
                      decoration: BoxDecoration(
                        color: pPrimaryColor.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(15),
                      ),
                      child: Row(
                        children: [
                          Spacer(),
                          SvgPicture.asset(
                            "assets/icons/Trash.svg",
                            color: pPrimaryColor,
                          ),
                        ],
                      ),
                    ),
                    child: Container(
                      child: CartCard(
                        idx: index,
                        // product: cartController.carts[index].product,
                      ),
                    ),
                  ),
                ),
              ),
      ),
    );
  }
}
