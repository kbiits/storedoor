import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:storedoor/controllers/register_controller.dart';
import 'package:storedoor/controllers/user_controller.dart';
import 'package:storedoor/view/widgets/input_text_field.dart';

class RegisterForm extends StatelessWidget {
  final RegisterController registerController = Get.put(RegisterController());

  RegisterForm({
    Key key,
  }) : super(key: key);

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
              label: 'Nama Lengkap',
              onChange: registerController.fullnameChanged,
              errorText: registerController.errorTextFullname.value,
              maxLength: 50,
              // onSave: (value) {
              //   registerController.email =  value;
              // },
            ),
          ),
          Obx(
            () => InputTextField(
              label: 'Email',
              onChange: registerController.emailChanged,
              errorText: registerController.errorTextEmail.value,
              maxLength: 50,
              // onSave: (value) {
              //   registerController.email =  value;
              // },
            ),
          ),
          SizedBox(
            height: 16,
          ),
          Obx(
            () => InputTextField(
              label: 'Username',
              onChange: registerController.usernameChanged,
              errorText: registerController.errorTextUsername.value,
              // onSave: (value) {
              //   registerController.username = value;
              // },
            ),
          ),
          SizedBox(
            height: 16,
          ),
          Obx(
            () => InputTextField(
              label: 'Password',
              password: userController.obscureText.value,
              maxLength: 100,
              suffixIcon: userController.obscureText.isTrue
                  ? Icon(
                      Icons.visibility_off,
                      color: Colors.grey,
                    )
                  : Icon(
                      Icons.visibility,
                      color: Colors.grey,
                    ),
              onChange: registerController.passwordChanged,
              errorText: registerController.errorTextPassword.value,
              onPressedSuffixIcon: () {
                userController.obscureText.value =
                    !userController.obscureText.value;
              },
              // onSave: (value) {
              //   registerController.password = value;
              // },
            ),
          ),
        ],
      ),
    );
  }
}
