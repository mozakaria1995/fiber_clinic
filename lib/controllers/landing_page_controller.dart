import 'package:get/state_manager.dart';

class LandingPageController extends GetxController {
  Rx<int> tabIndex = 0.obs;

  void changeTabIndex(int index) {
    tabIndex.value = index;
    print(tabIndex.value);
  }

  @override
  void onInit() {
    super.onInit();
  }

  @override
  void dispose() {
    super.dispose();
  }
}
