import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:storedoor/constants.dart';
import 'package:storedoor/controllers/bottom_navbar_controller.dart';
import 'package:storedoor/enums.dart';
import 'package:storedoor/size_config.dart';

class BottomNavbar extends StatelessWidget {
  BottomNavbar({
    Key key,
    @required this.selectedMenu,
    @required this.forSeller,
  }) : super(key: key);

  final ScreenBottomBar selectedMenu;
  final BottomNavbarController bottomNavbarController =
      Get.put(BottomNavbarController());

  final bool forSeller;

  @override
  Widget build(BuildContext context) {
    final Color inActiveIconColor = Color(0xFFB6B6B6);
    print("selected menu  : $selectedMenu");

    final navForSeller = <Widget>[
      Container(
        decoration: BoxDecoration(
          color: oPrimaryColor,
          borderRadius: BorderRadius.circular(getProportionateScreenWidth(10)),
        ),
        child: IconButton(
          icon: Container(
            child: Icon(
              Icons.add,
              color: Colors.white,
            ),
          ),
          onPressed: () {
            bottomNavbarController.selectedMenu = ScreenBottomBar.add_product;
          },
          color: pPrimaryColor,
        ),
      ),
      Container(
        padding: EdgeInsets.symmetric(horizontal: 4),
        decoration: BoxDecoration(
          color: selectedMenu == ScreenBottomBar.seller_menu
              ? pPrimaryColor.withOpacity(0.1)
              : Colors.transparent,
          borderRadius: BorderRadius.horizontal(
            left: Radius.circular(getProportionateScreenWidth(15)),
            right: Radius.circular(getProportionateScreenWidth(15)),
          ),
        ),
        child: IconButton(
          icon: Container(
            child: SvgPicture.asset(
              "assets/icons/shop.svg",
              color: ScreenBottomBar.seller_menu == selectedMenu
                  ? pPrimaryColor
                  : inActiveIconColor,
              fit: BoxFit.cover,
              height: 200,
              width: 200,
            ),
          ),
          onPressed: () {
            bottomNavbarController.selectedMenu = ScreenBottomBar.seller_menu;
          },
          // color: ScreenBottomBar.home == selectedMenu
          //         ? kPrimaryColor
          //         : inActiveIconColor,
          color: pPrimaryColor,
        ),
      ),
    ];

    return Container(
      padding: EdgeInsets.symmetric(vertical: 8),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            offset: Offset(0, -10),
            blurRadius: 20,
            color: Colors.grey[400].withOpacity(0.2),
          ),
        ],
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(40),
          topRight: Radius.circular(40),
        ),
      ),
      child: SafeArea(
        top: false,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            // Home Icon
            Container(
              padding: EdgeInsets.symmetric(horizontal: 4),
              decoration: BoxDecoration(
                color: selectedMenu == ScreenBottomBar.home
                    ? pPrimaryColor.withOpacity(0.1)
                    : Colors.transparent,
                borderRadius: BorderRadius.horizontal(
                  left: Radius.circular(getProportionateScreenWidth(15)),
                  right: Radius.circular(getProportionateScreenWidth(15)),
                ),
              ),
              child: IconButton(
                  icon: Container(
                    child: SvgPicture.asset(
                      "assets/icons/home.svg",
                      color: ScreenBottomBar.home == selectedMenu
                          ? pPrimaryColor
                          : inActiveIconColor,
                    ),
                  ),
                  onPressed: () {
                    bottomNavbarController.selectedMenu = ScreenBottomBar.home;
                  }
                  // Navigator.pushNamed(context, HomeScreen.routeName),
                  ),
            ),
            // Search Icon
            Container(
              padding: EdgeInsets.symmetric(horizontal: 4),
              decoration: BoxDecoration(
                color: selectedMenu == ScreenBottomBar.search
                    ? pPrimaryColor.withOpacity(0.1)
                    : Colors.transparent,
                borderRadius: BorderRadius.horizontal(
                  left: Radius.circular(getProportionateScreenWidth(15)),
                  right: Radius.circular(getProportionateScreenWidth(15)),
                ),
              ),
              child: IconButton(
                  icon: Container(
                    child: SvgPicture.asset(
                      "assets/icons/direction.svg",
                      color: ScreenBottomBar.search == selectedMenu
                          ? pPrimaryColor
                          : inActiveIconColor,
                      fit: BoxFit.cover,
                      // height: 200,
                      // width: 200,
                    ),
                  ),
                  onPressed: () {
                    bottomNavbarController.selectedMenu =
                        ScreenBottomBar.search;
                  },
                  // color: ScreenBottomBar.home == selectedMenu
                  // ? pPrimaryColor
                  // : inActiveIconColor,
                  color: Colors.green),
            ),
            // For Seller
            if (forSeller) ...navForSeller,
            // Profile Icon
            Container(
              padding: EdgeInsets.symmetric(horizontal: 4),
              decoration: BoxDecoration(
                color: selectedMenu == ScreenBottomBar.profile
                    ? pPrimaryColor.withOpacity(0.1)
                    : Colors.transparent,
                borderRadius: BorderRadius.horizontal(
                  left: Radius.circular(getProportionateScreenWidth(15)),
                  right: Radius.circular(getProportionateScreenWidth(15)),
                ),
              ),
              child: IconButton(
                  icon: Container(
                    child: Image.asset(
                      "assets/icons/user.png",
                      color: ScreenBottomBar.profile == selectedMenu
                          ? pPrimaryColor
                          : inActiveIconColor,
                    ),
                  ),
                  onPressed: () {
                    bottomNavbarController.selectedMenu =
                        ScreenBottomBar.profile;
                  }
                  // Navigator.pushNamed(context, ProfileScreen.routeName),
                  ),
            ),
          ],
        ),
      ),
    );
  }
}
