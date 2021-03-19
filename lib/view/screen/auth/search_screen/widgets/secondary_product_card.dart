import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:storedoor/constants.dart';
import 'package:storedoor/controllers/cart_controller.dart';
import 'package:storedoor/helper/image_from_base64.dart';
import 'package:storedoor/models/Product.dart';
import 'package:storedoor/size_config.dart';
import 'package:storedoor/view/screen/auth/cart/widgets/circle_icon_button_widget.dart';
import 'package:storedoor/view/screen/auth/detail_product_screen.dart';

class SecondaryProductCard extends StatelessWidget {
  final Product product;

  SecondaryProductCard({
    @required this.product,
  });

  final CartController cartController =
      Get.find<CartController>(tag: "cart-controller");

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Get.to(() => DetailProductScreen(product: product));
      },
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Stack(
              fit: StackFit.expand,
              children: [
                Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(
                      getProportionateScreenWidth(10),
                    ),
                  ),
                  elevation: 10,
                  shadowColor: Colors.grey,
                  child: ClipRRect(
                    borderRadius:
                        BorderRadius.circular(getProportionateScreenWidth(10)),
                    child: imageFromBase64String(
                      product.img,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                // This is favorite button
                Positioned(
                  bottom: getProportionateScreenWidth(15),
                  right: getProportionateScreenHeight(15),
                  child: CircleIconButton(
                    elevation: 2,
                    width: getProportionateScreenWidth(40),
                    height: getProportionateScreenHeight(40),
                    padding: EdgeInsets.all(getProportionateScreenWidth(11)),
                    bgColor: oPrimaryColor,
                    svgAsset: SvgPicture.asset(
                      "assets/icons/Cart.svg",
                      color: Colors.white,
                    ),
                    onPressed: () {
                      cartController.addToCart(product.id);
                      Get.snackbar(
                          "Success", "Product telah berhasil ditambahkan",
                          snackPosition: SnackPosition.TOP,
                          animationDuration: Duration(milliseconds: 400),
                          isDismissible: true,
                          duration: Duration(milliseconds: 1200),
                          overlayBlur: 1,
                          barBlur: 10);
                    },
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: getProportionateScreenHeight(5)),
          Padding(
            padding: EdgeInsets.symmetric(
                horizontal: getProportionateScreenWidth(5)),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: getProportionateScreenHeight(10),
                ),
                Text("${product.categoryName}"),
                Container(
                  padding: EdgeInsets.symmetric(
                      vertical: getProportionateScreenWidth(5)),
                  child: Text(
                    "${product.title}",
                    maxLines: 3,
                    overflow: TextOverflow.visible,
                    softWrap: true,
                    textAlign: TextAlign.start,
                    style: TextStyle(
                      color: mTitleTextColor,
                      fontWeight: FontWeight.w500,
                      fontSize: 15,
                    ),
                  ),
                ),
                RatingBarIndicator(
                  itemBuilder: (context, rating) => Icon(
                    Icons.star,
                    color: kPrimaryColor,
                  ),
                  itemSize: getProportionateScreenWidth(18),
                  rating: product.rating,
                  unratedColor: Colors.grey[350],
                ),
                Container(
                  child: Text(
                    "${product.priceFormatted}",
                    style: TextStyle(
                      fontSize: getProportionateScreenWidth(18),
                      fontWeight: FontWeight.w600,
                      color: mPrimaryColor,
                    ),
                  ),
                )
              ],
            ),
          )
          // Text(
          //   product.title,
          //   style: TextStyle(color: Colors.black),
          //   maxLines: 2,
          // ),
          // SizedBox(
          //   height: getProportionateScreenHeight(5),
          // ),
          // Row(
          //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
          //   children: [
          //     Text(
          //       "${product.priceFormatted}",
          //       style: TextStyle(
          //         fontSize: getProportionateScreenWidth(18),
          //         fontWeight: FontWeight.w600,
          //         color: mPrimaryColor,
          //       ),
          //     ),
          //     RatingBarIndicator(
          //       itemBuilder: (_, i) => Icon(
          //         Icons.star,
          //         color: kPrimaryColor,
          //       ),
          //       itemSize: getProportionateScreenWidth(15),
          //       rating: product.rating,
          //       unratedColor: Colors.grey[350],
          //     ),
          //   ],
          // )
        ],
      ),
    );
  }
}
