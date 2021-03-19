import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
// import 'package:shop_app/screens/details/details_screen.dart';
import 'package:storedoor/constants.dart';
import 'package:storedoor/controllers/favorite_product_controller.dart';
import 'package:storedoor/helper/image_from_base64.dart';
import 'package:storedoor/models/Product.dart';
import 'package:storedoor/size_config.dart';
import 'package:storedoor/view/screen/auth/cart/widgets/circle_icon_button_widget.dart';
import 'package:storedoor/view/screen/auth/detail_product_screen.dart';

class ProductCard extends StatelessWidget {
  ProductCard({
    Key key,
    this.width = 150,
    this.aspectRetio = 0.8,
    @required this.product,
  }) : super(key: key);

  final double width, aspectRetio;
  final Product product;
  final FavoriteProductController favoriteProductController =
      Get.find<FavoriteProductController>(tag: "favorite-product-controller");

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: getProportionateScreenWidth(20))
          .copyWith(top: getProportionateScreenHeight(15)),
      width: getProportionateScreenWidth(width),
      child: GestureDetector(
        onTap: () => Get.to(() => DetailProductScreen(product: product)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              decoration: BoxDecoration(
                boxShadow: [
                  BoxShadow(
                      color: Colors.grey[200],
                      offset: Offset(5, 5),
                      blurRadius: 20,
                      spreadRadius: 5)
                ],
              ),
              child: Stack(
                children: [
                  AspectRatio(
                    aspectRatio: this.aspectRetio,
                    child: Container(
                      padding: EdgeInsets.all(getProportionateScreenWidth(15)),
                      decoration: BoxDecoration(
                        color: Colors.white60,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: imageFromBase64String(
                        product.img,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  // This is favourite button
                  Positioned(
                    bottom: getProportionateScreenWidth(10),
                    right: getProportionateScreenHeight(10),
                    child: Obx(
                      () => CircleIconButton(
                        padding: EdgeInsets.all(8),
                        svgAsset: SvgPicture.asset(
                          favoriteProductController.isFavorite(product.id)
                              ? "assets/icons/favorite3.svg"
                              : "assets/icons/favorite2.svg",
                          color: oPrimaryColor,
                        ),
                        onPressed: () {
                          favoriteProductController.isFavorite(product.id)
                              ? favoriteProductController
                                  .removeFromFavorite(product.id)
                              : favoriteProductController
                                  .addToFavorite(product.id);
                        },
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 10),
            Text(
              product.title,
              style: TextStyle(color: Colors.black),
              maxLines: 2,
            ),
            SizedBox(
              height: getProportionateScreenHeight(5),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "${product.priceFormatted}",
                  style: TextStyle(
                    fontSize: getProportionateScreenWidth(18),
                    fontWeight: FontWeight.w600,
                    color: mPrimaryColor,
                  ),
                ),
                RatingBarIndicator(
                  itemBuilder: (_, i) => Icon(
                    Icons.star,
                    color: kPrimaryColor,
                  ),
                  itemSize: getProportionateScreenWidth(15),
                  rating: product.rating,
                  unratedColor: Colors.grey[350],
                ),
                // // This is favourite button
                // InkWell(
                //   borderRadius: BorderRadius.circular(50),
                //   onTap: () {},
                //   child: Container(
                //     padding: EdgeInsets.all(getProportionateScreenWidth(8)),
                //     height: getProportionateScreenWidth(38),
                //     width: getProportionateScreenWidth(33),
                //     decoration: BoxDecoration(
                //       color:
                //           // product.isFavourite
                //           // ?
                //           pPrimaryColor.withOpacity(0.05),
                //       // Colors.transparent,
                //       // : kSecondaryColor.withOpacity(0.1),
                //       shape: BoxShape.circle,
                //     ),
                //     child: SvgPicture.asset("assets/icons/favorite.svg",
                //         color:
                //             // product.isFavourite
                //             // ?
                //             pPrimaryColor
                //         // Color(0xFFFF4848)
                //         // : Color(0xFFDBDEE4),
                //         ),
                //   ),
                // ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
