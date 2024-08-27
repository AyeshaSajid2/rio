import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:usama/app/data/models/sign_up_apis/get_user_model.dart';
import 'package:usama/app/data/models/wifi/get_wifi_model.dart';

class WifiOnBoardingController extends GetxController {
  var wifiModel = GetWifiModel().obs;
  final GlobalKey<FormState> signInKey = GlobalKey<FormState>();

  RxBool showLoader = false.obs;
  RxBool isNetworkError = false.obs;
  RxBool isServerError = false.obs;

  RxBool showPassword = false.obs;
  RxBool isTermsAccepted = false.obs;

  TextEditingController emailTextCtrl = TextEditingController();
  TextEditingController passwordTextCtrl = TextEditingController();

  GetUserModel getUserModel = GetUserModel();

  bool isEmailVerified = false;

  void updateSSID(String ssid) {
    wifiModel.update((val) {
      val?.name = ssid; // Assuming 'name' is used for SSID
    });
  }

  void updatePassword(String password) {
    wifiModel.update((val) {
      val?.password = password;
    });
  }

  void submit() {
    // Handle submission logic here
    print(
        'SSID: ${wifiModel.value.name}, Password: ${wifiModel.value.password}');
  }
}
