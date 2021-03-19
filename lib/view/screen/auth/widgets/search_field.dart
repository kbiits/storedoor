import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:storedoor/constants.dart';
import 'package:storedoor/controllers/product_controller.dart';
import 'package:storedoor/size_config.dart';

class SearchField extends StatelessWidget {
  SearchField({
    Key key,
    this.forSellerScreen = false,
  }) : super(key: key);

  final bool forSellerScreen;

  final ProductController productController =
      Get.find<ProductController>(tag: "product-controller");

  @override
  Widget build(BuildContext context) {
    return Container(
      width: !forSellerScreen
          ? SizeConfig.screenWidth * 0.6
          : SizeConfig.screenWidth * 0.7,
      decoration: BoxDecoration(
        color: kSecondaryColor.withOpacity(0.1),
        borderRadius: BorderRadius.circular(15),
      ),
      child: TextFormField(
        textAlignVertical: TextAlignVertical.center,
        onChanged: productController.onChangedSearchString,
        initialValue: productController.searchString.value,
        decoration: InputDecoration(
            contentPadding: EdgeInsets.symmetric(
                horizontal: getProportionateScreenWidth(20),
                vertical: getProportionateScreenWidth(13)),
            border: InputBorder.none,
            focusedBorder: InputBorder.none,
            enabledBorder: InputBorder.none,
            hintText: "Search product",
            hintStyle: TextStyle(fontSize: 15),
            prefixIcon: Icon(Icons.search)),
      ),
    );
  }
}
