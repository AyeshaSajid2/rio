import 'dart:async';

import 'package:get/get.dart';

class ProgressController extends GetxController {
//Progress
  RxDouble percentageIndicator = 0.0.obs;
  //Reboot = true & Factory Reset = false when progress is called
  bool isRebootActivated = false;
  int minutes = 0;
  late Map arg;
  @override
  void onInit() {
    arg = Get.arguments;
    isRebootActivated = arg['isReboot'];
    minutes = arg['Minutes'];
    super.onInit();
  }

  @override
  void onReady() {
    startTimer(minutes);
    super.onReady();
  }

  @override
  void onClose() {
    //
    super.onClose();
  }

  startTimer(int minutes) {
    Duration totalDuration = Duration(minutes: minutes);

    // Create a timer that fires every 1 second
    Timer.periodic(const Duration(seconds: 1), (Timer t) {
      percentageIndicator.value = (t.tick / totalDuration.inSeconds) * 100;
      if (t.tick == totalDuration.inSeconds) {
        t.cancel();
      }
    });
  }
}
