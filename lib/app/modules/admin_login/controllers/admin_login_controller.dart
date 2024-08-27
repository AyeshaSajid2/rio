import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:network_info_plus/network_info_plus.dart';
import 'package:usama/core/utils/helpers/amz_storage.dart';
import 'package:usama/core/utils/helpers/askey_storage.dart';
import 'package:wifi_iot/wifi_iot.dart';

import '../../../../core/extensions/imports.dart';
import '../../../../core/utils/services/api/repository/auth_repository.dart';
import '../../../../core/utils/services/api/repository/common_repository.dart';
import '../../../data/params/admin_login/admin_login_param.dart';

class AdminLoginController extends GetxController {
  AuthRepo authRepo = AuthRepo();
  CommonRepo commonRepo = CommonRepo();
  final GlobalKey<FormState> singInKey = GlobalKey<FormState>();

  RxBool showLoader = false.obs;
  RxBool isNetworkError = false.obs;
  RxBool isServerError = false.obs;

  RxBool showWiFiPassword = false.obs;
  RxBool rememberMe = true.obs;

  TextEditingController userNameTEC = TextEditingController(text: 'admin');
  TextEditingController userPasswordTEC = TextEditingController();

  bool showBackButton = false;

  final connectivity = Connectivity();
  List<ConnectivityResult> connectivityResult = [ConnectivityResult.none];
  late StreamSubscription<List<ConnectivityResult>>
      connectivityStreamSubscription;

  RxString? wifiName = ''.obs;
  RxString statusText = 'No internet connection'.obs;
  RxBool isWifiConnected = false.obs;

  @override
  void onInit() {
    //

    showBackButton = Get.arguments ?? true;

    rememberMe.value = asKeyStorage.getAsKeyAdminRememberMe();
    if (rememberMe.value) {
      // userNameTEC.text = asKeyStorage.getAsKeyAdminUserName();
      userPasswordTEC.text = asKeyStorage.getAsKeyAdminPassword();
    }

    super.onInit();
  }

  @override
  void onReady() async {
    if (!amzStorage.getAMZFirstTimeUser()) {
      // callAdminLogin();
      await checkWifi();

      checkWifiNameAndCallAdminLogin();
    } else {
      asKeyStorage.saveAsKeyAdminRememberMe(true);
      await checkWifi();
    }
    super.onReady();
  }

  @override
  void onClose() {
    //After Removing Forgot Password make it uncomment
    // userNameTEC.dispose();
    // userPasswordTEC.dispose();
    connectivityStreamSubscription.cancel();
    super.onClose();
  }

  Future<List<ConnectivityResult>> checkWifi() async {
    connectivityResult = await connectivity.checkConnectivity();

    await Future.delayed(const Duration(milliseconds: 500), () async {
      connectivityResult = await connectivity.checkConnectivity();
    });

    connectivityStreamSubscription = connectivity.onConnectivityChanged
        .listen((List<ConnectivityResult> result) async {
      connectivityResult = result;
      await changeWifiStatus();
    });

    await changeWifiStatus();

    return connectivityResult;
  }

  Future<bool> changeWifiStatus() async {
    if (connectivityResult.contains(ConnectivityResult.wifi)) {
      isWifiConnected.value = true;
      statusText.value = 'Connected to WiFi';

      String? ssid = "";

      ssid = await WiFiForIoTPlugin.getSSID();

      wifiName!.value = ssid.toString().removeAllWhitespace;

      if (wifiName!.value == 'null' || wifiName!.value == '<unknownssid>') {
        final info = NetworkInfo();

        String? name = await info.getWifiName(); // "FooNetwork"
        if (name != null) {
          String a = name.replaceAll("\"", "");
          wifiName!.value = a.removeAllWhitespace;
        } else {
          wifiName!.value = 'null';
        }
      }
    } else if (connectivityResult.contains(ConnectivityResult.mobile)) {
      statusText.value = 'Connected to Mobile network';
      isWifiConnected.value = false;
    } else if (connectivityResult.contains(ConnectivityResult.none)) {
      isWifiConnected.value = false;
      statusText.value = 'No internet connection';
      // print("No network connection");
      // constants.showSnackbar('Network Error', 'No Internet Access', 0);
    }

    return isWifiConnected.value;
  }

