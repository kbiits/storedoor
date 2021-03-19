import 'package:flutter/material.dart';

class CommonButton extends StatelessWidget {
  CommonButton({
    Key key,
    this.text,
    this.press,
    this.color = Colors.purple,
    this.textColor = Colors.black,
    this.height = 36,
    this.width = double.infinity,
    this.borderRadius,
    this.textSize = 18,
    this.fontWeight = FontWeight.normal,
  }) : super(key: key);

  final String text;
  final Function press;
  final Color color;
  final Color textColor;
  final double height;
  final double width;
  final BorderRadius borderRadius;
  final double textSize;
  final FontWeight fontWeight;

  @override
  Widget build(BuildContext context) {
    // ignore: deprecated_member_use
    return FlatButton(
      shape: RoundedRectangleBorder(
        borderRadius: this.borderRadius ?? BorderRadius.circular(36),
      ),
      disabledColor: Colors.grey,
      color: this.color,
      onPressed: press,
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.symmetric(vertical: 16),
        alignment: Alignment.center,
        child: Text(
          text,
          style: TextStyle(
            fontSize: this.textSize,
            color: this.textColor,
            fontWeight: this.fontWeight,
          ),
        ),
      ),
    );
  }
}
