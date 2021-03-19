import 'package:cool_alert/cool_alert.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:storedoor/helper/loading_success.dart';
import 'package:storedoor/models/Product.dart';
import 'package:storedoor/services/product_services.dart';
import 'package:storedoor/view/widgets/no_internet.dart';

class ProductController extends GetxController {
  static var products = <Product>[].obs;
  var filteredProducts = <Product>[].obs;
  var searchString = "".obs;
  RxBool isSearched = false.obs;

  @override
  void onInit() async {
    // await fetchProducts();
    debounce(searchString, handleSearch, time: Duration(milliseconds: 800));
    productName = "";
    description = "";
    price = "";
    categoryId.value = -1;
    path.value = "";
    pathImgForUpdate.value = "";
    categoryIdForUpdate.value = -1;
    super.onInit();
  }

// Assign text in Search field to search string variable
  void onChangedSearchString(String val) {
    searchString.value = val;
    val.length <= 2 && isSearched(false);
  }

// Handle search product
  void handleSearch(String val) {
    if (val.length > 2) {
      isSearched(true);
      filterProduct(val);
      if (filteredProducts.length == 0) {
        Get.dialog(
          Container(
            child: AlertDialog(
              title: Text("Hasil pencarian kosong"),
              actions: [
                // ignore: deprecated_member_use
                FlatButton(
                    onPressed: () {
                      Get.back();
                      isSearched(false);
                    },
                    child: Text("Mengerti")),
              ],
            ),
          ),
        );
      }
      print(
        "${filteredProducts.length} <- Jumlah item yang ketemu saat searching",
      );
    }
  }

// Filter for searching product
  void filterProduct(String val) {
    filteredProducts.assignAll(
      products.where(
        (product) => product.title
            .toLowerCase()
            .trim()
            .replaceAll(' ', '')
            .contains(val.trim().replaceAll(" ", '').toLowerCase()),
      ),
    );
  }

// Get all products
  Future<Null> fetchProducts() async {
    print("fetching products");
    var jsonString = await ProductServices.fetchProducts();
    if (jsonString == null) {
      noInternet();
      return;
    }

    // If there's something error, show alert
    if (jsonString["is_error"]) {
      CoolAlert.show(
        context: Get.context,
        type: CoolAlertType.error,
        title: "Error memuat data",
        text: jsonString["message"],
      );
      return;
    }

    List<dynamic> newData = [];

    // if list of product just contain 1 object, dart detect it as Map, but if list of product contain more than 1 object, dart will cast is as list<dynamic>

    // Check if products from json response contain 1 object or not
    if (jsonString["data"]["products"] is Map<String, dynamic>) {
      jsonString["data"]["products"].entries.forEach((e) => newData.add(e));
    } else {
      newData = jsonString["data"]["products"];
    }
    // Delete old data in products
    products.clear();

    // add new data to products
    newData.forEach((element) {
      products.add(Product.fromJson(element));
    });
    print("banyak produk ${products.length}");
    print("Selesai fetch products");
  }

// Static for fethc products
  static Future<Null> staticFetchProducts() async {
    print("fetching products");
    var jsonString = await ProductServices.fetchProducts();
    if (jsonString == null) {
      noInternet();
      return;
    }

    // If there's something error, show alert
    if (jsonString["is_error"]) {
      CoolAlert.show(
        context: Get.context,
        type: CoolAlertType.error,
        title: "Error memuat data",
        text: jsonString["message"],
      );
      return;
    }

    List<dynamic> newData = [];

    // if list of product just contain 1 object, dart detect it as Map, but if list of product contain more than 1 object, dart will cast is as list<dynamic>

    // Check if products from json response contain 1 object or not
    if (jsonString["data"]["products"] is Map<String, dynamic>) {
      jsonString["data"]["products"].entries.forEach((e) => newData.add(e));
    } else {
      newData = jsonString["data"]["products"];
    }
    // Delete old data in products
    products.clear();

    // add new data to products
    newData.forEach((element) {
      products.add(Product.fromJson(element));
    });
    print("banyak produk ${products.length}");
    print("Selesai fetch products");
  }

  RxBool isSearchedByCategory = false.obs;
  var filteredByCategory = <Product>[].obs;
  RxInt _selectedCategoryId = (0).obs;

  set selectedCategoryId(int val) {
    _selectedCategoryId.value = val;
    isSearchedByCategory(true);
    if (isSearchedByCategory.value) {
      filterProductByCategory();
    }
  }

  int get selectedCategoryId => _selectedCategoryId.value;

  void filterProductByCategory() {
    filteredByCategory.clear();
    filteredByCategory.assignAll(
      products.where((p) => p.categoryId == _selectedCategoryId.value),
    );
  }

// For adding product here
  String productName;
  String description;
  String price;
  RxInt categoryId = RxInt(-1);
  RxString path = RxString("");

