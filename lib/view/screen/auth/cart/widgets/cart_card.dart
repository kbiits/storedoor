import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:storedoor/constants.dart';
import 'package:storedoor/controllers/cart_controller.dart';
import 'package:storedoor/controllers/favorite_product_controller.dart';
import 'package:storedoor/helper/image_from_base64.dart';
import 'package:storedoor/models/CartItem.dart';
import 'package:storedoor/size_config.dart';
import 'package:storedoor/view/screen/auth/cart/widgets/circle_icon_button_widget.dart';
import 'package:intl/intl.dart';

class CartCard extends StatelessWidget {
  CartCard({
    Key key,
    @required this.idx,
  }) : super(key: key);

  final CartController cartController =
      Get.find<CartController>(tag: 'cart-controller');

  final FavoriteProductController favoriteProductController =
      Get.find<FavoriteProductController>(tag: "favorite-product-controller");

  final int idx;
  final compactCurrency = new NumberFormat.compactCurrency(
      locale: 'id', decimalDigits: 2, symbol: "Rp ");

  @override
  Widget build(BuildContext context) {
    final CartItem item = cartController.carts[idx];
    return Material(
      elevation: 10,
      borderRadius: BorderRadius.circular(getProportionateScreenWidth(15)),
      shadowColor: Colors.white60,
      child: Container(
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              width: getProportionateScreenWidth(120),
              height: getProportionateScreenHeight(155),
              child: AspectRatio(
                aspectRatio: 1.05,
                child: Container(
                  // padding: EdgeInsets.all(getProportionateScreenWidth(5)),
                  decoration: BoxDecoration(
                    // color: Color(0xFFF5F6F9),
                    // color: pPrimaryColor,
                    borderRadius: BorderRadius.circular(20),
                    // shape: BoxShape.circle,
                  ),
                  child: imageFromBase64String(
                    item.product.img,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
            SizedBox(width: 20),
            Container(
              margin: EdgeInsets.symmetric(
                  vertical: getProportionateScreenHeight(15)),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    width: getProportionateScreenWidth(150),
                    child: Text(
                      item.product.title,
                      style: TextStyle(color: Colors.black, fontSize: 16),
                      maxLines: 3,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  SizedBox(height: 10),
                  Text.rich(
                    TextSpan(
                      text:
                          "${compactCurrency.format(double.parse(item.product.price))} ",
                      children: [
                        WidgetSpan(
                          child: SizedBox(
                            width: getProportionateScreenWidth(5),
                          ),
                        ),
                        TextSpan(
                          text: "x${item.count}",
                          style: GoogleFonts.poppins(
                            color: Colors.black,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ],
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                        color: kPrimaryColor,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: getProportionateScreenHeight(20),
                  ),
                  Container(
                    child: Row(
                      children: [
                        CircleIconButton(
                          svgAsset: SvgPicture.asset("assets/icons/minus.svg"),
                          onPressed: () {
                            cartController.removeFromCart(item.product.id);
                          },
                        ),
                        SizedBox(
                          width: getProportionateScreenWidth(50),
                          child: Text(
                            "${item.count}",
                            textAlign: TextAlign.center,
                            style: GoogleFonts.montserrat(
                                color: mPrimaryTextColor, fontSize: 18),
                          ),
                        ),
                        CircleIconButton(
                          svgAsset: SvgPicture.asset(
                            "assets/icons/plus.svg",
                          ),
                          onPressed: () {
                            cartController.addToCart(item.product.id);
                          },
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // Container(
                  //   height: getProportionateScreenHeight(50),
                  //   width: getProportionateScreenWidth(50),
                  //   child: PopupMenuButton(
                  //     child: Container(
                  //       // margin: EdgeInsets.symmetric(
                  //       // horizontal: getProportionateScreenWidth(20),
                  //       // vertical: getProportionateScreenHeight(20),
                  //       // ),
                  //       alignment: Alignment.center,
                  //       child: SvgPicture.asset(
                  //         "assets/icons/dotted-settings.svg",
                  //       ),
                  //     ),
                  //     shape: RoundedRectangleBorder(
                  //         borderRadius: BorderRadius.circular(13)),
                  //     offset: Offset(getProportionateScreenWidth(-45),
                  //         getProportionateScreenHeight(-50)),
                  //     tooltip: "Show options",
                  //     // padding: EdgeInsets.zero,
                  //     onSelected: (value) => value == 0
                  //         ? print("add to favorites")
                  //         : cartController
                  //             .removeProductFromCart(item.product.id),
                  //     itemBuilder: (context) => List.generate(
                  //       2,
                  //       (index) => index == 0
                  //           ? PopupMenuItem(
                  //               height: 45,
                  //               value: 0,
                  //               child: Container(
                  //                 width: getProportionateScreenWidth(126),
                  //                 child: Text(
                  //                   "Add to favorites",
                  //                   style: GoogleFonts.poppins(
                  //                     fontSize: 12,
                  //                   ),
                  //                   textAlign: TextAlign.center,
                  //                 ),
                  //               ),
                  //             )
                  //           // : index == 1
                  //           //     ? PopupMenuItem(
                  //           //         child: Divider(
                  //           //           color: Colors.grey[300],
                  //           //           thickness: 0.7,
                  //           //           height: 5,
                  //           //         ),
                  //           //       )
                  //           : PopupMenuItem(
                  //               height: 45,
                  //               value: 1,
                  //               child: Container(
                  //                 width: getProportionateScreenWidth(126),
                  //                 child: Text(
                  //                   "Delete from cart",
                  //                   style: GoogleFonts.poppins(
                  //                     fontSize: 12,
                  //                   ),
                  //                   textAlign: TextAlign.center,
                  //                 ),
                  //               ),
                  //             ),
                  //     ),
                  //   ),
                  // ),
                  Container(
                    height: getProportionateScreenHeight(35),
                    width: getProportionateScreenWidth(35),
                    margin: EdgeInsets.only(
                      right: getProportionateScreenWidth(15),
                      top: getProportionateScreenHeight(10),
                    ),
                    child: Obx(
                      () => CircleIconButton(
                        svgAsset: SvgPicture.asset(
                          favoriteProductController.isFavorite(item.product.id)
                              ? "assets/icons/favorite3.svg"
                              : "assets/icons/favorite2.svg",
                          width: 20,
                          color: oPrimaryColor,
                        ),
                        onPressed: () {
                          favoriteProductController.isFavorite(item.product.id)
                              ? favoriteProductController
                                  .removeFromFavorite(item.product.id)
                              : favoriteProductController
                                  .addToFavorite(item.product.id);
                        },
                      ),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(
                        right: getProportionateScreenWidth(12),
                        top: getProportionateScreenHeight(17)),
                    height: getProportionateScreenHeight(38),
                    width: getProportionateScreenWidth(4.1),
                    decoration: BoxDecoration(
                      color: Color(0xDD9B9B9B),
                      borderRadius: BorderRadius.circular(
                        getProportionateScreenWidth(10),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
