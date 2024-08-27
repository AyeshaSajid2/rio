import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:usama/core/utils/helpers/askey_storage.dart';
import 'package:usama/core/utils/services/api/repository/common_repository.dart';

import '../../../../core/extensions/imports.dart';

import '../../../../core/theme/colors.dart';
import '../../../data/models/status_model.dart';
import '../../../data/models/wifi/get_wifi_list_model.dart';
import '../../../data/params/wifi/set_wifi_param.dart';

class WirelessNetworkController extends GetxController {
  ScrollController scrollController = ScrollController();

  List<GlobalKey<FormState>> listOfWirelessNetworkKey = [];

  RxBool showLoader = false.obs;
  RxBool isNetworkError = false.obs;
  RxBool isServerError = false.obs;

  List<RxBool> listOfShowWiFiPassword = [];

  // final box = GetStorage('AsKey');

  GetWifiListModel getWifiListModel = GetWifiListModel();

  List<RxString> listOfWifiStatuses = <RxString>[].obs;

  List<TextEditingController> listOfWifiNameTEC = [];
  List<String> listOfSuffixText = ['-Admin', '-Managed', '-Guest', '-Shared'];
  List<TextEditingController> listOfWifiPasswordTEC = [];

  List<RxString> listOfBroadcastValue = [];

  bool isFirstTimer = false;

  @override
  void onInit() {
    //
    isFirstTimer = Get.arguments ?? false;

    callGetWifiList();
    super.onInit();
  }

  @override
  void onReady() {
    //
    super.onReady();
  }

  @override
  void onClose() {
    listOfWirelessNetworkKey.clear();
    listOfWifiStatuses.clear();
    listOfWifiNameTEC.clear();
    listOfWifiPasswordTEC.clear();
    listOfBroadcastValue.clear();
    listOfShowWiFiPassword.clear();
    super.onClose();
  }

  String removeStrings(String input, List<String> stringsToRemove) {
    String pattern = stringsToRemove.map((s) => RegExp.escape(s)).join('|');
    RegExp regex = RegExp(pattern, caseSensitive: false);
    return input.replaceAll(regex, '');
  }

  void save(int index) {
    bool wifiNameChanged = false;

    if (getWifiListModel.listOfWifi![index].id == '0' &&
        (getWifiListModel.listOfWifi![index].password !=
            listOfWifiPasswordTEC[index].text)) {
      Dialogs.showAlertDialogueForSSID(
          context: Get.context!,
          msg:
              'Important: Network Disconnection Required\n\nYou are about to change your Wi-Fi network\'s password. This action will disconnect your device as well all devices currently connected to the network. After making these changes, please follow these steps:\n\n1. Go back to your device\'s Wi-Fi settings.\n2. Find and select the Wi-Fi network with the Admin SSID.\n3. Enter the new password to reconnect to the network.\n\nPlease ensure that all your devices are updated with the new network credentials to maintain uninterrupted internet access.',
          button1Text: 'Cancel',
          button2Text: 'Continue',
          button1Color: AppColors.primary,
          button2Color: AppColors.red,
          button1Func: () {
            Get.back();
          },
          button2Func: () {
            //Only Wifi Password
            Get.back();
            setWifi(fillModifyWifi(index));
          });
    } else if (getWifiListModel.listOfWifi![index].id != '0') {
      String ssidName = '';

      if (index == 1) {
        ssidName = "${listOfWifiNameTEC[index].text}-Managed";
      } else if (index == 2) {
        ssidName = "${listOfWifiNameTEC[index].text}-Guest";
      } else if (index == 3) {
        ssidName = "${listOfWifiNameTEC[index].text}-Shared";
      }
      if (getWifiListModel.listOfWifi![index].name != ssidName) {
        wifiNameChanged = true;
      }

      if (wifiNameChanged ||
          (getWifiListModel.listOfWifi![index].password !=
              listOfWifiPasswordTEC[index].text)) {
        Dialogs.showAlertDialogueForSSID(
            context: Get.context!,
            msg:
                'Important: Network Disconnection Required\n\nYou are about to change your Wi-Fi network\'s SSID (name) and password. This action will disconnect  all devices currently connected to the network. After making these changes, please follow these steps:\n\n1. Go back to your device\'s Wi-Fi settings.\n2. Find and select the new Wi-Fi network with the updated SSID.\n3. Enter the new password to reconnect to the network.\n\nPlease ensure that all your devices are updated with the new network credentials to maintain uninterrupted internet access.',
            button1Text: 'Cancel',
            button2Text: 'Continue',
            button1Color: AppColors.primary,
            button2Color: AppColors.red,
            button1Func: () {
              Get.back();
            },
            button2Func: () {
              //Only Wifi Name
              Get.back();
              setWifi(fillModifyWifi(index));
              // .then(
              //     (value) => Get.offNamedUntil(Routes.SIGN_IN, (route) => false));
            });
      } else {
        setWifi(fillModifyWifi(index));
      }
    } else {
      setWifi(fillModifyWifi(index));
    }
  }

