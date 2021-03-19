import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:storedoor/constants.dart';
import 'package:storedoor/view/screen/home/home_screen.dart';

Widget buildAppBar(BuildContext context, String title) {
  return AppBar(
    backgroundColor: mBackgroundColor,
    elevation: 0,
    centerTitle: true,
    title: Padding(
      padding: const EdgeInsets.symmetric(vertical: 100),
      child: Text(
        title,
        style: TextStyle(
          color: mPrimaryTextColor,
        ),
      ),
    ),
    leading: IconButton(
      icon: Icon(
        Icons.arrow_back_ios,
        color: mPrimaryTextColor,
      ),
      onPressed: () {
        Get.offUntil(
            MaterialPageRoute(builder: (_) => HomeScreen()), (route) => false);
      },
    ),
  );
}
