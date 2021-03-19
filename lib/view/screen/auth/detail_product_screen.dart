import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:storedoor/constants.dart';
import 'package:storedoor/controllers/cart_controller.dart';
import 'package:storedoor/helper/image_from_base64.dart';
import 'package:storedoor/models/CartItem.dart';
import 'package:storedoor/models/Product.dart';
import 'package:storedoor/size_config.dart';

class DetailProductScreen extends StatelessWidget {
  DetailProductScreen({@required this.product});
  final Product product;

  final CartController cartController =
      Get.find<CartController>(tag: "cart-controller");

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar(context),
      body: ListView(
        padding: EdgeInsets.only(bottom: getProportionateScreenHeight(40)),
        shrinkWrap: true,
        children: [
          CustomPaint(
            painter: MyPainter(),
            child: Container(
              height: getProportionateScreenHeight(250),
              padding: EdgeInsets.only(
                top: getProportionateScreenHeight(
                  SizeConfig.screenHeight * 0.03,
                ),
                left: getProportionateScreenWidth(20),
                right: getProportionateScreenWidth(20),
              ),
              child: Hero(
                tag: product.id.toString(),
                child: imageFromBase64String(
                  product.img,
                  fit: BoxFit.contain,
                ),
              ),
            ),
          ),
          SizedBox(
            height: getProportionateScreenHeight(70),
          ),
          Container(
            padding: EdgeInsets.symmetric(
                horizontal: getProportionateScreenWidth(25)),
            child: Column(
              children: [
                Text(
                  product.title,
                  style: TextStyle(
                    color: mPrimaryTextColor,
                    fontWeight: FontWeight.w700,
                    fontSize: 24,
                  ),
                  textAlign: TextAlign.center,
                ),
                SizedBox(
                  height: getProportionateScreenHeight(10),
                ),
                Text(
                  "Category : ${product.categoryName}",
                ),
                SizedBox(
                  height: getProportionateScreenHeight(30),
                ),
                Text(
                  "${product.description}",
                  style: GoogleFonts.poppins(
                    color: mPrimaryColor,
                  ),
                )
              ],
            ),
          )
        ],
      ),
      bottomNavigationBar: Padding(
        padding: EdgeInsets.symmetric(
          vertical: getProportionateScreenWidth(10),
          horizontal: getProportionateScreenWidth(15),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              "${product.normalCurrencyPriceFormatted}",
              style: TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.w700,
                fontSize: 18,
              ),
            ),
            Container(
              child: Obx(() {
                CartItem cart = cartController.carts.firstWhere(
                  (c) => c.product.id == product.id,
                  orElse: () => null,
                );
                int total = cart?.count ?? 0;

                return total <= 0
                    ? ElevatedButton(
                        onPressed: () {
                          cartController.addToCart(product.id);
                        },
                        child: Text(
                          "Tambahkan ke Keranjang",
                          style: TextStyle(
                            fontSize: 14,
                          ),
                        ),
                        style: ButtonStyle(
                          backgroundColor:
                              MaterialStateProperty.all(oPrimaryColor),
                        ),
                      )
                    : ElevatedButton(
                        onPressed: () {
                          cartController.removeProductFromCart(product.id);
                          Get.snackbar(
                            "Success",
                            "Product telah dihapus dari Keranjang",
                            snackPosition: SnackPosition.TOP,
                            dismissDirection: SnackDismissDirection.HORIZONTAL,
                            animationDuration: Duration(milliseconds: 500),
                            isDismissible: true,
                            duration: Duration(milliseconds: 1200),
                            overlayBlur: 1,
                            barBlur: 10,
                          );
                        },
                        child: Text(
                          "Hapus dari Keranjang",
                          style: TextStyle(
                            fontSize: 14,
                            color: Colors.white,
                          ),
                        ),
                        style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.all(
                              kSecondaryColor.withOpacity(0.9)),
                        ),
                      );
              }),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildAppBar(BuildContext context) {
    return AppBar(
      leading: IconButton(
        icon: Icon(Icons.arrow_back_ios_rounded),
        onPressed: () => Get.back(),
      ),
      backgroundColor: Colors.transparent,
    );
  }
}

class MyPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = new Paint()..color = Color.fromRGBO(248, 248, 248, 1);
    paint.style = PaintingStyle.fill;

    final path = new Path();
    path.moveTo(
        0, getProportionateScreenHeight(SizeConfig.screenHeight * 0.35));
    path.quadraticBezierTo(
      size.width / 2,
      getProportionateScreenHeight(SizeConfig.screenHeight * 0.38),
      size.width,
      getProportionateScreenHeight(SizeConfig.screenHeight * 0.35),
    );
    path.lineTo(size.width, 0);
    path.lineTo(0.0, 0);
    path.close();

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