  Future<void> callGetWifiList() async {
    showLoader.value = true;
    await CommonRepo().getWifiList().then((value) {
      value.fold((l) => showLoader.value = false, (r) {
        getWifiListModel = r;
        asKeyStorage.saveAsKeyWifiListModel(getWifiListModel);

        listOfWirelessNetworkKey.clear();
        listOfWifiStatuses.clear();
        listOfWifiNameTEC.clear();
        listOfWifiPasswordTEC.clear();
        listOfBroadcastValue.clear();
        listOfShowWiFiPassword.clear();

        for (var wifi in getWifiListModel.listOfWifi!) {
          listOfWirelessNetworkKey.add(GlobalKey<FormState>());

          listOfWifiNameTEC.add(TextEditingController(
              text: (wifi.id == '1' || wifi.id == '2' || wifi.id == '3')
                  ? removeStrings(wifi.name!, listOfSuffixText)
                  : wifi.name!));

          listOfWifiPasswordTEC
              .add(TextEditingController(text: wifi.password!));
          listOfWifiStatuses.add(wifi.status!.obs);
          listOfBroadcastValue.add(wifi.broadcast!.obs);
          listOfShowWiFiPassword.add(false.obs);
        }

        showLoader.value = false;

        return right(getWifiListModel);
      });
    });
  }

  SetWifiParam fillModifyWifi(int index) {
    return SetWifiParam(
        action: 'modify',
        id: getWifiListModel.listOfWifi![index].id!,
        name: (index == 1 || index == 2 || index == 3)
            ? listOfWifiNameTEC[index].text + listOfSuffixText[index]
            : listOfWifiNameTEC[index].text,
        status: listOfWifiStatuses[index].value,
        password: listOfWifiPasswordTEC[index].text,
        broadcast: listOfBroadcastValue[index].value.toLowerCase());
  }

  SetWifiParam fillDeleteWifi(int index) {
    return SetWifiParam(
        action: 'delete',
        id: getWifiListModel.listOfWifi![index].id!,
        name: (index == 1 || index == 2 || index == 3)
            ? listOfWifiNameTEC[index].text + listOfSuffixText[index]
            : listOfWifiNameTEC[index].text,
        status: listOfWifiStatuses[index].value,
        password: listOfWifiPasswordTEC[index].text,
        broadcast: listOfBroadcastValue[index].value.toLowerCase());
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

      await callGetWifiList();

      if (setWifiParam.action == 'modify') {
        constants.showSnackbar(
            'Update Network', 'Successfully updated WiFi network', 1);
      } else {
        constants.showSnackbar(
            'Delete Network', 'WiFi network deleted successfully', 1);
      }

      showLoader.value = false;

      return status;
    });
  }
}
