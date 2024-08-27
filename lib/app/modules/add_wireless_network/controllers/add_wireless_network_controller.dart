import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import '../../../../core/extensions/imports.dart';

import '../../../data/models/status_model.dart';
import '../../../data/params/wifi/set_wifi_param.dart';
import '../../wireless_network/controllers/wireless_network_controller.dart';

class AddWirelessNetworkController extends GetxController {
  final GlobalKey<FormState> addWifiKey = GlobalKey<FormState>();

  final wirelessNetworkController = Get.find<WirelessNetworkController>();

  RxDouble pageHeight = (Get.height).obs;
  List<bool> didErrorOccurred = [
    false,
    false,
    false,
    false,
  ];

  RxBool showLoader = false.obs;
  RxBool isNetworkError = false.obs;
  RxBool isServerError = false.obs;

  RxBool showWiFiPassword = false.obs;
  RxBool showConfirmWiFiPassword = false.obs;
  RxBool showAdminPassword = false.obs;
  RxBool showConfirmAdminPassword = false.obs;

  final box = GetStorage('AsKey');

  TextEditingController wifiNameTEC = TextEditingController();
  TextEditingController wifiPasswordTEC = TextEditingController();
  TextEditingController wifiConfirmPasswordTEC = TextEditingController();
  TextEditingController frequencyTEC = TextEditingController();
  TextEditingController securitySettingsTEC = TextEditingController();
  TextEditingController wpaEncryptionTEC = TextEditingController();
  TextEditingController broadcastTEC = TextEditingController();
  @override
  void onInit() {
    frequencyTEC.text = '2.4G/5G';
    securitySettingsTEC.text = 'WPA2 Personal';
    wpaEncryptionTEC.text = 'AES-128';
    broadcastTEC.text = 'Enable';
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

  void updateScreenSize(int index) {
    if (!didErrorOccurred[index]) {
      pageHeight.value = pageHeight.value + (Get.height * 0.025);
      didErrorOccurred[index] = true;
    }
  }

  SetWifiParam fillAddWifi() {
    return SetWifiParam(
        action: 'create',
        id: '',
        name: wifiNameTEC.text,
        status: 'enable',
        password: wifiPasswordTEC.text,
        broadcast: broadcastTEC.text.toLowerCase());
  }

  Future<StatusModel?> setWifi(SetWifiParam setWifiParam) async {
    showLoader.value = true;
    isNetworkError.value = false;
    isServerError.value = false;

    final connectivityResult = await (Connectivity().checkConnectivity());
    if (connectivityResult.contains(ConnectivityResult.none)) {
      constants.showSnackbar('Network Error', 'No internet access', 0);
      showLoader.value = false;
      isServerError.value = false;
      isNetworkError.value = true;
      return null;
    }

    Map params = setWifiParam.toJson();

    String url = AppConstants.baseUrlAsKey + EndPoints.wifiSetEndPoint;

    final response = await apiUtilsWithHeader.put(
        url: url, data: jsonEncode(params), firstTime: true);

    return response.fold((l) {
      showLoader.value = false;

      return null;
    }, (r) async {
      StatusModel status = StatusModel.fromJson(r.data);

      showLoader.value = false;

      constants.showSnackbar(
          'Wireless Network', 'Successfully added new wireless network', 1);

      await wirelessNetworkController.callGetWifiList();

      Get.back();

      return status;
    });
  }
}
