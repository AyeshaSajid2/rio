import 'package:get/get.dart';

class SsidCheckController extends GetxController {
  var currentScreenIndex = 0.obs;

  void switchScreen(int index) {
    currentScreenIndex.value = index;
  }
}
