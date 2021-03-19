import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:storedoor/constants.dart';
import 'package:storedoor/controllers/category_controller.dart';
import 'package:storedoor/controllers/product_controller.dart';
import 'package:storedoor/size_config.dart';

class AddProductScreen extends StatelessWidget {
  final ProductController productController =
      Get.find<ProductController>(tag: "product-controller");
  final CategoryController categoryController =
      Get.find<CategoryController>(tag: "category-controller");

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        width: getProportionateScreenWidth(SizeConfig.screenWidth),
        child: ListView(
          // crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              width: getProportionateScreenWidth(SizeConfig.screenWidth),
              child: Material(
                elevation: 15,
                shadowColor: Colors.white70,
                color: oPrimaryColor.withOpacity(1),
                child: Column(
                  children: <Widget>[
                    SizedBox(
                      height: getProportionateScreenHeight(15),
                    ),
                    Text(
                      "Menambahkan product",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 24,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    SizedBox(
                      height: getProportionateScreenHeight(15),
                    ),
                  ],
                ),
              ),
            ),
            SingleChildScrollView(
              padding: EdgeInsets.symmetric(
                      vertical: getProportionateScreenHeight(20),
                      horizontal: getProportionateScreenWidth(20))
                  .copyWith(top: getProportionateScreenHeight(35)),
              child: Column(
                children: [
                  textField(
                    label: "Nama product",
                    maxLength: 150,
                    onChange: (val) {
                      productController.productName = val.trim();
                    },
                  ),
                  currencyTextField(label: "Harga"),
                  textField(
                    label: "Deskripsi product",
                    maxLength: 5000,
                    maxLines: 15,
                    minLines: 10,
                    style: GoogleFonts.poppins(
                      color: mPrimaryColor,
                      letterSpacing: 0.2,
                      height: 1.5,
                      fontSize: 14,
                    ),
                    onChange: (val) {
                      productController.description = val.trim();
                    },
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(
                        horizontal: getProportionateScreenWidth(50)),
                    child: ElevatedButton(
                      onPressed: () {
                        productController.getImage();
                      },
                      style: ButtonStyle(
                        backgroundColor:
                            MaterialStateProperty.all(mPrimaryColor),
                        elevation: MaterialStateProperty.all(10),
                      ),
                      child: Obx(
                        () => Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text("Tambahkan foto product"),
                            if (productController.path?.value?.isNotEmpty ??
                                false)
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
                                            productController.categoryId.value =
                                                element.id;
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
                            enterBottomSheetDuration:
                                Duration(milliseconds: 300),
                            exitBottomSheetDuration:
                                Duration(milliseconds: 300),
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
                        backgroundColor:
                            MaterialStateProperty.all(mPrimaryColor),
                        elevation: MaterialStateProperty.all(10),
                      ),
                      child: Obx(
                        () => Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text("Tambahkan kategori"),
                            if (productController.categoryId >= 1)
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
                  ElevatedButton(
                    onPressed: () {
                      productController.addProduct();
                    },
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all(oPrimaryColor),
                      elevation: MaterialStateProperty.all(10),
                    ),
                    child: Text("Submit"),
                  ),
                ],
              ),
            )
          ],
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

  Container currencyTextField({
    Widget suffixIcon,
    String hintText,
    bool obscure = false,
    void Function() onPressed,
    String errorText,
    String initialValue,
    @required String label,
  }) {
    final TextEditingController currencyController = TextEditingController();
    String _formatNumber(String val) =>
        NumberFormat.decimalPattern('id').format(int.parse(val));

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
          productController.price = val.replaceAll(".", "");
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

// Container longTextField({
//   String label = "",
// }) {
//   return Container(
//     margin: EdgeInsets.only(bottom: getProportionateScreenHeight(30)),
//     padding: EdgeInsets.symmetric(
//       vertical: getProportionateScreenHeight(8),
//       horizontal: getProportionateScreenWidth(25),
//     ).copyWith(right: 15, top: 3, bottom: 5),
//     decoration: BoxDecoration(
//       color: Colors.white,
//       borderRadius: BorderRadius.circular(getProportionateScreenWidth(5)),
//       boxShadow: [
//         BoxShadow(
//           blurRadius: 15,
//           spreadRadius: 2,
//           color: Colors.grey[300],
//           offset: Offset(10, 5),
//         ),
//       ],
//     ),
//     child: TextFormField(
//       maxLength: 1000,
//       // onChanged: onChange,
//       // initialValue: initialValue,
//       textAlignVertical: TextAlignVertical.center,
//       keyboardType: TextInputType.multiline,
//       // maxLines: null,
//       minLines: 10,
//       maxLines: 15,
//       style: GoogleFonts.poppins(
//         color: mPrimaryColor,
//         letterSpacing: 0.2,
//         height: 1.5,
//         fontSize: 14
//       ),
//       // expands: true,
//       // obscureText: obscure ?? false,
//       decoration: InputDecoration(
//         labelText: label,
//         focusColor: Colors.transparent,
//         labelStyle: TextStyle(color: kSecondaryColor),
//         // errorText: errorText,
//         alignLabelWithHint: true,
//         // hintText: hintText,
//         border: InputBorder.none,
//         focusedBorder: InputBorder.none,
//         enabledBorder: InputBorder.none,
//         errorBorder: InputBorder.none,
//         disabledBorder: InputBorder.none,
//         // suffixIcon: suffixIcon != null
//         // ? IconButton(icon: suffixIcon, onPressed: onPressed)
//         // : null,
//       ),
//     ),
//   );
// }
