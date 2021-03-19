import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:storedoor/constants.dart';
import 'package:storedoor/controllers/user_controller.dart';
import 'package:storedoor/size_config.dart';
import 'package:storedoor/view/widgets/common_button.dart';

class UserSettingScreen extends StatelessWidget {
  final UserController userController = Get.put(UserController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: getProportionateScreenWidth(20),
        ),
        child: ListView(
          shrinkWrap: true,
          // crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: getProportionateScreenHeight(5),
            ),
            Container(
              child: Text(
                "Settings",
                style: TextStyle(
                  color: mPrimaryColor,
                  fontSize: 26,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
            SizedBox(
              height: getProportionateScreenHeight(20),
            ),
            Text(
              "Personal Information",
              style: TextStyle(
                color: mPrimaryTextColor,
                fontSize: 16,
                fontWeight: FontWeight.w700,
              ),
            ),
            SizedBox(
              height: getProportionateScreenHeight(20),
            ),
            Obx(
              () => textField(
                "Full name",
                label: "Nama Lengkap",
                onChange: userController.fullnameChanged,
                errorText: userController.errorTextFullname.value,
                initialValue: UserController.fullname.value,
              ),
            ),
            Obx(
              () => textField(
                "Email",
                label: "Email",
                onChange: userController.emailChanged,
                errorText: userController.errorTextEmail.value,
                initialValue: UserController.email.value,
              ),
            ),
            Obx(
              () => textField(
                "Username",
                label: "Username",
                onChange: userController.usernameChanged,
                errorText: userController.errorTextUsername.value,
                initialValue: UserController.username.value,
              ),
            ),
            Text(
              "Password",
              style: TextStyle(
                color: mPrimaryTextColor,
                fontSize: 16,
                fontWeight: FontWeight.w700,
              ),
            ),
            SizedBox(
              height: getProportionateScreenHeight(10),
            ),
            Obx(
              () => textField(
                "Password",
                label: "Password",
                obscure: userController.obscureText.value,
                onChange: userController.passwordChanged,
                errorText: userController.errorTextPassword.value,
                suffixIcon: userController.obscureText.isTrue
                    ? Icon(
                        Icons.visibility_off,
                        color: Colors.grey,
                      )
                    : Icon(
                        Icons.visibility,
                        color: Colors.grey,
                      ),
                onPressed: () => userController.obscureText.value =
                    !userController.obscureText.value,
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(
                horizontal: getProportionateScreenWidth(40),
              ),
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(
                    getProportionateScreenWidth(40),
                  ),
                ),
                child: Obx(
                  () => CommonButton(
                    text: "Update",
                    textColor: Colors.white,
                    press: userController.submitFunc.value,
                    color: oPrimaryColor,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios_rounded),
          onPressed: () => Get.back(),
        ),
      ),
    );
  }

  Container textField(
    String hintText, {
    Widget suffixIcon,
    bool obscure = false,
    void Function() onPressed,
    void Function(String) onChange,
    String errorText,
    String initialValue,
    @required String label,
  }) {
    return Container(
      margin: EdgeInsets.only(bottom: getProportionateScreenHeight(30)),
      padding: EdgeInsets.symmetric(
        vertical: getProportionateScreenHeight(8),
        horizontal: getProportionateScreenWidth(40),
      ).copyWith(right: 15),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(getProportionateScreenWidth(5)),
        boxShadow: [
          BoxShadow(
            blurRadius: 15,
            spreadRadius: 2,
            color: Colors.grey[200],
            offset: Offset(10, 5),
          ),
        ],
      ),
      child: TextFormField(
        onChanged: onChange,
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
          suffixIcon: suffixIcon != null
              ? IconButton(icon: suffixIcon, onPressed: onPressed)
              : null,
        ),
      ),
    );
  }
}
