import 'dart:math';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:storedoor/controllers/product_controller.dart';
// import 'package:shop_app/components/product_card.dart';
// import 'package:shop_app/models/Product.dart';
import 'package:storedoor/size_config.dart';
import 'package:storedoor/view/screen/auth/widgets/title_widget.dart';
import 'package:storedoor/view/widgets/product_card.dart';

class PopularWidget extends StatelessWidget {
  final ProductController productController =
      Get.find<ProductController>(tag: "product-controller");
  final String title;

  final bool randomProduct;

  PopularWidget({this.title = "Produk Populer", this.randomProduct = true});
  final random = Random();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding:
              EdgeInsets.symmetric(horizontal: getProportionateScreenWidth(20)),
          child: TitleWidget(
            title: this.title,
          ),
        ),
        SizedBox(height: getProportionateScreenWidth(20)),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: [
              ...List.generate(
                3,
                (index) {
                  List<int> i = List.generate(
                      ProductController.products.length, (i) => i);
                  i.shuffle();
                  if (!ProductController.products[i[index]].isBlank)
                    return ProductCard(
                      product: ProductController.products[i[index]],
                      // aspectRetio: 1.02,
                      width: getProportionateScreenWidth(
                          SizeConfig.screenWidth * 0.4),
                    );
                  return SizedBox
                      .shrink(); // here by default width and height is 0
                },
              ),
              SizedBox(width: getProportionateScreenWidth(20)),
            ],
          ),
        )
      ],
    );
  }
}
