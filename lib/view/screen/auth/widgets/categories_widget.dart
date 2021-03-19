import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:storedoor/constants.dart';
import 'package:storedoor/controllers/category_controller.dart';
import 'package:storedoor/controllers/product_controller.dart';
import 'package:storedoor/size_config.dart';

class CategoriesWidget extends StatelessWidget {
  final CategoryController categoryController =
      Get.find<CategoryController>(tag: "category-controller");
  // final ProductController productController =
  // Get.find<ProductController>(tag: "product-controller");
  final bool withoutGestureDetector;

  CategoriesWidget({this.withoutGestureDetector = false});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: getProportionateScreenHeight(35),
      width: getProportionateScreenWidth(SizeConfig.screenWidth),
      child: ListView.builder(
        padding:
            EdgeInsets.symmetric(horizontal: getProportionateScreenWidth(30)),
        itemCount: categoryController.categories.length,
        shrinkWrap: true,
        scrollDirection: Axis.horizontal,
        // mainAxisAlignment: MainAxisAlignment.spaceBetween,
        // crossAxisAlignment: CrossAxisAlignment.start,
        itemBuilder: (context, index) => Obx(
          () => CategoryCard(
            key: Key(index.toString()),
            forManageCategory: this.withoutGestureDetector,
            idx: categoryController.categories[index].id,
            // icon: categories[index]["icon"],
            text: categoryController.categories[index].slug,
            // press: () {
            //   productController.selectedCategoryId ==
            //               categoryController.categories[index].id &&
            //           productController.isSearchedByCategory.isTrue
            //       ? productController.isSearched(false)
            //       : productController.selectedCategoryId =
            //           categoryController.categories[index].id;
            // },
          ),
        ),
      ),
    );
  }
}

class CategoryCard extends StatelessWidget {
  final ProductController productController =
      Get.find<ProductController>(tag: "product-controller");

  CategoryCard({
    Key key,
    @required this.text,
    // @required this.press,
    @required this.idx,
    this.color = const Color(0xFF222222),
    this.forManageCategory = false,
  }) : super(key: key);

  final bool forManageCategory;
  // final String icon,
  final String text;
  // final GestureTapCallback press;
  final Color color;
  final int idx;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        if (!this.forManageCategory) {
          if (productController.selectedCategoryId == idx) {
            if (productController.isSearchedByCategory.isTrue) {
              productController.isSearchedByCategory(false);
            } else {
              productController.selectedCategoryId = idx;
            }
          } else {
            productController.selectedCategoryId = idx;
          }
        } else {
          return;
        }
      },
      child: SizedBox(
        // width: getProportionateScreenWidth(50),
        // height: getProportionateScreenHeight(50),
        child: Obx(
          () => Container(
            margin: EdgeInsets.only(right: getProportionateScreenWidth(10)),
            padding: EdgeInsets.symmetric(
              horizontal: getProportionateScreenWidth(25),
            ),
            // height: getProportionateScreenWidth(35),
            // width: getProportionateScreenWidth(70),
            decoration: BoxDecoration(
              color: this.idx == productController.selectedCategoryId &&
                      productController.isSearchedByCategory.isTrue &&
                      !this.forManageCategory
                  ? oPrimaryColor
                  : Color(0xFF222222),
              borderRadius: BorderRadius.circular(20),
            ),
            // child: SvgPicture.asset(icon),
            child: Center(
              child: Text(
                text,
                textAlign: TextAlign.center,
                maxLines: 1,
                overflow: TextOverflow.visible,
                style: TextStyle(color: Colors.white),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
