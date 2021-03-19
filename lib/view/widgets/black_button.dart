import 'package:flutter/material.dart';
import 'package:storedoor/constants.dart';

class BlackButton extends StatelessWidget {
  final String hintButton;
  final void Function() onPressed;
  const BlackButton({
    Key key,
    @required this.hintButton,
    this.onPressed
  }) : super(key: key);


  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 30),
      // ignore: deprecated_member_use
      child: FlatButton(
        disabledColor: Colors.grey[400],
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(36),
        ),
        color: mPrimaryColor,
        onPressed: this.onPressed,
        child: Container(
          width: double.infinity,
          padding: const EdgeInsets.symmetric(vertical: 16),
          alignment: Alignment.center,
          child: Text(
            this.hintButton,
            style: TextStyle(
              color: Colors.white,
            ),
          ),
        ),
      ),
    );
  }
}