  void addProduct() async {
    print("sending request to endpoint add product");
    if (path.value.length <= 0 ||
        categoryId.value <= 0 ||
        price.length <= 0 ||
        description.length <= 0 ||
        productName.length <= 0) {
      Get.snackbar(
        "Gagal",
        "Silahkan isi semua field yang ada terlebih dahulu",
        overlayBlur: 1.3,
        barBlur: 15,
        duration: Duration(milliseconds: 1800),
        animationDuration: Duration(milliseconds: 350),
      );
      return;
    }

    loading();

    var response = await ProductServices.addingProduct(
      categoryId: categoryId.value.toString(),
      description: description,
      path: path.value,
      price: price,
      title: productName,
    );

    if (response != null) {
      if (response["is_error"] ?? true) {
        EasyLoading.dismiss();
        print(response);
        Get.snackbar(
          "Gagal",
          "Terjadi kesalahan saat memproses data, silahkan coba lagi dalam beberapa saat",
        );
        return;
      }
      success(status: "Berhasil menambahkan product");
      productName = "";
      description = "";
      price = "";
      categoryId.value = -1;
      path.value = "";
      print(response["data"]["product"]);
      products.add(Product.fromJson(response["data"]["product"]));
      // Get.snackbar("Success", "Product telah berhasil ditambahkan",
      //     barBlur: 15, overlayBlur: 1.3);
    }
    EasyLoading.dismiss();
  }

  void getImage() async {
    final picker = ImagePicker();
    final pickedFile = await picker.getImage(
      source: ImageSource.gallery,
      preferredCameraDevice: CameraDevice.rear,
      imageQuality: 30,
    );
    if (pickedFile != null && pickedFile.path != null) {
      print("Success save image");
      path?.value = pickedFile.path;
      return;
    }
    print("not saved :(");
    return;
  }

  void deleteProduct(int productId) async {
    print("removing product with id $productId");
    loading();
    var json = await ProductServices.removeProduct(productId);
    if (json["is_error"]) {
      print(json);
      EasyLoading.dismiss();
      if (!Get.isSnackbarOpen && !Get.isDialogOpen)
        Get.snackbar(
          "Gagal",
          "Terjadi kesalahan saat memproses data, silahkan coba lagi dalam beberapa saat",
        );
      return;
    }
    products.removeWhere((element) => element.id == productId);
    success(status: "Berhasil menghapus product");
  }

  String productNameForUpdate = "";
  String priceForUpdate = "";
  String descriptionForUpdate = "";
  RxString pathImgForUpdate = "".obs;
  RxInt categoryIdForUpdate = (-1).obs;

  void getImageForUpdate() async {
    final picker = ImagePicker();
    final pickedFile = await picker.getImage(
      source: ImageSource.gallery,
      preferredCameraDevice: CameraDevice.rear,
      imageQuality: 30,
    );
    if (pickedFile != null && pickedFile.path != null) {
      print("Success save image");
      pathImgForUpdate.value = pickedFile.path;
      return;
    }
    print("not saved :(");
    return;
  }

  void updateProduct(int productId, String defaultImgUrl) async {
    print("sending request to endpoint update product");
    if (categoryIdForUpdate.value <= 0 ||
        priceForUpdate.length <= 0 ||
        descriptionForUpdate.length <= 0 ||
        productNameForUpdate.length <= 0) {
      Get.snackbar(
        "Gagal",
        "Silahkan isi semua field yang ada terlebih dahulu",
        overlayBlur: 1.2,
        barBlur: 15,
        duration: Duration(milliseconds: 1800),
        animationDuration: Duration(milliseconds: 350),
      );
      return;
    }
    Map<String, dynamic> response;
    loading();
    if (pathImgForUpdate.value.length <= 0) {
      response = await ProductServices.updateProduct(
        categoryId: categoryIdForUpdate.value.toString(),
        description: descriptionForUpdate,
        path: defaultImgUrl,
        price: priceForUpdate,
        title: productNameForUpdate,
        productId: productId,
        useDefaultImg: true,
      );
    } else {
      response = await ProductServices.updateProduct(
        categoryId: categoryIdForUpdate.value.toString(),
        description: descriptionForUpdate,
        path: pathImgForUpdate.value,
        price: priceForUpdate,
        title: productNameForUpdate,
        productId: productId,
        useDefaultImg: false,
      );
    }

    if (response != null) {
      if (response["is_error"] ?? true) {
        EasyLoading.dismiss();
        print(response);
        Get.snackbar(
          "Gagal",
          "Terjadi kesalahan saat memproses data, silahkan coba lagi dalam beberapa saat",
        );
        return;
      }

      productNameForUpdate = response["data"]["product"]["title"];
      descriptionForUpdate = response["data"]["product"]["description"];
      priceForUpdate = response["data"]["product"]["price"];
      // categoryIdForUpdate.value = response["data"]["product"]["category_id"];
      categoryIdForUpdate.value = -1;
      pathImgForUpdate.value = "";
      print(response["data"]["product"]);
      var idxProd =
          products.indexWhere((p) => p.id == response["data"]["product"]["id"]);
      var newUpdatedProduct = Product.fromJson(response['data']['product']);
      if (idxProd != -1) {
        products[idxProd] = newUpdatedProduct;
      }
      success(status: "Berhasil memperbarui product");
      // products.refresh();
      // Get.snackbar(
      //   "Success",
      //   "Product telah berhasil diperbarui",
      //   animationDuration: Duration(milliseconds: 350),
      //   duration: Duration(milliseconds: 1400),
      // );

    }
  }
}
