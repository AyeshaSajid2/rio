import 'package:flutter_background_service/flutter_background_service.dart';
import 'package:get/get.dart';
import 'package:usama/core/utils/services/api/repository/common_repository.dart';

import '../../../../../app/data/models/admin_login/admin_login_model.dart';
import '../../../../../app/data/models/admin_login/get_admin_password_model.dart';
import '../../../../../app/data/models/admin_login/get_new_prefix_model.dart';
import '../../../../../app/data/models/router_name/get_device_info_model.dart';
import '../../../../../app/data/models/settings/get_system_setting_model.dart';
import '../../../../../app/data/models/sign_up_apis/init_auth_model.dart';
import '../../../../../app/data/models/wifi/get_wifi_list_model.dart';
import '../../../../../app/data/params/admin_login/admin_login_param.dart';
import '../../../../../app/data/params/admin_login/get_new_prefix_param.dart';
import '../../../../../app/data/params/sign_up_apis/initiate_auth_param.dart';
import '../../../../../app/data/params/sign_up_apis/update_attribute_param.dart';
import '../../../../../app/data/params/sign_up_apis/user_sign_up_param.dart';
import '../../../../../app/routes/app_pages.dart';
import '../../../../extensions/imports.dart';
import '../../../../theme/colors.dart';
import '../../../helpers/amz_storage.dart';
import '../../../helpers/askey_storage.dart';

class AuthRepo {
  InitiateAuthParam fillSignIn(String email, String password) {
    return InitiateAuthParam(
      authFlow: 'USER_PASSWORD_AUTH',
      authParameters: AuthParameters(
        username: email,
        password: password,
        secretHash: AppConstants.getSecretHash(email),
      ),
      clientId: AppConstants.clientId,
    );
  }

  FutureWithEitherSign<InitAuthModel> postSignIn(
      InitiateAuthParam signInParams) async {
    // final connectivityResult = await (Connectivity().checkConnectivity());
    // if (connectivityResult == ConnectivityResult.none) {
    //   constants.showSnackbar('Network Error', 'No internet access', 0);

    // }

    Map params = signInParams.toJson();

    String url = AppConstants.baseURLpcMatic;

    final response = await apiUtils.post(
      url: url,
      data: jsonEncode(params),
      options: Options(
        headers: {
          "Content-Type": 'application/x-amz-json-1.1',
          "X-Amz-Target": EndPoints.initiateAuthHeader,
        },
      ),
    );

    return response.fold((l) {
      // showLoader.value = false;
      if (l.type == 'UserNotConfirmedException') {
        Get.toNamed(Routes.VERIFY, arguments: {
          'Email': signInParams.authParameters.username,
          'Mobile': amzStorage.getAMZUserMobileNo(),
          'Password': signInParams.authParameters.password,
        });
        // Get.toNamed(Routes.VERIFY, arguments: {
        //   'Email': signInParams.authParameters.username,
        //   'ForgotPasswordPage': false
        // });
      } else {
        // Dialogs.showErrorDialog(
        //     titleText: l.message ??
        //         l.type ??
        //         'Something went wrong. Please Try Again!');
      }
      return left(l);
    }, (r) {
      InitAuthModel initAuthModel = initAuthModelFromJson(r.data);

      amzStorage.saveInitAuthModel(initAuthModel);

      amzStorage.saveAMZUserEmail(signInParams.authParameters.username);

      amzStorage.saveAMZUserPassword(signInParams.authParameters.password);

      amzStorage.saveAMZLoggedIn(true);

      asKeyStorage.saveAsKeyResetStatus(false);

      return right(initAuthModel);

      // constants.showSnackbar('Welcome to RIO', 'Signed Up Successfully', 1);
    });
  }

  // AdminLoginParam fillAdminLoginParam() {
  //   return AdminLoginParam(
  //     username: adminUserName,
  //     password: adminPassword,
  //     deviceToken: asKeyStorage.getAsKeyDeviceToken(),
  //     mailId: amzUserEmail,
  //     rioPassword: '',
  //   );
  // }

