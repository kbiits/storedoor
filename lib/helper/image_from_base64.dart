import 'dart:convert';
import 'package:flutter/material.dart';

Image imageFromBase64String(String base64String,
    {BoxFit fit, double height, double width, Color color}) {
  return Image.memory(
    base64Decode(base64String.split("base64,").last),
    fit: fit,
    height: height,
    width: width,
    color: color,
  );
}
