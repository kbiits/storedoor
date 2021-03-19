import 'package:cool_alert/cool_alert.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:image_picker/image_picker.dart';
import 'package:storedoor/constants.dart';
import 'package:storedoor/helper/loading_success.dart';
import 'package:storedoor/helper/validation.dart';
import 'package:storedoor/services/user_services.dart';
import 'package:storedoor/view/widgets/no_internet.dart';

class UserController extends GetxController {
  static var username = "".obs;
  static var email = "".obs;
  static var id = 0.obs;
  static var token = "".obs;
  static var avatar = "".obs;
  static var fullname = "".obs;

  var obscureText = true.obs;

  var fullnameTextField = "".obs;
  var usernameTextField = "".obs;
  var emailTextField = "".obs;
  var passwordTextField = "".obs;
  var oldPasswordTextField = "".obs;

  var isLoading = false.obs;

  var errorTextFullname = RxString(null);
  var errorTextUsername = RxString(null);
  var errorTextEmail = RxString(null);
  var errorTextPassword = RxString(null);
  var errorTextOldPassword = RxString(null);
  Rx<Function> submitFunc = Rx<Function>(null);

  @override
  void onInit() {
    obscureText(true);
    debounce(usernameTextField, validateUsername,
        time: Duration(milliseconds: 500));
    debounce(emailTextField, validateEmail, time: Duration(milliseconds: 500));
    debounce(fullnameTextField, validateFullname,
        time: Duration(milliseconds: 500));
    debounce(passwordTextField, validatePassword,
        time: Duration(milliseconds: 500));

    errorTextEmail.value = null;
    errorTextFullname.value = null;
    errorTextPassword.value = null;
    errorTextUsername.value = null;

    // _imagePath("");
    super.onInit();
  }

  void fullnameChanged(String val) {
    fullnameTextField.value = val;
  }

  void usernameChanged(String val) {
    usernameTextField.value = val.trim().replaceAll(' ', '');
  }

  void emailChanged(String val) {
    emailTextField.value = val.trim().replaceAll(' ', '');
  }

  void passwordChanged(String val) {
    passwordTextField.value = val;
  }

  void validateFullname(String val) async {
    errorTextFullname.value = null; // reset validation errors to nothing
    submitFunc.value = null; // disable submit while validating
    if (val.isNotEmpty) {
      if (val.length >= 4 && isAlphaWhitespace(val)) {
        submitFunc.value = submitFunction();
        errorTextFullname.value = null;
        // return true;
      } else if (!isAlphaWhitespace(val)) {
        errorTextFullname.value = "Nama hanya boleh berisi huruf";
      } else {
        errorTextFullname.value = "Min. 4 karakter";
      }
    } else {
      errorTextFullname.value = "Nama tidak boleh kosong";
    }
    // return false;
  }

  void validateUsername(String val) async {
    errorTextUsername.value = null; // reset validation errors to nothing
    submitFunc.value = null; // disable submit while validating
    if (val.isNotEmpty) {
      if (val.length >= 6 && isAlphaNum(val)) {
        submitFunc.value = submitFunction();
        errorTextUsername.value = null;
        // return true;
      } else if (!isAlphaNum(val)) {
        errorTextUsername.value =
            "Username hanya boleh berisi huruf atau angka";
      } else {
        errorTextUsername.value = "Min. 6 karakter";
      }
    } else {
      errorTextUsername.value = "Username tidak boleh kosong";
    }
    // return false;
  }

  void validateEmail(String val) async {
    errorTextEmail.value = null; // reset validation errors to nothing
    submitFunc.value = null; // disable submit while validating
    if (val.isNotEmpty) {
      if (GetUtils.isEmail(val)) {
        submitFunc.value = submitFunction();
        errorTextUsername.value = null;
        // return true;
      } else {
        errorTextEmail.value = "Email invalid";
      }
    } else {
      errorTextEmail.value = "Email tidak boleh kosong";
    }
    // return false;
  }