  Future<void> callProxyAPI(AdminLoginParam adminLoginParam) async {
    AppConstants.baseUrlAsKey = 'https://proxy1.riorouter.com';
    //Call Management API

    if (asKeyStorage.getAsKeyRouterSerialNumber() == '' ||
        asKeyStorage.getAsKeyDeviceToken() == '') {
      AppConstants.baseUrlAsKey = 'https://setup.riorouter.com:4422';
      Dialogs.showErrorDialog(
          errorCode: 'Connection Error',
          errorMessage:
              'Unable to connect to your Rio router. Please connect to Admin SSID and try again.');
      return;
    } else {
      await getNewPrefix(GetNewPrefixParam(
          action: 'QUERY',
          data: SerialNumber(
            sn: asKeyStorage.getAsKeyRouterSerialNumber(),
          ))).then((value) async {
        if (value.data!.result == 'Success') {
          AppConstants.baseUrlAsKey =
              'https://${value.data!.proxyIp! == "44.217.123.117" ? "proxy1.riorouter.com" : "proxy2.riorouter.com"}${value.data!.uriPrefix!}';
          //Call Admin Login Again
          await putAdminLogin(adminLoginParam).then((value) {
            value.fold((l) {
              Dialogs.showErrorDialog(
                errorCode: l.errorCode!,
                errorMessage: l.errorMessage!,
              );
            }, (r) => null);
          });
          return;
        } else {
          //Failure
          AppConstants.baseUrlAsKey = 'https://setup.riorouter.com:4422';
          // AppConstants.baseUrlAsKey = 'https://setup-dev.riorouter.com:4422';
          Dialogs.showErrorDialog(
              errorCode: 'Connection Error',
              errorMessage:
                  'Unable to connect to your Rio router remotely. Please try to connect to your router over Rio WiFi.');
          return;
        }
      });
      return;
    }
  }

  FutureWithEither<AdminLoginModel> putAdminLogin(
      AdminLoginParam adminLoginParam) async {
    // final connectivityResult = await Connectivity().checkConnectivity();
    // // if (connectivityResult != ConnectivityResult.wifi) {
    // if (connectivityResult == ConnectivityResult.none) {
    //   constants.showSnackbar('Not Connected to Rio Wifi Router',
    //       'Please connect to rio wifi router', 0);

    //   return left(
    //       ErrorModel(errorCode: '100', errorMessage: 'No Internet Connection'));
    // }

    Map params = adminLoginParam.toJson();

    String url = AppConstants.baseUrlAsKey + EndPoints.adminLoginEndPoint;

    final response = await apiUtils.put(url: url, data: jsonEncode(params));

    return response.fold((l) async {
      // 590 is Other than Dio Error
      // 598 is Connection Timeout
      // 599 is Connection Error

      if (l.status == '598') {
        // callProxyAPI(adminLoginParam);

        // Dialogs.showErrorDialog(
        //   errorCode: l.errorCode!,
        //   errorMessage: 'Your network is slow. Connection Timed Out',
        // );
      } else if (l.status == '599') {
        // Dialogs.showErrorDialog(
        //   errorCode: l.errorCode!,
        //   errorMessage: l.errorMessage!,
        // );
        // Dialogs.showDialogWithSingleButtonMsg(
        //   msg: 'No Internet Connection. Please connect to rio router',
        //   button1Text: 'Router Connection Instructions',
        //   button1Color: AppColors.red,
        //   button1Func: () {
        //     Get.toNamed(Routes.ONBOARDING);
        //   },
        // );
      } else if (l.errorCode == 'ERR_LOGIN_FAILED2') {
        //Invalid Device ID Token
        Get.toNamed(Routes.FORGOT_ROUTER_PASSWORD, arguments: {
          'isDeviceTokenInvalid': true,
          'password': adminLoginParam.password
        });
      } else {
        // Dialogs.showErrorDialog(
        //   titleText: l.errorMessage!,
        // );
      }

      return left(l);
    }, (r) async {
      AdminLoginModel adminLoginModel = AdminLoginModel.fromJson(r.data);
      asKeyStorage.saveAdminLoginModel(adminLoginModel);

      asKeyStorage.saveAsKeyToken(adminLoginModel.token!);

      asKeyStorage.saveAsKeyAdminPassword(adminLoginParam.password);

      asKeyStorage.saveAsKeyDeviceToken(adminLoginModel.deviceToken!);

      asKeyStorage.saveAsKeyResetStatus(false);

      asKeyStorage.saveAsKeyLoggedIn(true);

      amzStorage.saveAMZFirstTimeUser(false);

      FlutterBackgroundService().invoke("setAsForeground", {
        'AdminUserName': adminLoginParam.username,
        'AdminPassword': adminLoginParam.password,
        'token': adminLoginModel.token,
        'URL': AppConstants.baseUrlAsKey
      });

      ApiUtilsWithHeader.token = adminLoginModel.token!;

      await checkFirmwareVersion();

      return right(adminLoginModel);
    });
  }

