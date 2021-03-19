import 'package:flutter/material.dart';
import 'package:storedoor/size_config.dart';
import 'package:storedoor/view/screen/auth/widgets/discount_widget.dart';
// import 'package:storedoor/view/screen/auth/widgets/home_header_widget.dart';
import 'package:storedoor/view/screen/auth/widgets/popular_widget.dart';
import 'package:storedoor/view/screen/auth/widgets/special_for_you_widget.dart';


class ContentWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(height: getProportionateScreenHeight(20)),
            // HomeHeaderWidget(),
            SizedBox(height: getProportionateScreenWidth(10)),
            DiscountWidget(),
            // Categories(),
            SpecialForYouWidget(),
            SizedBox(height: getProportionateScreenWidth(30)),
            PopularWidget(),
            SizedBox(height: getProportionateScreenWidth(30)),
          ],
        ),
      ),
    );
  }
}