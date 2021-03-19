import 'package:flutter/material.dart';
import 'package:storedoor/size_config.dart';

final _apiUrl = "https://evening-plains-61530.herokuapp.com/api/";
get apiUrl => _apiUrl;

Color mBackgroundColor = Color(0xFFFFFFFF);

Color mPrimaryColor = Color.fromRGBO(51, 51, 51, 1);
Color oPrimaryColor = Color(0xFFDB3022);
Color pPrimaryColor = Color(0xFF4A3298);
// Color pPrimaryColor = Color(0xFFDB3022);

Color mPrimaryTextColor = Color.fromRGBO(51, 51, 51, 1);

Color mSecondTextColor = Color(0xFFB98068);

Color mSecondColor = Color(0xFFC28E79);

Color mFacebookColor = Color(0xFF4277BC);

Color mTitleTextColor = Color(0xFF2D140D);

List<String> coffeeNames = [
  'Espresso',
  'Cappuccino',
  'Macciato',
  'Mocha',
  'Latte',
];

const kPrimaryColor = Color(0xFFFF7643);
const kPrimaryLightColor = Color(0xFFFFECDF);
const kPrimaryGradientColor = LinearGradient(
  begin: Alignment.topLeft,
  end: Alignment.bottomRight,
  colors: [Color(0xFFFFA53E), Color(0xFFFF7643)],
);
const kSecondaryColor = Color(0xFF979797);
const kTextColor = Color(0xFF757575);

const kAnimationDuration = Duration(milliseconds: 200);

final headingStyle = TextStyle(
  fontSize: getProportionateScreenWidth(28),
  fontWeight: FontWeight.bold,
  color: Colors.black,
  height: 1.5,
);

OutlineInputBorder outlineInputBorder() {
  return OutlineInputBorder(
    borderRadius: BorderRadius.circular(getProportionateScreenWidth(15)),
    borderSide: BorderSide(color: kTextColor),
  );
}

const defaultDuration = Duration(milliseconds: 250);
