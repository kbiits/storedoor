import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:storedoor/constants.dart';
import 'package:storedoor/controllers/category_controller.dart';
import 'package:storedoor/controllers/product_controller.dart';
import 'package:storedoor/models/Product.dart';
import 'package:storedoor/size_config.dart';

class UpdateProductScreen extends StatelessWidget {
  final ProductController productController =
      Get.find<ProductController>(tag: "product-controller");
  final CategoryController categoryController =
      Get.find<CategoryController>(tag: "category-controller");

  final Product product;

  UpdateProductScreen({@required this.product});

  @override
  Widget build(BuildContext context) {
    currencyController.text = _formatNumber(product.price);
    productController.productNameForUpdate = product.title;
    productController.descriptionForUpdate = product.description;
    // productController.categoryIdForUpdate = product.categoryId;
    productController.priceForUpdate = product.price;
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios_rounded),
          onPressed: () => Get.back(),
        ),
        title: Text(
          "Memperbarui data product",
          textAlign: TextAlign.center,
          style: TextStyle(
              color: Colors.black,
              fontSize: getProportionateScreenWidth(20),
              fontWeight: FontWeight.w700,
              fontFamily: "Metropolis"),
        ),
      ),
      body: SafeArea(
        child: Container(
          width: getProportionateScreenWidth(SizeConfig.screenWidth),
          child: ListView(
            padding: EdgeInsets.symmetric(
                horizontal: getProportionateScreenWidth(15)),
            children: [
              SizedBox(
                height: getProportionateScreenHeight(15),
              ),
              textField(
                label: "Nama product",
                maxLength: 50,
                initialValue: product.title,
                onChange: (val) {
                  productController.productNameForUpdate = val.trim();
                },
              ),
              currencyTextField(
                label: "Harga",
              ),
              textField(
                label: "Deskripsi product",
                maxLength: 5000,
                maxLines: 15,
                minLines: 10,
                initialValue: product.description,
                style: GoogleFonts.poppins(
                  color: mPrimaryColor,
                  letterSpacing: 0.2,
                  height: 1.5,
                  fontSize: 14,
                ),
                onChange: (val) {
                  productController.descriptionForUpdate = val.trim();
                },
              ),
              Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: getProportionateScreenWidth(50),
                ),
                child: ElevatedButton(
                  onPressed: () {
                    productController.getImageForUpdate();
                  },
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(mPrimaryColor),
                    elevation: MaterialStateProperty.all(10),
                  ),
                  child: Obx(
                    () => Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text("Perbarui foto product"),
                        if (productController.pathImgForUpdate.value.length >=
                            5)
                          Container(
                            margin: EdgeInsets.only(
                              left: getProportionateScreenWidth(20),
                            ),
                            child: Icon(
                              Icons.check_circle,
                              color: Colors.green,
                            ),
                          ),
                      ],
                    ),
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(
                    horizontal: getProportionateScreenWidth(60)),
                child: ElevatedButton(
                  onPressed: () {
                    if (!Get.isBottomSheetOpen) {
                      Get.bottomSheet(
                        Container(
                          child: Padding(
                            padding: EdgeInsets.symmetric(
                              horizontal: getProportionateScreenWidth(30),
                              vertical: getProportionateScreenHeight(30),
                            ),
                            child: ListView(
                              children: categoryController.categories
                                  .map(
                                    (element) => InkWell(
                                      onTap: () {
                                        productController.categoryIdForUpdate
                                            .value = element.id;
                                        Get.back();
                                      },
                                      child: ListTile(
                                        title: Text(element.slug),
                                      ),
                                    ),
                                  )
                                  .toList(),
                            ),
                          ),
                        ),
                        isDismissible: true,
                        enableDrag: true,
                        elevation: 10,
                        backgroundColor: Colors.white,
                        enterBottomSheetDuration: Duration(milliseconds: 300),
                        exitBottomSheetDuration: Duration(milliseconds: 300),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(
                                getProportionateScreenWidth(15)),
                            topRight: Radius.circular(
                                getProportionateScreenWidth(15)),
                          ),
                        ),
                      );
                    }
                  },
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(mPrimaryColor),
                    elevation: MaterialStateProperty.all(10),
                  ),
                  child: Obx(
                    () => Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text("Perbarui kategori"),
                        if (productController.categoryIdForUpdate.value >= 1)
                          Container(
                            margin: EdgeInsets.only(
                                left: getProportionateScreenWidth(20)),
                            child: Icon(
                              Icons.check_circle,
                              color: Colors.green,
                            ),
                          ),
                      ],
                    ),
                  ),
                  // ),
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(
                    horizontal: getProportionateScreenWidth(
                        SizeConfig.screenWidth * 0.3)),
                child: ElevatedButton(
                  onPressed: () {
                    productController.updateProduct(product.id, product.img);
                  },
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(oPrimaryColor),
                    elevation: MaterialStateProperty.all(10),
                  ),
                  child: Text("Submit"),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Container textField({
    Widget suffixIcon,
    String hintText,
    bool obscure = false,
    void Function() onPressed,
    void Function(String) onChange,
    String errorText,
    String initialValue,
    @required String label,
    int maxLength,
    int maxLines = 1,
    int minLines = 1,
    TextStyle style,
  }) {
    return Container(
      margin: EdgeInsets.only(bottom: getProportionateScreenHeight(30)),
      padding: EdgeInsets.symmetric(
        horizontal: getProportionateScreenWidth(25),
      ).copyWith(right: 15, top: 3, bottom: 5),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(getProportionateScreenWidth(5)),
        boxShadow: [
          BoxShadow(
            blurRadius: 15,
            spreadRadius: 2,
            color: Colors.grey[300],
            offset: Offset(10, 5),
          ),
        ],
      ),
      child: TextFormField(
        style: style,
        onChanged: onChange,
        initialValue: initialValue,
        textAlignVertical: TextAlignVertical.center,
        obscureText: obscure ?? false,
        maxLength: maxLength,
        maxLines: maxLines,
        minLines: minLines,
        decoration: InputDecoration(
          labelText: label,
          focusColor: Colors.transparent,
          labelStyle: TextStyle(color: kSecondaryColor),
          errorText: errorText,
          alignLabelWithHint: true,
          hintText: hintText,
          border: InputBorder.none,
          focusedBorder: InputBorder.none,
          enabledBorder: InputBorder.none,
          errorBorder: InputBorder.none,
          disabledBorder: InputBorder.none,
          suffixIcon: suffixIcon != null
              ? IconButton(icon: suffixIcon, onPressed: onPressed)
              : null,
        ),
      ),
    );
  }

