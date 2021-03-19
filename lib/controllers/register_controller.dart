import 'package:cool_alert/cool_alert.dart';
import 'package:get/get.dart';
import 'package:storedoor/constants.dart';
import 'package:storedoor/helper/validation.dart';
import 'package:storedoor/services/auth_services.dart';
import 'package:storedoor/view/screen/login/login_screen.dart';
import 'package:storedoor/view/widgets/no_internet.dart';

class RegisterController extends GetxController {
  var username = "".obs;
  var email = "".obs;
  var password = "".obs;
  var fullname = "".obs;

  var errorTextUsername = RxString(null);
  var errorTextEmail = RxString(null);
  var errorTextPassword = RxString(null);
  var errorTextFullname = RxString(null);
  Rx<Function> submitFunc = Rx<Function>(null);

  var isLoading = false.obs;

  @override
  void onInit() {
    debounce(username, validateUsername, time: Duration(milliseconds: 500));
    debounce(fullname, validateFullname, time: Duration(milliseconds: 500));
    debounce(email, validateEmail, time: Duration(milliseconds: 500));
    debounce(password, validatePassword, time: Duration(milliseconds: 500));
    errorTextEmail.value = null;
    errorTextFullname.value = null;
    errorTextPassword.value = null;
    errorTextUsername.value = null;
    email(null);
    password(null);
    username(null);
    fullname(null);
    super.onInit();
  }

  Future<bool> validateFullname(String val) async {
    errorTextFullname.value = null; // reset validation errors to nothing
    submitFunc.value = null; // disable submit while validating
    if (val.isNotEmpty) {
      if (val.length >= 4 && isAlphaWhitespace(val)) {
        // submitFunc.value = submitFunction();
        errorTextFullname.value = null;
        return true;
      } else if (!isAlphaWhitespace(val)) {
        errorTextFullname.value = "Nama hanya boleh berisi huruf";
      } else {
        errorTextFullname.value = "Min. 4 karakter";
      }
    } else {
      errorTextFullname.value = "Nama tidak boleh kosong";
    }
    return false;
  }

  Future<bool> validateUsername(String val) async {
    errorTextUsername.value = null; // reset validation errors to nothing
    submitFunc.value = null; // disable submit while validating
    if (val.isNotEmpty) {
      if (val.length >= 6 && isAlphaNum(val)) {
        // submitFunc.value = submitFunction();
        errorTextUsername.value = null;
        return true;
      } else if (!isAlphaNum(val)) {
        errorTextUsername.value =
            "Username hanya boleh berisi huruf atau angka";
      } else {
        errorTextUsername.value = "Min. 6 karakter";
      }
    } else {
      errorTextUsername.value = "Username tidak boleh kosong";
    }
    return false;
  }

  Future<bool> validateEmail(String val) async {
    errorTextEmail.value = null; // reset validation errors to nothing
    submitFunc.value = null; // disable submit while validating
    if (val.isNotEmpty) {
      if (GetUtils.isEmail(val)) {
        // submitFunc.value = submitFunction();
        errorTextUsername.value = null;
        return true;
      } else {
        errorTextEmail.value = "Email invalid";
      }
    } else {
      errorTextEmail.value = "Email tidak boleh kosong";
    }
    return false;
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
        if (await validateEmail(email.value) &&
            await validateUsername(username.value) &&
            await validateFullname(fullname.value)) {
          submitFunc.value = submitFunction();
          errorTextPassword.value = null;
          return true;
        }
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

  Future<bool> Function() submitFunction() {
    return () async {
      isLoading(true);
      if (await validatePassword(password.value)) {
        submitFunc.value = submitFunction();
      } else {
        submitFunc.value = null;
      }
      Map<String, dynamic> res = await AuthServices.registerUser(
        fullname.value,
        email.value,
        username.value,
        password.value,
      );

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

    await Future.delayed(
          Duration(milliseconds: 1000), () => isLoading(false));
      if (res["is_error"]) {
        String errorMessage = "";
        for (String i in res["errors"]) {
          errorMessage += i;
          errorMessage += " ";
        }

        CoolAlert.show(
          context: Get.context,
          type: CoolAlertType.error,
          title: res["message"],
          text: errorMessage,
          confirmBtnColor: mPrimaryColor,
          backgroundColor: mPrimaryColor,
          borderRadius: 7,
        );

        return false;
      } else {
        CoolAlert.show(
          context: Get.context,
          type: CoolAlertType.success,
          onConfirmBtnTap: () {
            Get.off(LoginScreen());
          },
          title: "Berhasil Didaftarkan",
          text: "Silahkan login terlebih dahulu",
          confirmBtnColor: mPrimaryColor,
          backgroundColor: mPrimaryColor,
          borderRadius: 7,
        );
      }
      return true;
    };
  }

  // Future<bool> available(String val) async {
  //   print('Query availability of: $val');
  //   await Future.delayed(
  //       Duration(seconds: 1),
  //       () => print('Available query returned')
  //   );

  //   if (val == "Sylvester") {
  //     errorText.value = 'Name Taken';
  //     return false;
  //   }
  //   return true;
  // }

  void fullnameChanged(String val) {
    fullname.value = val.trim();
  }

  void usernameChanged(String val) {
    username.value = val.trim().replaceAll(' ', '');
  }

  void emailChanged(String val) {
    email.value = val.trim().replaceAll(' ', '');
  }

  void passwordChanged(String val) {
    password.value = val;
  }
}
