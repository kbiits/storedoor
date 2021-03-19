import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:storedoor/constants.dart';
import 'package:storedoor/controllers/register_controller.dart';

class InputTextField extends StatelessWidget {
  InputTextField({
    Key key,
    this.label,
    this.onChange,
    this.password = false,
    this.controller,
    this.onSave,
    this.validator,
    this.errorText,
    this.suffixIcon,
    this.onPressedSuffixIcon,
    this.maxLength = 20,
  }) : super(key: key);

  final String label;
  final Function onChange;
  final bool password;
  final TextEditingController controller;
  final Function(String) onSave;
  final String Function(String) validator;
  final RegisterController registerController = Get.put(RegisterController());
  final String errorText;
  final Icon suffixIcon;
  final void Function() onPressedSuffixIcon;
  final int maxLength;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      onSaved: onSave,
      onChanged: onChange,
      obscureText: password,
      cursorColor: Colors.grey,
      controller: controller,
      validator: this.validator,
      maxLength: this.maxLength,
      decoration: InputDecoration(
        labelText: label,
        labelStyle: TextStyle(color: Colors.grey),
        border: UnderlineInputBorder(
            borderSide: BorderSide(
          color: mPrimaryColor,
          width: 2,
        )),
        errorText: this.errorText,
        focusedBorder: UnderlineInputBorder(
          borderSide: BorderSide(
            color: mPrimaryColor,
            width: 2,
          ),
        ),
        enabledBorder: UnderlineInputBorder(
          borderSide: BorderSide(
            color: Colors.grey,
            width: 0.5,
          ),
        ),
        suffixIcon: this.suffixIcon != null
            ? IconButton(
                icon: this.suffixIcon,
                onPressed: this.onPressedSuffixIcon,
              )
            : null,
      ),
    );
  }
}
