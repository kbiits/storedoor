import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:storedoor/controllers/user_controller.dart';
import 'package:storedoor/services/auth_services.dart';
import 'package:storedoor/view/screen/dashboard/dashboard_screen.dart';
import 'package:storedoor/view/screen/home/home_screen.dart';
import 'package:storedoor/view/widgets/no_internet.dart';

class LoginController extends GetxController {
  var accountData = "".obs;
  var password = "".obs;

  var errorTextAccountData = RxString(null);
  var errorTextPassword = RxString(null);
  Rx<Function> submitFunc = Rx<Function>(null);

  var isLoading = false.obs;

  // RxBool isLogged = false.obs;

  @override
  void onInit() {
    print("init login controller");
    debounce(accountData, validateAccountData,
        time: Duration(milliseconds: 500));
    debounce(password, validatePassword, time: Duration(milliseconds: 500));
    errorTextAccountData.value = null;
    errorTextPassword.value = null;
    // accountData.value = null;
    // password.value = null;
    super.onInit();
  }

  Future<bool> validateAccountData(String val) async {
    errorTextAccountData.value = null; // reset validation errors to nothing
    submitFunc.value = null; // disable submit while validating
    if (val?.isNotEmpty ?? false) {
      if (GetUtils.isEmail(val) || val.length >= 6) {
        if (val.contains('@')) {
          if (!GetUtils.isEmail(val)) {
            errorTextAccountData.value = "Invalid email";
          }
        } else {
          errorTextAccountData.value = null;
          return true;
        }
      } else if (val.length < 6) {
        errorTextAccountData.value = "Username min. 6 karakter";
      }
    } else {
      errorTextAccountData.value = "Username atau Email tidak boleh kosong";
    }
    return false;
  }

  Future<bool> validatePassword(String val) async {
    errorTextPassword.value = null; // reset validation errors to nothing
    submitFunc.value = null; // disable submit while validating
    if (val?.isNotEmpty ?? false) {
      if (val.length >= 8) {
        submitFunc.value = submitFunction();
        print('All validations passed, enable submit btn...');
        // if (await validateAccountData(accountData.value)) {
        errorTextPassword.value = null;
        return true;
        // }
      } else {
        errorTextPassword.value = "Min. 8 karakter";
      }
    } else {
      errorTextPassword.value = "Password tidak boleh kosong";
    }
    return false;
  }

  Future<bool> Function() submitFunction() {
    return () async {
      isLoading.value = true;
      print("submitted");
      print("submitted account data : " + accountData.value);
      print("submitted password data : " + password.value);
      if (await validatePassword(password.value)) {
        submitFunc.value = submitFunction();
      } else {
        submitFunc.value = null;
      }
      Map<String, dynamic> res =
          await AuthServices.loginUser(accountData.value, password.value);

      if (res == null) {
        isLoading(false);
        // CoolAlert.show(
        //   context: Get.context,
        //   type: CoolAlertType.error,
        //   title: "Tidak ada koneksi internet",
        //   text:
        //       "Pastikan anda memiliki koneksi internet sebelum melakukan pendaftaran",
        //   confirmBtnColor: mPrimaryColor,
        //   backgroundColor: mPrimaryColor,
        //   borderRadius: 7,
        // );
        noInternet();
        return false;
      }

      // Delay for loading
      await Future.delayed(
          Duration(milliseconds: 1000), () => isLoading(false));
      if (res["is_error"]) {
        if (!Get.isSnackbarOpen) {
          Get.snackbar(
            "Gagal Login",
            res["errors"],
            overlayBlur: 1.5,
            barBlur: 1.5,
            duration: Duration(milliseconds: 1200),
          );
        }
        return false;
      } else {
        UserController.email.value = res["data"]["user"]["email"];
        UserController.username.value = res["data"]["user"]["username"];
        UserController.id.value = res["data"]["user"]["id"];
        UserController.token.value = res["token"];
        UserController.avatar.value = res["data"]["user"]["avatar"];
        UserController.fullname.value = res["data"]["user"]["fullname"];
        print("user token " + UserController.token.value);
        print("username " + UserController.username.value);
        print("email" + UserController.email.value);
        print("id user " + UserController.id.value.toString());
        print("avatar user " + UserController.avatar.value.toString());
        print("fullname " + UserController.fullname.value.toString());
        // checkLogin();
        Get.offAll(() => DashboardScreen());
      }
      return true;
    };
  }

  // void checkLogin() async {
  //   GetStorage storage = GetStorage();
  //   var token = storage.read("token");
  //   var isLogged = storage.read("isLogged");
  //   // if (isLogged && token != null) {
  //     // isLogged(true);
  //   // } else {
  //     // isLogged(false);
  //   // }
  // }

  static void logout() async {
    GetStorage storage = GetStorage();
    storage.remove("token");
    storage.remove("isLogged");
    storage.remove("fullname");
    storage.remove("username");
    storage.remove("email");
    storage.remove("id");
    storage.remove("avatar");
    Get.offAll(HomeScreen());
    // isLogged(false);
  }

  void accountDataChanged(String val) {
    accountData.value = val.trim().replaceAll(' ', '');
  }

  void passwordChanged(String val) {
    password.value = val.trim().replaceAll(' ', '');
  }
}
