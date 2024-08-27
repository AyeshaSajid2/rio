import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:network_info_plus/network_info_plus.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:usama/app/routes/app_pages.dart';
import 'package:usama/core/utils/helpers/amz_storage.dart';
import 'package:usama/core/utils/helpers/askey_storage.dart';
import 'package:usama/core/utils/services/api/repository/auth_repository.dart';
import 'package:wifi_iot/wifi_iot.dart';
import '../../../../core/extensions/imports.dart';
import '../../../../core/theme/colors.dart';
import '../../../data/params/admin_login/admin_login_param.dart';

class SplashController extends GetxController {
  AuthRepo authRepo = AuthRepo();
  ScrollController welcomeScrollController = ScrollController();
  ScrollController welcomeInfoScrollController = ScrollController();

  List<Map<String, String>> listOfWelcomeInfo = [
    {
      'Multiple SSIDs':
          'Allows the creation of up to 4 different multipurpose networks.'
    },
    {'SecureRooms': 'You can set up to 16 SecureRooms.'},
    {
      'Password Protection':
          'Rio provides 2 levels of password protection: at the SSID level and within each SecureRoom.'
    },
    {'Room Security': 'Each SecureRoom is protected (VLAN) from each other.'},
    {
      'Device Admission':
          'All devices that wish to connect to your Rio router must be admitted.'
    },
    {
      'Device Allowlisting Protection':
          'The router features Zero Trust allowlisting protection.'
    },
    {
      'VPN Coverage':
          'Rio’s built-in VPN encrypts and secures all connected devices, including IoT.'
    },
    {
      'VPN Server Locations':
          'You can set up 2 different VPN server locations for each SecureRoom.'
    },
    {
      'Parental Control':
          'Rio delivers advanced parental controls with allowlisting protection.'
    },
    {
      'Guest Connection Protection':
          'Rio stops guests from connecting to your network without your permission.'
    },
    {
      'WiFi 6 Mesh Technology':
          'Rio is equipped with WiFi 6 Mesh High-Speed Technology.'
    },
  ];

  String amzUserEmail = '';
  String amzUserPassword = '';

  String adminUserName = '';
  String adminPassword = '';

  RxBool showLoader = false.obs;
  RxBool isNetworkError = false.obs;
  RxBool isServerError = false.obs;

  bool loggedIn = false;
  bool resetStatus = true;

  bool showBackButton = false;

  final connectivity = Connectivity();
  List<ConnectivityResult> connectivityResult = [ConnectivityResult.none];
  late StreamSubscription connectivityStreamSubscription;

  RxString? wifiName = ''.obs;
  RxString statusText = 'No internet connection'.obs;
  RxBool isWifiConnected = false.obs;

  // final pcMaticBox = GetStorage('PC_Matic');
  // final asKeyBox = GetStorage('AsKey');
  @override
  void onInit() {
    //

    amzUserEmail = amzStorage.getAMZUserEmail();
    amzUserPassword = amzStorage.getAMZUserPassword();

    adminUserName = asKeyStorage.getAsKeyAdminUserName();

    adminPassword = asKeyStorage.getAsKeyAdminPassword();

    loggedIn = (asKeyStorage.getAsKeyLoggedIn() && amzStorage.getAMZLoggedIn());
    // if (loggedIn) {
    //   checkStates();
    // } else {
    //   Future.delayed(const Duration(microseconds: 1), () {
    //     checkStates();
    //   });
    // }

    super.onInit();
  }

  @override
  void onReady() async {
    if (Platform.isIOS || Platform.isAndroid) {
      bool? response =
          await Permission.locationWhenInUse.isGranted.then((value) async {
        if (!value) {
          return Dialogs.showDialogWithTwoTextButtonsMsg(
            title: "Location Permission Required",
            subtitle:
                "Please note, without location access, your Rio App will be unable to confirm if you are connected to the Rio WiFi network.",
            button1Text: 'Cancel',
            button1Func: () => Navigator.pop(Get.context!),
            button1Color: AppColors.red,
            button2Text: 'Open Settings',
            button2Func: () {
              Navigator.pop(Get.context!);
              openAppSettings();
            },
            button2Color: AppColors.black,
          );
        }
        return null;
      });
    }
    //
    await checkWifi();
    resetStatus = asKeyStorage.getAsKeyResetStatus();
    loggedIn = (asKeyStorage.getAsKeyLoggedIn() && amzStorage.getAMZLoggedIn());

    checkStates();

    super.onReady();
  }