  Future checkFirmwareVersion() async {
    await CommonRepo()
        .getSystemSettings()
        .then((value) => value.fold((l) => null, (r) async {
              GetSystemSettingModel systemSettingModel = r;

              await CommonRepo()
                  .getFirmwareVersion()
                  .then((value) => value.fold((l) => null, (r) async {
                        if (r.firmwareVersion ==
                            systemSettingModel.firmwareVersion) {
                          //Continue to dashboard
                          await continueLogin();
                        } else {
                          //Update Available

                          dynamic x =
                              await Dialogs.showDialogWithTwoTextButtonsMsg(
                            title: 'Firmware Update Available',
                            subtitle:
                                'Firmware Version: ${r.firmwareVersion} is available and your current Firmware Version is ${systemSettingModel.firmwareVersion}. \nPlease contact our customer support for firmware upgrade else you will see some functionalities may not work properly.',
                            button1Func: () async {
                              Get.back(result: true);
                            },
                            button2Func: () {
                              Get.back();
                              Get.toNamed(Routes.CUSTOMER_SUPPORT);
                            },
                            button1Text: 'Continue',
                            button2Text: 'Customer Support',
                            button1Color: AppColors.red,
                            button2Color: AppColors.appBlack,
                          );
                          if (x) {
                            await continueLogin();
                          }
                        }
                      }));
            }));

    return;
  }

  Future<bool> continueLogin() async {
    //For sharing password in QR Code. WifiList required

    // await CommonRepo().getWifiList().then((value) {
    //   value.fold((l) => null, (r) async {
    //     await getDeviceInfo().then((value) {
    //       value.fold((l) => null, (r) async {
    //         asKeyStorage.saveAsKeyRouterSerialNumber(r.serialNumber!);
    //         await updateAttributes(fillUpdateAttribute(
    //                 amzStorage.getAMZUserEmail(), r.serialNumber!))
    //             .then((value) {
    //           value.fold((l) => null, (r) async {
    //             await getAdminPassword().then((value) {
    //               value.fold((l) => null, (r) async {
    //                 await CommonRepo()
    //                     .getRoomList(CommonRepo().fillGetAllRooms())
    //                     .then((value) async {
    //                   if (value != null) {
    //                     await asKeyStorage.saveAsKeyRoomListModel(value);
    //                   }
    //                 });
    //               });
    //             });
    //           });
    //         });
    //       });
    //     });
    //   });
    // });

    Either<ErrorModel, GetWifiListModel> getWifiListResult =
        await CommonRepo().getWifiList();
    if (getWifiListResult.isRight()) {
      Either<ErrorModel, GetDeviceInfoModel> getDeviceInfoResult =
          await getDeviceInfo();

      if (getDeviceInfoResult.isRight()) {
        late GetDeviceInfoModel deviceInfoModel;
        getDeviceInfoResult.fold((l) => null, (r) => deviceInfoModel = r);
        asKeyStorage.saveAsKeyRouterSerialNumber(deviceInfoModel.serialNumber!);
        await updateAttributes(fillUpdateAttribute(amzStorage.getAMZUserEmail(),
            deviceInfoModel.serialNumber!, asKeyStorage.getAsKeyDeviceToken()));
      }

      await getAdminPassword();

      await CommonRepo()
          .getRoomList(CommonRepo().fillGetAllRooms())
          .then((value) async {
        if (value != null) {
          await asKeyStorage.saveAsKeyRoomListModel(value);
        }
      });
    }

    constants.showSnackbar('Welcome to RIO', 'Signed in successfully', 1);

    if (asKeyStorage.getAsKeyGetAdminPasswordModel().changed == 'true') {
      Get.offAllNamed(Routes.HOME);
    } else {
      Get.toNamed(Routes.ROUTER_PASSWORD_CHANGE,
          arguments: {'isForgotPassword': false});
    }

    return true;
  }

  FutureWithEither<GetDeviceInfoModel> getDeviceInfo() async {
    String url = AppConstants.baseUrlAsKey + EndPoints.deviceInfoEndPoint;

    final response = await apiUtilsWithHeader.get(url: url, firstTime: true);

    return response.fold((l) => left(l), (r) {
      GetDeviceInfoModel getDeviceInfoModel =
          GetDeviceInfoModel.fromJson(r.data);

      asKeyStorage.saveAsKeyGetDeviceInfoModel(getDeviceInfoModel);

      return right(getDeviceInfoModel);
    });
  }

