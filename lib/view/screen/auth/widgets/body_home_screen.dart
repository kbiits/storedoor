import 'package:flutter/material.dart';
import 'package:get/get.dart';
// import 'package:get/get.dart';
import 'package:storedoor/controllers/product_controller.dart';
import 'package:storedoor/size_config.dart';
import 'package:storedoor/view/screen/auth/list_product_screen.dart';
import 'package:storedoor/view/screen/auth/widgets/categories_widget.dart';
import 'package:storedoor/view/screen/auth/widgets/discount_widget.dart';
import 'package:storedoor/view/screen/auth/widgets/home_header_widget.dart';
import 'package:storedoor/view/screen/auth/widgets/list_product_widget.dart';
import 'package:storedoor/view/screen/auth/widgets/popular_widget.dart';
import 'package:storedoor/view/screen/auth/widgets/title_widget.dart';

class BodyHomeScreen extends StatelessWidget {
  final bool forSellerScreen;
  BodyHomeScreen({this.forSellerScreen = false});

  final ProductController productController =
      Get.find<ProductController>(tag: "product-controller");

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        children: [
          SizedBox(height: getProportionateScreenHeight(15)),
          HomeHeaderWidget(
            forSellerScreen: forSellerScreen,
          ),
          SizedBox(height: getProportionateScreenHeight(15)),
          Obx(
            () => productController.isSearched.isTrue
                ? Expanded(
                    child: ListProductScreen(
                      useForSearch: true,
                    ),
                  )
                : Expanded(
                    child: SingleChildScrollView(
                      child: Column(
                        children: [
                          DiscountWidget(),
                          SizedBox(height: getProportionateScreenWidth(10)),
                          Padding(
                            padding: EdgeInsets.symmetric(
                                horizontal: getProportionateScreenWidth(20)),
                            child: TitleWidget(title: "Kategori"),
                          ),
                          SizedBox(
                            height: getProportionateScreenHeight(15),
                          ),
                          CategoriesWidget(
                            withoutGestureDetector: true,
                          ),
                          SizedBox(height: getProportionateScreenWidth(30)),
                          PopularWidget(
                            title: "Produk Populer",
                          ),
                          SizedBox(height: getProportionateScreenWidth(40)),
                          Padding(
                            padding: EdgeInsets.symmetric(
                                horizontal: getProportionateScreenWidth(20)),
                            child: TitleWidget(title: "Produk Lainnya"),
                          ),
                          Container(
                            padding: EdgeInsets.symmetric(
                              vertical: getProportionateScreenHeight(10),
                              horizontal: getProportionateScreenWidth(20),
                            ),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(
                                  getProportionateScreenWidth(15)),
                              color: Colors.grey[50],
                            ),
                            child: Column(
                              children: List.generate(
                                4,
                                (index) => ListProductWidget(
                                  dismissible: false,
                                  product: ProductController.products[index],
                                ),
                              ),
                            ),
                          ),
                          SizedBox(height: getProportionateScreenWidth(30)),
                        ],
                      ),
                    ),
                  ),
          ),
        ],
      ),
    );
  }
}
