import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:storedoor/controllers/user_controller.dart';
import 'package:storedoor/size_config.dart';
import 'package:storedoor/view/screen/dashboard/dashboard_screen.dart';
import 'package:storedoor/view/screen/home/home_screen.dart';
import 'package:storedoor/view/screen/onboarding/onboarding_screen.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    var d = Duration(milliseconds: 900);
    // delayed 3 seconds to next page
    final GetStorage storage = GetStorage();
    // storage.erase();
    storage.writeIfNull("isLogged", false);
    storage.writeIfNull("alreadySeenOnBoardingScreen", false);
    UserController.token.value = storage.read("token");
    UserController.email.value = storage.read("email");
    UserController.id.value = storage.read("id");
    UserController.username.value = storage.read("username");
    UserController.fullname.value = storage.read("fullname");
    UserController.avatar.value = storage.read("avatar");
    Future.delayed(d, () {
      // to next page and close this page
      bool isLogged = storage.read("isLogged");
      bool alreadySeenOnBoardingScreen =
          storage.read("alreadySeenOnBoardingScreen");
      Get.offAll(
        isLogged && alreadySeenOnBoardingScreen
            ? () => DashboardScreen()
            : alreadySeenOnBoardingScreen && !isLogged
                ? HomeScreen()
                : () => OnBoardingScreen(),
        transition: Transition.fadeIn,
        duration: Duration(milliseconds: 2000),
      );
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
              image: AssetImage('assets/images/bg.png'), fit: BoxFit.cover),
        ),
        child: Center(
          child: Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/images/logo-transparent.png'),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
