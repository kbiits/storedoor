import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:storedoor/size_config.dart';

class CircleIconButton extends StatelessWidget {
  CircleIconButton({
    Key key,
    @required this.svgAsset,
    @required this.onPressed,
    this.bgColor = Colors.white,
    this.elevation = 7,
    this.width,
    this.height,
    this.padding,
  }) : super(key: key);

  final SvgPicture svgAsset;
  final void Function() onPressed;
  final Color bgColor;
  final double elevation;
  final double width;
  final double height;
  final EdgeInsets padding;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: this.onPressed,
      customBorder: CircleBorder(),
      child: Material(
        shape: CircleBorder(),
        elevation: this.elevation,
        shadowColor: Colors.white70,
        child: Container(
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: this.bgColor,
          ),
          width: this.width ?? getProportionateScreenWidth(30),
          height: this.height ?? getProportionateScreenHeight(35),
          child: Padding(
            padding:
                this.padding ?? EdgeInsets.all(getProportionateScreenWidth(10)),
            child: this.svgAsset,
          ),
        ),
      ),
    );
  }
}
