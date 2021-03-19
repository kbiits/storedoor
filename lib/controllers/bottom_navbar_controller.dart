import 'package:get/get.dart';
import 'package:storedoor/enums.dart';

class BottomNavbarController extends GetxController {
  var _selectedMenu = ScreenBottomBar.home.obs;

  @override
  void onInit() {
    _selectedMenu(ScreenBottomBar.home);
    super.onInit();
  }

  ScreenBottomBar get selectedMenu => _selectedMenu.value;
  set selectedMenu(ScreenBottomBar i) => _selectedMenu.value = i;
}