  checkWifiNameAndCallAdminLogin() async {
    // wifiName!.value = 'RIO-037D9';
    if (AppConstants.baseUrlAsKey == 'https://setup-dev.riorouter.com:4422') {
      callAdminLogin();
    } else {
      if (isWifiConnected.value) {
        if (wifiName != null &&
            wifiName!.value != 'null' &&
            wifiName!.value != '<unknownssid>') {
          if (wifiName!.value.isNotEmpty &&
              wifiName!.value.toLowerCase().trim().startsWith('rio')) {
            AppConstants.baseUrlAsKey = 'https://setup.riorouter.com:4422';
            // print('RIO');
            showLoader.value = true;
            await authRepo
                .putAdminLogin(fillAdminLoginParam())
                .then((value) => value.fold((l) {
                      showLoader.value = false;
                      if (l.status == '598' ||
                          (l.status == '600' &&
                              l.errorCode ==
                                  "DioExceptionType.receiveTimeout") ||
                          l.status == '599') {
                        constants.showSnackbar(
                            'Router Network Error',
                            'Device is not getting any response from Rio router. Please try again or contact our customer service.',
                            0);
                      }
                    }, (r) => showLoader.value = false));
          } else {
            // print('WIFI Other');

            constants.showSnackbar(
                'Connecting to Rio over WAN',
                'Your phone is not connected to Rio WiFi. Trying to connect to Rio over WAN.',
                2);
            showLoader.value = true;
            await authRepo.callProxyAPI(fillAdminLoginParam());
            showLoader.value = false;
          }
        } else {
          //May be check Wifi does not read wifi name

          // print('WIFI Name Not coming');
          AppConstants.baseUrlAsKey = 'https://setup.riorouter.com:4422';
          callAdminLogin();
        }
      } else {
        // print('Not a WIFI Connection');

        constants.showSnackbar(
            'Connecting to Rio over WAN',
            'Your phone is not connected to Rio WiFi. Trying to connect to Rio over WAN.',
            2);
        showLoader.value = true;
        await authRepo.callProxyAPI(fillAdminLoginParam());
        showLoader.value = false;
      }
    }
  }

  callAdminLogin() async {
    showLoader.value = true;

    await authRepo.putAdminLogin(fillAdminLoginParam()).then((value) {
      value.fold((l) async {
        // 590 is Other than Dio Error
        // 598 is Connection Timeout
        // 599 is Connection Error
        if (l.status == '598' ||
            (l.status == '600' &&
                l.errorCode == "DioExceptionType.receiveTimeout")) {
          constants.showSnackbar(
              'Connecting to Rio over WAN',
              'Your phone is not connected to Rio WiFi. Trying to connect to Rio over WAN.',
              2);
          showLoader.value = true;
          await authRepo.callProxyAPI(fillAdminLoginParam());
          showLoader.value = false;
        } else if (l.status == '599') {
          constants.showSnackbar(
              'Connecting to Rio over WAN',
              'Your phone is not connected to Rio WiFi. Trying to connect to Rio over WAN.',
              2);
          showLoader.value = true;
          await authRepo.callProxyAPI(fillAdminLoginParam());
          showLoader.value = false;
        } else {
          if (l.status == '590' || l.status == '600') {
            Dialogs.showErrorDialog(
                errorCode: l.errorCode!,
                errorMessage:
                    'Unable to connect to the router. Please try again.');
          }
        }
        showLoader.value = false;
      }, (r) => showLoader.value = false);
    });
  }

  AdminLoginParam fillAdminLoginParam() {
    return AdminLoginParam(
      username: userNameTEC.text,
      password:
          //
          // '!Klatu77',
          userPasswordTEC.text,
      deviceToken:
          //
          // '5UR3pvRK+HpmECfwbSy/WTwlZzVkeSzQ',
          // asKeyStorage.getAsKeyDeviceToken().isEmpty
          //     ? amzStorage.getAMZDeviceToken()
          //     :
          asKeyStorage.getAsKeyDeviceToken(),
      mailId:
          //
          // 'ramana@maithrinet.com',
          amzStorage.getAMZUserEmail(),
      rioPassword: '',
    );
  }
}