  @override
  void onClose() {
    //
    welcomeScrollController.dispose();
    welcomeInfoScrollController.dispose();

    connectivityStreamSubscription.cancel();

    super.onClose();
  }

  Future checkStates() async {
    // print(amzUserEmail);
    // print(amzUserPassword);
    // print(adminUserName);
    // print(adminPassword);
    // print(resetStatus);
    // print(loggedIn);
    if (!resetStatus) {
      if (amzUserEmail.isEmpty &&
          amzUserPassword.isEmpty &&
          adminUserName.isEmpty &&
          adminPassword.isEmpty) {
        //New User
        // print('New User');
      } else if (amzUserEmail.isNotEmpty &&
          amzUserPassword.isNotEmpty &&
          adminPassword.isEmpty &&
          !loggedIn) {
        //AWS Login True but Admin Login False
        // print('AWS Login True but Admin Login False');
        showLoader.value = false;
        Get.toNamed(Routes.ADMIN_LOGIN);
      } else if (amzUserEmail.isNotEmpty &&
          amzUserPassword.isNotEmpty &&
          adminUserName.isNotEmpty &&
          adminPassword.isNotEmpty &&
          loggedIn) {
        // print('Logged In');

        // callAdminLogin();
        checkWifiNameAndCallAdminLogin();

        // postSignIn(fillSignIn(amzUserEmail, amzUserPassword)).then((value) {
        //   value.fold(
        //       (l) => null, (r) => {putAdminLogin(fillAdminLoginParam())});
        // });
      } else {
        //amzUserEmail.isNotEmpty ||
        // amzUserPassword.isNotEmpty
        //logged Out scenario
        // print('Logged Out');
        await Get.toNamed(Routes.SIGN_IN);
      }
    } else {
      //Starting App From Welcome Screen
    }
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
    if (isWifiConnected.value) {
      // print('WifiConnected');
      if (wifiName != null &&
          wifiName!.value != 'null' &&
          wifiName!.value != '<unknownssid>') {
        if (wifiName!.value.isNotEmpty &&
            wifiName!.value.toLowerCase().trim().startsWith('rio')) {
          // print('RIO');
          AppConstants.baseUrlAsKey = 'https://setup.riorouter.com:4422';
          showLoader.value = true;
          await authRepo
              .putAdminLogin(fillAdminLoginParam())
              .then((value) => value.fold((l) {
                    showLoader.value = false;
                    if (l.status == '598' ||
                        (l.status == '600' &&
                            l.errorCode == "DioExceptionType.receiveTimeout") ||
                        l.status == '599') {
                      constants.showSnackbar(
                          'Router Network Error',
                          'Device is not getting any response from Rio router. Please try again or contact our customer service.',
                          0);

                      Get.toNamed(Routes.ADMIN_LOGIN);
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

  AdminLoginParam fillAdminLoginParam() {
    return AdminLoginParam(
      username: adminUserName,
      password:
          // '5ae3a5a4',
          adminPassword,
      deviceToken: asKeyStorage.getAsKeyDeviceToken(),
      mailId: amzUserEmail,
      rioPassword: '',
    );
  }

  callAdminLogin() async {
    showLoader.value = true;

    await authRepo
        .postSignIn(authRepo.fillSignIn(amzUserEmail, amzUserPassword))
        .then((value) {
      value.fold((l) {
        showLoader.value = false;
        Get.toNamed(Routes.SIGN_IN);
      }, (r) async {
        await authRepo.putAdminLogin(fillAdminLoginParam()).then((value) {
          value.fold((l) async {
            // 590 is Other than Dio Error
            // 598 is Connection Timeout
            // 599 is Connection Error
            if (l.status == '598' ||
                (l.status == '600' &&
                    l.errorCode == "DioExceptionType.receiveTimeout")) {
              constants.showSnackbar(
                  'WAN Access',
                  'Rio Router connection timeout. Trying to connect to WiFi Router over WAN.',
                  2);
              showLoader.value = true;
              await authRepo.callProxyAPI(fillAdminLoginParam());
              showLoader.value = false;
            } else if (l.status == '599') {
              constants.showSnackbar(
                  'WAN Access',
                  'Rio Router connection error. Trying to connect to WiFi Router over WAN.',
                  2);
              showLoader.value = true;
              await authRepo.callProxyAPI(fillAdminLoginParam());
              showLoader.value = false;
            } else {
              Get.toNamed(Routes.ADMIN_LOGIN);

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
      });
    });
  }
}
