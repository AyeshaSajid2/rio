import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import 'package:usama/app/routes/app_pages.dart';
import 'package:wifi_iot/wifi_iot.dart';

import '../../../../core/extensions/imports.dart';
import '../../../../core/utils/services/wifi_method_channel.dart';

class ScannerController extends GetxController
    with GetTickerProviderStateMixin {
  late AnimationController animationController;
  late Animation<double> animation;
  MobileScannerController mobileScannerController = MobileScannerController(
    detectionSpeed: DetectionSpeed.normal,
    detectionTimeoutMs: 500,
    facing: CameraFacing.back,
    formats: [BarcodeFormat.qrCode],
    torchEnabled: false,
  );

  RxBool isWifiConnected = false.obs;

  @override
  void onInit() {
    animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1000),
    );

    animation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: animationController,
        curve:
            Curves.elasticOut, // Use an elastic curve for the bouncing effect
      ),
    );

    // animation =
    //     Tween<double>(begin: 0.0, end: 1.0).animate(_animationController);

    animationController.forward();
    super.onInit();
  }

  @override
  void onReady() {
    //
    super.onReady();
  }

  @override
  void onClose() {
    mobileScannerController.dispose();
    animationController.dispose();

    super.onClose();
  }

  connectToWifiNetwork(
    String ssid,
    String password,
  ) {
    if (Platform.isAndroid) {
      androidWifiConnect(ssid, password);
    } else if (Platform.isIOS) {
      iosWifiConnect(ssid, password);
    }
  }

  Future<void> runUntilTrue() async {
    bool result = await WiFiForIoTPlugin.isConnected();
    if (!result) {
      log(" 🟥 False to connect to Wi-Fi 🟥");
      // If the result is false, call the function again
      await Future.delayed(const Duration(seconds: 1));
      await runUntilTrue();
    } else {
      Get.offAndToNamed(Routes.ADMIN_LOGIN);
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

        log(" 🟩  Connected to Wi-Fi: $ssid 🟩 ");
      } else {
        constants.showSnackbar('Wi-Fi', "Failed to connect to WiFi", 0);
        log(" 🟥 Failed to connect to Wi-Fi: $ssid  🟥 ");
      }
    } catch (e) {
      log(" 🟥 Error connecting to Wi-Fi: $e  🟥 ");
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
        Get.offAndToNamed(Routes.ADMIN_LOGIN);
        log(" 🟩 Connected to WiFi 🟩 ");
      } else {
        isWifiConnected.value = false;

        Get.back();

        constants.showSnackbar(
            'WiFi', "Failed to connect to WiFi. Try again or use option 3", 0);
        log(" 🟥 Failed to connect to WiFi 🟥 ");
      }
    } catch (e) {
      isWifiConnected.value = false;
      constants.showSnackbar('WiFi', "Failed to connect to WiFi", 0);
      log(" 🟥 Error connecting to WiFi: $e 🟥 ");
    }
  }
}
