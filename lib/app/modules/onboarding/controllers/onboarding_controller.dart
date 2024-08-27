import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wifi_iot/wifi_iot.dart';

import '../../../../core/extensions/imports.dart';
import '../../../../core/utils/services/wifi_method_channel.dart';
import '../../../routes/app_pages.dart';

class OnboardingController extends GetxController
    with GetTickerProviderStateMixin {
  late final TabController onboardingTabController;
  final GlobalKey<FormState> connectKey = GlobalKey<FormState>();

  TextEditingController ssidTEC = TextEditingController();
  TextEditingController passwordTEC = TextEditingController();

  List<String> tabsList = [
    'Option 1',
    'Option 2',
    // 'Option 3',
  ];

  RxBool isWifiConnected = false.obs;
  RxBool showPassword = false.obs;

  RxDouble percentageIndicator = 0.0.obs;

  @override
  void onInit() {
    //
    onboardingTabController =
        TabController(length: tabsList.length, vsync: this);

    super.onInit();
  }

  @override
  void onReady() {
    //
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

  connectToWifiNetwork(
    String ssid,
    String password,
  ) {
    if (Platform.isAndroid) {
      androidWifiConnect(ssid, password);
    } else if (Platform.isIOS) {
      iosWifiConnect(ssid, password);
      // iosBatteryLevel();
    }
  }

  Future<void> runUntilTrue() async {
    int i = 0;
    bool result = await WiFiForIoTPlugin.isConnected();
    if (!result && i <= 30) {
      log(" 🟥 False to connect to Wi-Fi 🟥");
      // If the result is false, call the function again
      await Future.delayed(const Duration(seconds: 1));
      i++;
      await runUntilTrue();
    } else if (i > 30) {
      constants.showSnackbar(
          'WiFi Status', 'WiFi connection failed. Try again', 0);
      return;
    } else {
      isWifiConnected.value = false;
      Get.offAndToNamed(Routes.ADMIN_LOGIN);
      // if (asKeyStorage.getAsKeyDeviceToken() == '') {
      //   Get.to(() => const WaitingScreenView());
      //   startTimer(1);
      // } else {
      //   Get.offAndToNamed(Routes.ADMIN_LOGIN);
      // }
    }
  }

  // Connect Wifi For Android
  Future<void> androidWifiConnect(String ssid, String password) async {
    try {
      isWifiConnected.value = await WiFiForIoTPlugin.connect(
        ssid,
        password: password,
        joinOnce: false,
        withInternet: true,
        isHidden: true,
        security: NetworkSecurity.WPA,
      );

      if (isWifiConnected.value) {
        await runUntilTrue();

        log(" 🟩  Connected to WiFi: $ssid 🟩 ");
      } else {
        constants.showSnackbar('WiFi', "Failed to connect to WiFi", 0);
        log(" 🟥 Failed to connect to Wi-Fi: $ssid  🟥 ");
      }
    } catch (e) {
      log(" 🟥 Error connecting to WiFi: $e  🟥 ");
    }
  }

  /// Method for iOS Connect Wifi
  Future<void> iosWifiConnect(String ssid, String password) async {
    try {
      isWifiConnected.value = true;
      bool isConnected = await WifiMethodChannel.connectToWifi(ssid, password);

      if (isConnected) {
        isWifiConnected.value = false;
        constants.showSnackbar(
            'WiFi', "Successfully connected to Rio WiFi Network", 1);
        // if (asKeyStorage.getAsKeyDeviceToken() == '') {
        //   Get.to(() => const WaitingScreenView());
        //   startTimer(1);
        // } else {
        //   Get.offAndToNamed(Routes.ADMIN_LOGIN);
        // }
        Get.offAndToNamed(Routes.ADMIN_LOGIN);
        log(" 🟩 Connected to WiFi 🟩 ");
      } else {
        isWifiConnected.value = false;
        constants.showSnackbar('WiFi',
            "Failed to connect to Rio WiFi. Try again or use option 3", 0);
        log(" 🟥 Failed to connect to WiFi 🟥 ");
      }
    } catch (e) {
      isWifiConnected.value = false;
      constants.showSnackbar('WiFi', "Failed to connect to WiFi", 0);
      log(" 🟥 Error connecting to WiFi: $e 🟥 ");
    }
  }

  /// Method for iOS Connect Wifi
  Future<void> iosBatteryLevel() async {
    try {
      isWifiConnected.value = true;
      int batteryLevel = await WifiMethodChannel.getBatteryLevel();

      isWifiConnected.value = false;

      log("Battery Level: $batteryLevel");
      log(" 🟩 Connected to BatteryLevel 🟩 ");
    } catch (e) {
      isWifiConnected.value = false;
      constants.showSnackbar('Wi-Fi', "Failed to connect to WiFi", 0);
      log(" 🟥 Error connecting to WiFi: $e 🟥 ");
    }
  }
}
