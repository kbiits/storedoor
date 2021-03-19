import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:storedoor/constants.dart';
import 'package:storedoor/controllers/login_controller.dart';
import 'package:storedoor/view/screen/home/widgets/login_and_register.dart';
import 'package:storedoor/view/screen/home/widgets/login_with_facebook.dart';
import 'dart:math' as math;

class HomeScreen extends StatelessWidget {
  final LoginController loginController = Get.put(LoginController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: ListView(
          shrinkWrap: true,
          children: <Widget>[
            Padding(
              padding:
                  const EdgeInsets.symmetric(vertical: 30).copyWith(top: 50),
              child: Transform.rotate(
                angle: math.pi * 2,
                child: Image.asset(
                  'assets/images/olshop.jpg',
                  height: MediaQuery.of(context).size.height * 0.35,
                  width: MediaQuery.of(context).size.width * 0.45,
                ),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30),
              child: Text(
                'Dapatkan produk terbaik di seluruh Indonesia!',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: mPrimaryTextColor,
                  fontSize: 28,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
            SizedBox(
              height: 60,
            ),
            LoginAndRegister(),
            LoginWithFacebook()
          ],
        ),
      ),
    );
  }
}