// controller for currency text field
  final TextEditingController currencyController = TextEditingController();
// formatter for currency text field
  String _formatNumber(String val) =>
      NumberFormat.decimalPattern('id').format(int.parse(val));

  Container currencyTextField({
    Widget suffixIcon,
    String hintText,
    bool obscure = false,
    void Function() onPressed,
    String errorText,
    String initialValue,
    @required String label,
  }) {
    return Container(
      margin: EdgeInsets.only(bottom: getProportionateScreenHeight(30)),
      padding: EdgeInsets.symmetric(
        horizontal: getProportionateScreenWidth(25),
      ).copyWith(right: 15, top: 3, bottom: 5),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(getProportionateScreenWidth(5)),
        boxShadow: [
          BoxShadow(
            blurRadius: 15,
            spreadRadius: 2,
            color: Colors.grey[300],
            offset: Offset(10, 5),
          ),
        ],
      ),
      child: TextFormField(
        controller: currencyController,
        onChanged: (String val) {
          if (val.isNotEmpty) val = '${_formatNumber(val.replaceAll('.', ''))}';
          productController.priceForUpdate = val.replaceAll(".", "");
          currencyController.value = TextEditingValue(
            text: val,
            selection: TextSelection.collapsed(offset: val.length),
          );
        },
        keyboardType: TextInputType.number,
        maxLength: 9,
        initialValue: initialValue,
        textAlignVertical: TextAlignVertical.center,
        obscureText: obscure ?? false,
        decoration: InputDecoration(
          labelText: label,
          focusColor: Colors.transparent,
          labelStyle: TextStyle(color: kSecondaryColor),
          errorText: errorText,
          alignLabelWithHint: true,
          hintText: hintText,
          border: InputBorder.none,
          focusedBorder: InputBorder.none,
          enabledBorder: InputBorder.none,
          errorBorder: InputBorder.none,
          disabledBorder: InputBorder.none,
          prefixText: "Rp ",
          suffixIcon: suffixIcon != null
              ? IconButton(icon: suffixIcon, onPressed: onPressed)
              : null,
        ),
      ),
    );
  }
}