  UpdateAttributeParam fillUpdateAttribute(
    String email,
    String serialNumber,
    String deviceToken,
  ) {
    return UpdateAttributeParam(
      clientId: AppConstants.clientId,
      username: email.toLowerCase(),
      accessToken:
          amzStorage.getInitAuthModel().authenticationResult!.accessToken!,
      userAttributes: [
        UserAttribute(name: 'custom:RouterSerialNumber', value: serialNumber),
        UserAttribute(name: 'custom:DeviceToken', value: deviceToken),
      ],
    );
  }

  UpdateAttributeParam fillUpdateDeviceTokenInAWS(
    String deviceToken,
  ) {
    return UpdateAttributeParam(
      clientId: AppConstants.clientId,
      username: amzStorage.getAMZUserEmail().toLowerCase(),
      accessToken:
          amzStorage.getInitAuthModel().authenticationResult!.accessToken!,
      userAttributes: [
        UserAttribute(name: 'custom:DeviceToken', value: deviceToken),
      ],
    );
  }

  FutureWithEitherSign<UpdateAttributeParam> updateAttributes(
      UpdateAttributeParam updateAttributeParams) async {
    // showLoader.value = true;

    final connectivityResult = await (Connectivity().checkConnectivity());
    if (connectivityResult.contains(ConnectivityResult.none)) {
      constants.showSnackbar('Network Error', 'No internet access', 0);
    }

    Map params = updateAttributeParams.toJson();

    String url = AppConstants.baseURLpcMatic;

    final response = await apiUtils.post(
      url: url,
      data: jsonEncode(params),
      options: Options(
        headers: {
          "Content-Type": 'application/x-amz-json-1.1',
          "X-Amz-Target": EndPoints.updateUserAttributesHeader,
        },
      ),
    );

    return response.fold((l) {
      // if (l.type == 'UserNotConfirmedException') {
      //   Get.toNamed(Routes.VERIFY, arguments: {
      //     'Email': signInParams.authParameters.username,
      //     'ForgotPasswordPage': false
      //   });
      // } else {
      // Dialogs.showErrorDialog(
      //     titleText: l.message ??
      //         l.type ??
      //         'Something went wrong. Please Try Again!');
      // }
      return left(l);
    }, (r) {
      // UpdateAttributeParam updateAttributeModel = updateAttributeParamFromJson(r.data);

      // pcMaticBox.write('updateAttributeModel', updateAttributeModel.toString());

      // pcMaticBox.write(
      //     'UserPCMaticEmail', signInParams.authParameters.username);
      // pcMaticBox.write(
      //     'UserPCMaticPassword', signInParams.authParameters.password);

      // showLoader.value = false;

      return right(updateAttributeParams);

      // constants.showSnackbar('Welcome to RIO', 'Signed Up Successfully', 1);
    });
  }

  FutureWithEither<GetAdminPasswordModel> getAdminPassword() async {
    String url = AppConstants.baseUrlAsKey + EndPoints.adminPasswordGetEndPoint;

    final response = await apiUtilsWithHeader.get(url: url, firstTime: true);

    return response.fold((l) => left(l), (r) {
      GetAdminPasswordModel getAdminPasswordModel =
          GetAdminPasswordModel.fromJson(r.data);

      asKeyStorage.saveAsKeyGetAdminPasswordModel(getAdminPasswordModel);

      return right(getAdminPasswordModel);
    });
  }

  Future<GetNewPrefixModel> getNewPrefix(
      GetNewPrefixParam newPrefixParam) async {
    final connectivityResult = await (Connectivity().checkConnectivity());
    if (connectivityResult.contains(ConnectivityResult.none)) {
      constants.showSnackbar('Network Error', 'No internet access', 0);
    }

    String url = AppConstants.baseUrlAsKey + EndPoints.managementEndPoint;

    Map params = newPrefixParam.toJson();

    final response = await apiUtils.postWithProgress(
      url: url,
      data: jsonEncode(params),
    );

    GetNewPrefixModel getNewPrefixModel =
        GetNewPrefixModel.fromJson(response.data);

    return getNewPrefixModel;
  }
}
