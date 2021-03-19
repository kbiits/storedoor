import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:storedoor/controllers/category_controller.dart';
import 'package:storedoor/controllers/product_controller.dart';
import 'package:storedoor/size_config.dart';
import 'package:storedoor/view/screen/auth/list_product_screen.dart';
import 'package:storedoor/view/screen/auth/search_screen/widgets/secondary_product_card.dart';
import 'package:storedoor/view/screen/auth/widgets/categories_widget.dart';
import 'package:storedoor/view/screen/auth/widgets/home_header_widget.dart';

class SearchScreen extends StatelessWidget {
  final ProductController productController =
      Get.find<ProductController>(tag: "product-controller");

  final CategoryController categoryController =
      Get.find<CategoryController>(tag: "category-controller");

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: getProportionateScreenHeight(15),
        ),
        HomeHeaderWidget(),
        SizedBox(
          height: getProportionateScreenWidth(15),
        ),
        CategoriesWidget(),
        SizedBox(
          height: getProportionateScreenHeight(20),
        ),
        Obx(
          () => productController.isSearched.isTrue
              ? Expanded(
                child: ListProductScreen(
                    useForSearch: true,
                  ),
              )
              : Expanded(
                  child: Obx(
                    () => GridView.count(
                      padding: EdgeInsets.symmetric(
                        horizontal: getProportionateScreenWidth(15),
                      ).copyWith(bottom: getProportionateScreenHeight(20)),
                      shrinkWrap: true,
                      crossAxisCount: 2,
                      childAspectRatio: 0.5,
                      crossAxisSpacing: getProportionateScreenWidth(10),
                      mainAxisSpacing: getProportionateScreenHeight(15),
                      children: List.generate(
                        productController.isSearchedByCategory.isTrue
                            ? productController.filteredByCategory.length
                            : ProductController.products.length,
                        (index) => SecondaryProductCard(
                          product: productController.isSearchedByCategory.isTrue
                              ? productController.filteredByCategory[index]
                              : ProductController.products[index],
                        ),
                      ),
                    ),
                  ),
                ),
        ),
      ],
    );
  }
}