  Future<bool> validatePassword(String val) async {
    errorTextPassword.value = null; // reset validation errors to nothing
    submitFunc.value = null; // disable submit while validating
    if (val.isNotEmpty) {
      if (val.length >= 8 &&
          hasLowercase(val) &&
          hasUppercase(val) &&
          hasNumeric(val)) {
        print('All validations passed, enable submit btn...');
        // if (await validateEmail(emailTextField.value) &&
        // await validateUsername(usernameTextField.value) &&
        // await validateFullname(fullnameTextField.value)) {
        submitFunc.value = submitFunction();
        errorTextPassword.value = null;
        return true;
        // }
      } else if (!hasNumeric(val)) {
        errorTextPassword.value = "Password harus berisi angka";
      } else if (!hasUppercase(val)) {
        errorTextPassword.value = "Password harus berisi huruf kapital";
      } else if (val.length < 8) {
        errorTextPassword.value = "Min. 8 karakter";
      }
    } else {
      errorTextPassword.value = "Password tidak boleh kosong";
    }
    return false;
  }

// Submit function for updating user
  Future<bool> Function() submitFunction() {
    return () async {
      isLoading(true);
      loading();
      Map<String, dynamic> res = await UserServices.updateUser(
        fullnameTextField.value.length <= 0
            ? fullname.value
            : fullnameTextField.value,
        emailTextField.value.length <= 0
            ? email.value
            : emailTextField.value ?? email,
        usernameTextField.value.length <= 0
            ? username.value
            : usernameTextField.value ?? username,
        passwordTextField.value,
      );
      print(res);

      if (res == null) {
        isLoading(false);
        noInternet();
        return false;
      }

      await Future.delayed(
        Duration(milliseconds: 1000),
        () {
          isLoading(false);
        },
      );
      if (res["is_error"] == true) {
        EasyLoading.dismiss();
        CoolAlert.show(
          context: Get.context,
          type: CoolAlertType.error,
          text: "Gagal memperbarui data anda",
          title: "Terjadi kesalahan",
          confirmBtnColor: mPrimaryColor,
          backgroundColor: mPrimaryColor,
          borderRadius: 7,
        );
        return false;
      } else {
        GetStorage storage = GetStorage();

        // Update username
        storage.write("username", res["data"]["user"]["username"]);
        UserController.username.value = res["data"]["user"]["username"];

        // Update email
        storage.write("email", res["data"]["user"]["email"]);
        UserController.email.value = res["data"]["user"]["email"];

        // Update id
        storage.write("id", res["data"]["user"]["id"]);
        UserController.id.value = res["data"]["user"]["id"];

        // Update fullname
        storage.write("fullname", res["data"]["user"]["fullname"]);
        UserController.fullname.value = res["data"]["user"]["fullname"];

        // Get.snackbar(
        //   "Success",
        //   "Data berhasil diperbarui",
        //   barBlur: 10,
        //   dismissDirection: SnackDismissDirection.HORIZONTAL,
        //   isDismissible: true,
        //   duration: Duration(milliseconds: 1900),
        //   animationDuration: Duration(milliseconds: 780),
        //   overlayBlur: 1.5,
        // );
        success(status: "Data berhasil diubah");
      }
      return true;
    };
  }

  // RxString _imagePath = "".obs;

  // get imagePath => _imagePath;
  // set imagePath(String val) => _imagePath(val);

  void getImage() async {
    final picker = ImagePicker();
    final pickedFile = await picker.getImage(
      source: ImageSource.gallery,
      preferredCameraDevice: CameraDevice.rear,
      imageQuality: 30,
    );
    if (pickedFile != null && pickedFile.path != null) {
      // if (pickedFile.path != null) imagePath = pickedFile.path;
      print("Success save image");
      uploadImage(pickedFile.path);
      return;
    }
    return;
  }

  void uploadImage(String path) async {
    loading();
    Map<String, dynamic> res = await UserServices.updateProfilePict(path);
    // print(res);
    if (res == null) {
      EasyLoading.dismiss();
      noInternet();
      return;
    } else {
      if (res["is_error"] == true) {
        EasyLoading.dismiss();
        Get.snackbar("Gagal", res["message"], overlayBlur: 1.5, barBlur: 5);
      } else {
        avatar.value = res["avatar"];
        var newAvatarUrl = res["avatar"];
        GetStorage storage = GetStorage();
        storage.write("avatar", newAvatarUrl);
        success(status: "Foto profil telah diperbarui");
      }
    }
  }
}
