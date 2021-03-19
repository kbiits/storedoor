import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:storedoor/controllers/bottom_navbar_controller.dart';
import 'package:storedoor/enums.dart';
import 'package:storedoor/size_config.dart';

class TitleWidget extends StatelessWidget {
  TitleWidget({
    Key key,
    @required this.title,
  }) : super(key: key);

  final String title;

  final BottomNavbarController bottomNavbarController =
      Get.put(BottomNavbarController());

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: TextStyle(
            fontSize: getProportionateScreenWidth(18),
            color: Colors.black,
          ),
        ),
        GestureDetector(
          onTap: () {
            bottomNavbarController.selectedMenu = ScreenBottomBar.search;
          },
          child: Text(
            "See More",
            style: TextStyle(color: Color(0xFF777777)),
          ),
        ),
      ],
    );
  }
}
