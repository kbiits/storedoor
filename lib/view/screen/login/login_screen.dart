import 'dart:ui';

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:storedoor/constants.dart';
import 'package:storedoor/controllers/login_controller.dart';
import 'package:storedoor/view/screen/home/home_screen.dart';
import 'package:storedoor/view/screen/login/widget/login_form.dart';
import 'package:storedoor/view/screen/register/register_screen.dart';
import 'package:storedoor/view/widgets/appbar.dart';
import 'package:storedoor/view/widgets/black_button.dart';
import 'package:storedoor/view/widgets/welcome.dart';

class LoginScreen extends StatelessWidget {
  final formKey = GlobalKey<FormState>();

  final LoginController loginController = Get.put(LoginController());

  Future<bool> _onWillPop() async {
    Get.offUntil(
        MaterialPageRoute(builder: (_) => HomeScreen()), (route) => false);
    return true;
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: _onWillPop,
      child: Scaffold(
          appBar: buildAppBar(context, "Login"),
          body: SafeArea(
            child: Obx(
              () => loginController.isLoading.value
                  ? Container(
                      child: Center(
                        child: CircularProgressIndicator(),
                      ),
                    )
                  : ListView(
                      shrinkWrap: true,
                      // crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Welcome(),
                        LoginForm(),
                        SizedBox(
                          height: 60,
                        ),
                        Obx(
                          () => BlackButton(
                            hintButton: "Login",
                            onPressed: loginController.submitFunc.value,
                          ),
                        ),
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 30,
                            vertical: 26,
                          ),
                          alignment: Alignment.center,
                          child: RichText(
                            text: TextSpan(
                                style: TextStyle(color: Colors.grey),
                                children: [
                                  TextSpan(text: 'Belum punya akun? '),
                                  TextSpan(
                                    text: 'Daftar',
                                    style: TextStyle(
                                      color: mPrimaryColor,
                                    ),
                                    recognizer: TapGestureRecognizer()
                                      ..onTap = () {
                                        Get.off(RegisterScreen());
                                      },
                                  ),
                                ]),
                          ),
                        )
                      ],
                    ),
            ),
          )),
    );
  }
}
