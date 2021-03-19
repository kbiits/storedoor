import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:storedoor/controllers/login_controller.dart';
import 'package:storedoor/controllers/user_controller.dart';
import 'package:storedoor/view/widgets/input_text_field.dart';

class LoginForm extends StatelessWidget {
  LoginForm({
    Key key,
  }) : super(key: key);

  final LoginController loginController = Get.put(LoginController());
  final UserController userController = Get.put(UserController());

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        vertical: 20,
        horizontal: 30,
      ),
      child: ListView(
        shrinkWrap: true,
        children: <Widget>[
          Obx(
            () => InputTextField(
              label: 'Email atau Username',
              onChange: loginController.accountDataChanged,
              errorText: loginController.errorTextAccountData.value,
              maxLength: null,
            ),
          ),
          SizedBox(height: 16),
          Obx(
            () => InputTextField(
              label: 'Password',
              password: userController.obscureText.value,
              onChange: loginController.passwordChanged,
              errorText: loginController.errorTextPassword.value,
              onPressedSuffixIcon: () {
                userController.obscureText.value =
                    !userController.obscureText.value;
              },
              maxLength: null,
              suffixIcon: userController.obscureText.isTrue
                  ? Icon(
                      Icons.visibility_off,
                      color: Colors.grey,
                    )
                  : Icon(
                      Icons.visibility,
                      color: Colors.grey,
                    ),
            ),
          ),
        ],
      ),
    );
  }
}
