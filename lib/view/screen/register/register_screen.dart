import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:storedoor/constants.dart';
import 'package:storedoor/controllers/register_controller.dart';
import 'package:storedoor/view/screen/home/home_screen.dart';
import 'package:storedoor/view/screen/login/login_screen.dart';
import 'package:storedoor/view/screen/register/widgets/register_form.dart';
import 'package:storedoor/view/widgets/appbar.dart';
import 'package:storedoor/view/widgets/black_button.dart';
import 'package:storedoor/view/widgets/welcome.dart';

class RegisterScreen extends StatelessWidget {
  final RegisterController registerController = Get.put(RegisterController());

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
        appBar: buildAppBar(context, "Register"),
        body: SafeArea(
          child: Obx(
            () {
              return registerController.isLoading.isTrue
                  ? Center(
                      child: CircularProgressIndicator(),
                    )
                  : ListView(
                      shrinkWrap: true,
                      // crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Welcome(),
                        RegisterForm(),
                        // Container(
                        //   padding: const EdgeInsets.symmetric(horizontal: 30),
                        //   alignment: Alignment.centerRight,
                        //   child: Text(
                        //     'Forgot password?',
                        //     style: TextStyle(color: mPrimaryColor),
                        //   ),
                        // ),
                        SizedBox(
                          height: 60,
                        ),
                        Obx(
                          () => BlackButton(
                            hintButton: "Register",
                            onPressed: registerController.submitFunc.value,
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
                                  TextSpan(text: 'Sudah punya akun? '),
                                  TextSpan(
                                    text: 'Masuk',
                                    style: TextStyle(
                                      color: mPrimaryColor,
                                    ),
                                    recognizer: TapGestureRecognizer()
                                      ..onTap = () {
                                        Get.off(LoginScreen());
                                      },
                                  ),
                                ]),
                          ),
                        ),
                      ],
                    );
            },
          ),
        ),
      ),
    );
  }
}
