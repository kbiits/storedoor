import 'package:cool_alert/cool_alert.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:storedoor/constants.dart';
import 'package:storedoor/controllers/product_controller.dart';
import 'package:storedoor/helper/loading_success.dart';
import 'package:storedoor/models/Category.dart';
import 'package:storedoor/services/category_services.dart';
import 'dart:convert';

import 'package:storedoor/view/widgets/no_internet.dart';

class CategoryController extends GetxController {
  RxList<Category> categories = <Category>[].obs;

  @override
  void onInit() {
    slug.value = "";
    slugForDeleting.value = "";
    slugBefore = "";
    slugAfter = "";
    super.onInit();
  }

  Future<Null> fetchData() async {
    print("fetching categories");
    var jsonString = await CategoryServices.fetchData();
    if (jsonString == null) {
      // CoolAlert.show(
      //   context: Get.context,
      //   type: CoolAlertType.error,
      //   title: "Tidak ada koneksi internet",
      //   text: "Harap coba lagi dan pastikan anda terhubung ke internet",
      // );
      noInternet();
      return;
    }
    if (jsonString["is_error"]) {
      CoolAlert.show(
        context: Get.context,
        type: CoolAlertType.error,
        title: "Error memuat data",
        text: jsonString["message"],
      );
      return;
    }

    var jsonEncode = json.encode(jsonString["data"]["categories"]);

    // Delete old data
    categories.clear();
    // Assing new data
    categories.assignAll(categoryFromJson(jsonEncode));
    print("Selesai fetch categories");
  }

  RxString slug = "".obs;
  RxString slugForDeleting = "".obs;

  void onChangeSlug(String val) {
    slug.value = val.trim();
  }

  void onChangeSlugForDeleting(String val) {
    slugForDeleting.value = val.trim();
  }

  void addCategory() async {
    if (slug.value.length <= 2) {
      if (!Get.isDialogOpen && !Get.isSnackbarOpen) {
        Get.snackbar(
          "Gagal menambahkan kategori",
          "Minimal 3 karakter untuk setiap nama kategori",
          barBlur: 8,
          overlayBlur: 1.5,
        );
      }
      return;
    }

    var isAlreadyCreated = categories.firstWhere(
        (element) =>
            element.slug.toLowerCase().trim().replaceAll(' ', '') ==
            slug.value.toLowerCase().trim().replaceAll(' ', ''),
        orElse: () => null);

    if (isAlreadyCreated != null) {
      if (!Get.isDialogOpen && !Get.isSnackbarOpen) {
        Get.snackbar(
          "Gagal menambahkan kategori",
          "Telah ada kategori dengan nama yang sama, silahkan gunakan nama yang lain",
          barBlur: 20,
          overlayBlur: 1.5,
          duration: Duration(milliseconds: 2200),
          animationDuration: Duration(milliseconds: 350),
        );
      }
      return;
    }

    EasyLoading.show(
      status: "Loading",
      dismissOnTap: false,
      indicator: CircularProgressIndicator(),
      maskType: EasyLoadingMaskType.clear,
    );
    var json = await CategoryServices.addCategory(slug.value);
    if (json["is_error"] ?? true) {
      if (!Get.isDialogOpen && !Get.isSnackbarOpen) {
        Get.snackbar(
          "Gagal menambahkan kategori",
          "${json["message"]}",
          barBlur: 8,
          overlayBlur: 1.5,
        );
      }
      return;
    }
    EasyLoading.showSuccess(
      "Berhasil menambahkan kategori",
      dismissOnTap: true,
      duration: Duration(milliseconds: 1000),
      maskType: EasyLoadingMaskType.black,
    );
    categories.add(Category.fromJson(json["data"]["category"]));

    // if (!Get.isDialogOpen && !Get.isSnackbarOpen) {
    //   Get.snackbar(
    //     "Success",
    //     "Berhasil menambahkan kategori",
    //     barBlur: 8,
    //     overlayBlur: 1.5,
    //     animationDuration: Duration(milliseconds: 300),
    //     duration: Duration(milliseconds: 1300),
    //   );
    // }
  }

  String slugBefore = "";
  String slugAfter = "";

