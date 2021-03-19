import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:storedoor/controllers/product_controller.dart';
import 'package:storedoor/size_config.dart';
import 'package:storedoor/view/screen/auth/widgets/list_product_widget.dart';

class ListProductScreen extends StatelessWidget {
  final ProductController productController =
      Get.find<ProductController>(tag: 'product-controller');

  final bool useForSearch;

  ListProductScreen({@required this.useForSearch});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: getProportionateScreenHeight(SizeConfig.screenHeight),
      width: getProportionateScreenWidth(SizeConfig.screenWidth),
      child: Obx(
        () => ListView.builder(
          padding: EdgeInsets.symmetric(
            vertical: getProportionateScreenHeight(20),
            horizontal: getProportionateScreenWidth(20),
          ).copyWith(top: getProportionateScreenHeight(5)),
          shrinkWrap: true,
          itemCount: useForSearch
              ? productController.filteredProducts.length
              : ProductController.products.length,
          itemBuilder: (context, index) => ListProductWidget(
            product: useForSearch
                ? productController.filteredProducts[index]
                : ProductController.products[index],
            dismissible: useForSearch ? false : true,
          ),
        ),
      ),
    );
  }
}
