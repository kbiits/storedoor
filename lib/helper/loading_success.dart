import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

void loading({
  String status = "Loading",
  bool dismissOnTap = true,
  EasyLoadingMaskType maskType = EasyLoadingMaskType.black,
}) {
  EasyLoading.show(
    status: status,
    indicator: CircularProgressIndicator(),
    dismissOnTap: false,
    maskType: maskType,
  );
}

void success({
  String status = "Success",
  bool dismissOnTap = true,
  EasyLoadingMaskType maskType = EasyLoadingMaskType.black,
}) {
  EasyLoading.showSuccess(
    status,
    duration: Duration(milliseconds: 1000),
    dismissOnTap: dismissOnTap,
    maskType: maskType,
  );
}