  void onChangeSlugBefore(String val) => slugBefore = val;
  void onChangeSlugAfter(String val) => slugAfter = val;

  void updateCategory() async {
    if (slugAfter.length <= 2) {
      if (!Get.isDialogOpen && !Get.isSnackbarOpen) {
        Get.snackbar(
          "Gagal memperbarui kategori",
          "Minimal 3 karakter untuk setiap nama kategori",
          barBlur: 8,
          overlayBlur: 1.5,
        );
      }
      return;
    }

    var categoryId = categories
        .firstWhere(
            (element) =>
                element.slug.toLowerCase().trim() ==
                slugBefore.toLowerCase().trim(),
            orElse: () => null)
        ?.id;

    if (categoryId == null) {
      if (!Get.isDialogOpen && !Get.isSnackbarOpen) {
        Get.snackbar(
          "Gagal memperbarui kategori",
          "Tidak dapat menemukan kategori dengan nama '$slugBefore'",
          barBlur: 8,
          overlayBlur: 1.5,
          duration: Duration(milliseconds: 1700),
          animationDuration: Duration(milliseconds: 350),
        );
      }
      return;
    }

    var isAlreadyCreated = categories.firstWhere(
        (element) =>
            element.slug.toLowerCase().trim() == slugAfter.toLowerCase().trim(),
        orElse: () => null);
    if (isAlreadyCreated != null) {
      if (!Get.isDialogOpen && !Get.isSnackbarOpen) {
        Get.snackbar(
          "Gagal memperbarui kategori",
          "Telah ada kategori dengan nama yang sama, silahkan gunakan nama yang lain",
          barBlur: 20,
          overlayBlur: 1.5,
          duration: Duration(milliseconds: 2200),
          animationDuration: Duration(milliseconds: 350),
        );
      }
      return;
    }
    loading();
    var json = await CategoryServices.updateCategory(categoryId, slugAfter);
    if (json["is_error"] ?? true) {
      EasyLoading.dismiss();
      if (!Get.isDialogOpen && !Get.isSnackbarOpen) {
        Get.snackbar(
          "Gagal memperbarui kategori",
          "${json["message"]}",
          barBlur: 8,
          overlayBlur: 1.5,
        );
      }
      return;
    }
    success(status: "Berhasil memperbarui kategori");
    categories.firstWhere((element) => element.id == categoryId).slug =
        json["data"]["category"]["slug"];
    categories.refresh();
    ProductController.staticFetchProducts();
  }

  void removeCategory() async {
    int categoryId = categories
        .firstWhere(
          (element) =>
              element.slug.toLowerCase().trim() ==
              slugForDeleting.value.toLowerCase().trim(),
          orElse: () => null,
        )
        ?.id;
    if (categoryId == null) {
      if (!Get.isDialogOpen && !Get.isSnackbarOpen) {
        Get.snackbar(
          "Tidak dapat menemukan kategori",
          "Periksa kembali nama kategori yang dimasukkan dan silahkan coba lagi",
          barBlur: 8,
          overlayBlur: 1.5,
          duration: Duration(milliseconds: 1700),
          animationDuration: Duration(milliseconds: 400),
        );
      }
      return;
    }

    Get.defaultDialog(
      title: "Peringatan",
      middleText:
          "Jika anda menghapus kategori ini, maka setiap product dengan kategori yang sama akan terpengaruh",
      textConfirm: "Hapus",
      textCancel: "Batal",
      buttonColor: mPrimaryColor,
      cancelTextColor: mPrimaryTextColor,
      confirmTextColor: Colors.white,
      onConfirm: () async {
        loading();
        success(status: "Berhasil menghapus kategori");
        var json = await CategoryServices.removeCategory(categoryId);
        if (json["is_error"] ?? true) {
          EasyLoading.dismiss();
          if (!Get.isDialogOpen && !Get.isSnackbarOpen) {
            Get.snackbar(
              "Gagal menghapus kategori",
              "${json["message"]}",
              barBlur: 8,
              overlayBlur: 1.5,
            );
          }
        }
        categories.removeWhere((element) => element.id == categoryId);
        Get.back();
        return;
      },
    );
  }
}
