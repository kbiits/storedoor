import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

void noInternet() {
  // if (!Get.isSnackbarOpen) {
  //   Get.snackbar(
  //     "Tidak ada koneksi internet",
  //     "Harap coba lagi, dan pastikan anda telah terhubung ke internet",
  //     barBlur: 10,
  //     animationDuration: Duration(milliseconds: 1000),
  //     duration: Duration(milliseconds: 1200),
  //     dismissDirection: SnackDismissDirection.HORIZONTAL,
  //     isDismissible: true,
  //   );
  // }
  if (!Get.isDialogOpen) {
    Get.defaultDialog(
      custom: Container(),
      title: "",
      barrierDismissible: true,
      content: Container(
        padding: EdgeInsets.all(10),
        child: Text("Tidak ada koneksi internet"),
      ),
    );
  }
  // Future.delayed(Duration(milliseconds: 1600), () {
  //   GetStorage storage = GetStorage();
  //   storage.read("isLogged")
  //       ? Get.offAll(() => DashboardScreen())
  //       : Get.offAll(() => HomeScreen());
  // });
}
