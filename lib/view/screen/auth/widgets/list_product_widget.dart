import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:storedoor/constants.dart';
import 'package:storedoor/controllers/cart_controller.dart';
import 'package:storedoor/controllers/favorite_product_controller.dart';
import 'package:storedoor/controllers/product_controller.dart';
import 'package:storedoor/helper/image_from_base64.dart';
import 'package:storedoor/models/Product.dart';
import 'package:storedoor/size_config.dart';
import 'package:storedoor/view/screen/auth/cart/widgets/circle_icon_button_widget.dart';
import 'package:storedoor/view/screen/auth/detail_product_screen.dart';
import 'package:storedoor/view/screen/auth/update_product_screen.dart';

class ListProductWidget extends StatelessWidget {
  final Product product;

  ListProductWidget(
      {@required this.product,
      this.dismissible = true,
      this.sellerOptions = false});

  final CartController cartController =
      Get.find<CartController>(tag: "cart-controller");

  final ProductController productController =
      Get.find<ProductController>(tag: "product-controller");

  final bool dismissible;
  final bool sellerOptions;

  @override
  Widget build(BuildContext context) {
    FavoriteProductController favoriteProductController;
    if (dismissible) {
      favoriteProductController = Get.find<FavoriteProductController>(
          tag: "favorite-product-controller");
    }
    return GestureDetector(
      onTap: () => Get.to(() => DetailProductScreen(product: product)),
      child: Container(
          height: getProportionateScreenHeight(143),
          decoration: BoxDecoration(
            borderRadius:
                BorderRadius.circular(getProportionateScreenWidth(10)),
          ),
          margin: EdgeInsets.only(
            top: getProportionateScreenHeight(15),
            right: getProportionateScreenWidth(5),
          ),
          child: Material(
            borderRadius:
                BorderRadius.circular(getProportionateScreenWidth(10)),
            elevation: 12,
            shadowColor: Colors.white54,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(getProportionateScreenWidth(10)),
                    bottomLeft:
                        Radius.circular(getProportionateScreenWidth(10)),
                  ),
                  child: Hero(
                    transitionOnUserGestures: true,
                    tag: product.id.toString(),
                    child: imageFromBase64String(
                      product.img,
                      fit: BoxFit.cover,
                      height: getProportionateScreenHeight(150),
                      width: getProportionateScreenWidth(120),
                    ),

                    // Image(
                    // height: getProportionateScreenHeight(150),
                    // width: getProportionateScreenWidth(120),
                    // image: NetworkImage(product.img),
                    // fit: BoxFit.cover,
                    // ),
                  ),
                ),
                SizedBox(
                  width: getProportionateScreenWidth(20),
                ),
                Expanded(
                  child: Container(
                    padding: EdgeInsets.symmetric(
                            vertical: getProportionateScreenHeight(20))
                        .copyWith(
                      right: getProportionateScreenWidth(20),
                    ),
                    child: Stack(
                      fit: StackFit.loose,
                      children: [
                        // Check if widget dismissible
                        this.dismissible
                            ? Positioned(
                                top: 0,
                                right: 0,
                                child: InkWell(
                                  onTap: this.dismissible
                                      ? () {
                                          favoriteProductController
                                              .removeFromFavorite(product.id);
                                        }
                                      : () {},
                                  child: SvgPicture.asset(
                                    "assets/icons/cross.svg",
                                    width: getProportionateScreenWidth(18),
                                    height: getProportionateScreenHeight(18),
                                  ),
                                ),
                              )
                            : this.sellerOptions
                                ? Positioned(
                                    top: 0,
                                    right: 0,
                                    child: InkWell(
                                      onTap: this.dismissible
                                          ? () {
                                              favoriteProductController
                                                  .removeFromFavorite(
                                                product.id,
                                              );
                                            }
                                          : this.sellerOptions
                                              ? () =>
                                                  Get.to(UpdateProductScreen(
                                                    product: product,
                                                  ))
                                              : () {},
                                      child: Icon(
                                        Icons.edit_sharp,
                                        size: getProportionateScreenWidth(18),
                                      ),
                                    ),
                                  )
                                : SizedBox(
                                    height: 0,
                                    width: 0,
                                  ),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: EdgeInsets.only(
                                right: getProportionateScreenWidth(25),
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Text(
                                    product.categoryName,
                                    maxLines: 1,
                                    overflow: TextOverflow.visible,
                                    style: TextStyle(fontSize: 12),
                                  ),
                                  SizedBox(
                                    height: getProportionateScreenHeight(7),
                                  ),
                                  Text(
                                    product.title,
                                    maxLines: 2,
                                    overflow: TextOverflow.visible,
                                    style: TextStyle(
                                      fontSize: 15,
                                      color: mPrimaryColor,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(
                              height: getProportionateScreenHeight(5),
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    RatingBarIndicator(
                                      itemSize: getProportionateScreenWidth(18),
                                      itemBuilder: (context, _) {
                                        return Icon(
                                          Icons.star,
                                          color: kPrimaryColor,
                                        );
                                      },
                                      rating: product.rating,
                                      unratedColor: Colors.grey[350],
                                    ),
                                    Text(
                                      product.priceFormatted,
                                      maxLines: 2,
                                      overflow: TextOverflow.visible,
                                      style: TextStyle(
                                        color: Colors.black,
                                        fontWeight: FontWeight.w700,
                                      ),
                                    ),
                                  ],
                                ),
                                if (!sellerOptions)
                                  CircleIconButton(
                                    elevation: 2,
                                    width: getProportionateScreenWidth(35),
                                    height: getProportionateScreenHeight(35),
                                    padding: EdgeInsets.all(
                                        getProportionateScreenWidth(8)),
                                    bgColor: oPrimaryColor,
                                    svgAsset: SvgPicture.asset(
                                      "assets/icons/cart.svg",
                                      color: Colors.white,
                                    ),
                                    onPressed: () {
                                      cartController.addToCart(product.id);
                                    },
                                  )
                                else
                                  CircleIconButton(
                                    elevation: 2,
                                    width: getProportionateScreenWidth(35),
                                    height: getProportionateScreenHeight(35),
                                    padding: EdgeInsets.all(
                                        getProportionateScreenWidth(9)),
                                    bgColor: oPrimaryColor,
                                    svgAsset: SvgPicture.asset(
                                      "assets/icons/Trash.svg",
                                      color: Colors.white,
                                    ),
                                    onPressed: () {
                                      productController
                                          .deleteProduct(product.id);
                                    },
                                  ),
                              ],
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          )),
    );
  }
}
