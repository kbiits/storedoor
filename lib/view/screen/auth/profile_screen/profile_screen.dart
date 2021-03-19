import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:storedoor/constants.dart';
import 'package:storedoor/controllers/cart_controller.dart';
import 'package:storedoor/controllers/category_controller.dart';
import 'package:storedoor/controllers/favorite_product_controller.dart';
import 'package:storedoor/controllers/login_controller.dart';
import 'package:storedoor/controllers/user_controller.dart';
import 'package:storedoor/size_config.dart';
import 'package:storedoor/view/screen/auth/cart/cart_screen.dart';
import 'package:storedoor/view/screen/auth/favorites/favorite_screen.dart';
import 'package:storedoor/view/screen/auth/manage_category_screen.dart';
import 'package:storedoor/view/screen/auth/user_setting_screen.dart';
import 'package:storedoor/view/widgets/common_button.dart';

class ProfileScreen extends StatelessWidget {
  final bool forSeller;
  ProfileScreen({this.forSeller = false});

  @override
  Widget build(BuildContext context) {
    // String avatarUrl;
    // String queryParams;
    final UserController userController = Get.put(UserController());
    final CategoryController categoryController =
        Get.find<CategoryController>(tag: "category-controller");

    // if (UserController.avatar.value == null ||
    //     // ignore: null_aware_in_logical_operator
    //     UserController.avatar?.value?.isEmpty) {
    //   queryParams = UserController.username.value.splitMapJoin(
    //     " ",
    //     onMatch: (match) => "+",
    //     onNonMatch: (nonMatch) => "$nonMatch",
    //   );
    //   avatarUrl = "https://ui-avatars.com/api/?size=300&name=$queryParams";
    //   // avatarUrl = "https://picsum.photos/300/300";
    //   // print(avatarUrl);
    // }

    return Padding(
      padding:
          EdgeInsets.symmetric(horizontal: getProportionateScreenWidth(20)),
      child: ListView(
        shrinkWrap: true,
        children: [
          SizedBox(
            height:
                getProportionateScreenHeight(SizeConfig.screenHeight * 0.12),
          ),
          Text(
            "My Profile",
            style: TextStyle(
              fontSize: 34,
              fontWeight: FontWeight.w700,
              color: mTitleTextColor,
            ),
            textAlign: TextAlign.left,
          ),
          SizedBox(
            height: getProportionateScreenHeight(20),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Container(
                height: getProportionateScreenHeight(100),
                width: getProportionateScreenWidth(80),
                child: Obx(
                  () {
                    String avatarUrl;
                    String queryParams;
                    if (UserController.avatar.value == null ||
                        // ignore: null_aware_in_logical_operator
                        UserController.avatar?.value?.isEmpty) {
                      queryParams = UserController.username.value.splitMapJoin(
                        " ",
                        onMatch: (match) => "+",
                        onNonMatch: (nonMatch) => "$nonMatch",
                      );
                      avatarUrl =
                          "https://ui-avatars.com/api/?size=300&name=$queryParams";
                    }
                    return CircleAvatar(
                      // ignore: deprecated_member_use
                      foregroundImage: !avatarUrl.isNullOrBlank
                          ? NetworkImage(avatarUrl)
                          : MemoryImage(
                              base64Decode(
                                UserController.avatar.value,
                              ),
                            ),
                    );
                  },
                ),
              ),
              SizedBox(
                width: getProportionateScreenWidth(20),
              ),
              Container(
                width: getProportionateScreenWidth(130),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Obx(
                      () => Text(
                        UserController.fullname.value ?? "",
                        maxLines: 2,
                        softWrap: true,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          color: mTitleTextColor,
                          fontSize: 18,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                    SizedBox(
                      height: getProportionateScreenHeight(10),
                    ),
                    Container(
                      child: Obx(
                        () => Text(
                          UserController.email.value ?? "",
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                width: getProportionateScreenWidth(50),
              ),
              // --------------------------Change profile picture--------------------
              Container(
                decoration: BoxDecoration(
                  color: oPrimaryColor,
                  borderRadius: BorderRadius.circular(
                    getProportionateScreenWidth(30),
                  ),
                ),
                child: IconButton(
                  icon: Icon(
                    Icons.camera_alt_rounded,
                    color: Colors.white,
                  ),
                  onPressed: () {
                    userController.getImage();
                  },
                ),
              ),
            ],
          ),
          SizedBox(
            height: getProportionateScreenHeight(40),
          ),
          if (!forSeller)
            profileOptions(
              onPressed: () {
                Get.to(() => CartScreen());
              },
              title: "Keranjangku",
              subtitle:
                  "${CartController.totalItemInCart} item di keranjang belanja",
            )
          else
            profileOptions(
              onPressed: () {
                Get.to(() => ManageCategoryScreen());
              },
              title: "Kelola Kategori",
              subtitle:
                  "Ada ${categoryController.categories.length} kategori saat ini",
            ),
          Divider(
            color: Colors.grey[350],
          ),
          profileOptions(
            onPressed: () {
              Get.to(() => FavoriteScreen());
            },
            title: "Produk Favorit",
            subtitle:
                "Ada ${FavoriteProductController.totalItemInFavoriteList} item di list produk favoritmu",
          ),
          Divider(
            color: Colors.grey[350],
          ),
          profileOptions(
            onPressed: () {
              Get.to(() => UserSettingScreen());
            },
            title: "Settings",
            subtitle: "Ganti nama, password, dll",
          ),
          Divider(
            color: Colors.grey[350],
          ),
          SizedBox(
            height: getProportionateScreenHeight(50),
          ),
          Padding(
            padding: EdgeInsets.symmetric(
              horizontal:
                  getProportionateScreenWidth(SizeConfig.screenWidth * 0.15),
            ),
            child: Container(
              decoration: BoxDecoration(
                borderRadius:
                    BorderRadius.circular(getProportionateScreenWidth(40)),
                color: oPrimaryColor,
              ),
              child: CommonButton(
                text: "Logout",
                height: getProportionateScreenHeight(20),
                color: oPrimaryColor,
                textColor: Colors.white,
                press: () => LoginController.logout(),
                // press: ,
              ),
            ),
          ),
        ],
      ),
    );
  }

  InkWell profileOptions({
    @required void Function() onPressed,
    String title = "",
    String subtitle = "",
  }) {
    return InkWell(
      onTap: onPressed,
      child: ListTile(
        title: Text(
          title,
          style: TextStyle(
            color: mPrimaryTextColor,
            fontWeight: FontWeight.w700,
            fontSize: 20,
          ),
        ),
        subtitle: Text(
          subtitle,
        ),
        trailing: Icon(Icons.arrow_forward_ios_outlined),
      ),
    );
  }
}
