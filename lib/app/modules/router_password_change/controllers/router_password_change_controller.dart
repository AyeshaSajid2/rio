import 'package:flutter/material.dart';
import 'package:flutter_background_service/flutter_background_service.dart';
import 'package:get/get.dart';
import 'package:usama/app/routes/app_pages.dart';
import 'package:usama/core/utils/services/api/repository/common_repository.dart';

import '../../../../core/extensions/imports.dart';
import '../../../../core/utils/helpers/amz_storage.dart';
import '../../../../core/utils/helpers/askey_storage.dart';
import '../../../data/models/admin_login/admin_login_model.dart';
import '../../../data/models/router_name/get_device_info_model.dart';
import '../../../data/models/status_model.dart';
import '../../../data/params/admin_login/admin_login_param.dart';
import '../../../data/params/admin_login/admin_password_param.dart';
import '../../../data/params/sign_up_apis/update_attribute_param.dart';
import '../../../data/params/sign_up_apis/user_sign_up_param.dart';

class RouterPasswordChangeController extends GetxController {
  final GlobalKey<FormState> changeRouterPasswordKey = GlobalKey<FormState>();

  CommonRepo apiRepo = CommonRepo();

  // TextEditingController oldRouterPasswordTEC = TextEditingController();
  TextEditingController newRouterPasswordTEC = TextEditingController();
  TextEditingController newRouterConfirmPasswordTEC = TextEditingController();

  RxBool isNetworkError = false.obs;
  RxBool isServerError = false.obs;
  RxBool showLoader = false.obs;

  RxBool showOldRouterPassword = false.obs;
  RxBool showNewRouterPassword = false.obs;
  RxBool showConfirmRouterPassword = false.obs;

  // GetAdminPasswordModel getAdminPasswordModel = GetAdminPasswordModel();
  AdminLoginModel adminLoginModel = AdminLoginModel();

  GetDeviceInfoModel getDeviceInfoModel = GetDeviceInfoModel();

  late Map arg;
  bool isFromForgotPassword = false;

  @override
  void onInit() {
    arg = Get.arguments;
    isFromForgotPassword = arg['isForgotPassword'];
    // if (!isFromForgotPassword) {
    //   getAdminPassword().then((value) {
    //     value.fold((l) => null, (r) {
    //       getAdminPasswordModel = r;
    //     });
    //   });
    // }

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

  // void submit() {
  //   changeAdminPassword(AdminPasswordParam(password: newRouterPasswordTEC.text))
  //       .then((value) => Get.toNamed(Routes.WIRELESS_NETWORK, arguments: true));
  // }

  changePassword() async {
    await changeAdminPassword(
            AdminPasswordParam(password: newRouterPasswordTEC.text))
        .then((value) async {
      if (value != null) {
        await putAdminLogin(AdminLoginParam(
            username: asKeyStorage.getAsKeyAdminUserName(),
            password: asKeyStorage.getAsKeyAdminPassword(),
            deviceToken: asKeyStorage.getAsKeyDeviceToken(),
            mailId: amzStorage.getAMZUserEmail(),
            rioPassword: ''));
      }
    });

    // Get.to(() => const RouterSetupInfoView());
  }

  Future<StatusModel?> changeAdminPassword(
      AdminPasswordParam adminPasswordParam) async {
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

    Map params = adminPasswordParam.toJson();

    String url = AppConstants.baseUrlAsKey + EndPoints.adminPasswordSetEndPoint;

    final response = await apiUtilsWithHeader.put(
        url: url, data: jsonEncode(params), firstTime: true);

    return response.fold((l) {
      showLoader.value = false;
      return null;
    }, (r) async {
      StatusModel status = StatusModel.fromJson(r.data);

      await asKeyStorage.saveAsKeyAdminPassword(adminPasswordParam.password);

      showLoader.value = false;

      // if (isFirstTimeChange) {
      // Get.back();
      // } else {
      //   Get.offAllNamed(Routes.ADMIN_LOGIN);
      // }

      constants.showSnackbar(
          'Admin Password', 'Successfully changed admin password', 1);

      return status;
    });
  }

  // FutureWithEither<GetAdminPasswordModel> getAdminPassword() async {
  //   showLoader.value = true;
  //   isNetworkError.value = false;
  //   isServerError.value = false;

  //   final connectivityResult = await (Connectivity().checkConnectivity());
  //   if (connectivityResult == ConnectivityResult.none) {
  //     constants.showSnackbar('Network Error', 'No internet access', 0);
  //     showLoader.value = false;
  //     isServerError.value = false;
  //     isNetworkError.value = true;

  //     return left(
  //         ErrorModel(errorCode: '100', errorMessage: 'No Internet Connection'));
  //   }

  //   // Map params = adminPasswordParam.toJson();

  //   String url = AppConstants.baseUrlAsKey + EndPoints.adminPasswordGetEndPoint;

  //   try {
  //     final response = await apiUtilsWithHeader.get(url: url);

  //     if (response.statusCode == 200) {
  //       getAdminPasswordModel = GetAdminPasswordModel.fromJson(response.data);

  //       oldRouterPasswordTEC.text = getAdminPasswordModel.adminPassword!;

  //       showLoader.value = false;

  //       return right(getAdminPasswordModel);
  //     } else {
  //       showLoader.value = false;

  //       Dialogs.showErrorDialog(
  //         titleText: response.statusMessage!,
  //       );
  //       return left(ErrorModel(
  //           errorCode: '100', errorMessage: 'No Internet Connection'));
  //     }
  //   } on SocketException {
  //     showLoader.value = false;
  //     isServerError.value = false;
  //     isNetworkError.value = true;
  //     return left(
  //         ErrorModel(errorCode: '100', errorMessage: 'No Internet Connection'));
  //   } on TimeoutException {
  //     showLoader.value = false;
  //     isServerError.value = false;
  //     isNetworkError.value = true;
  //     return left(
  //         ErrorModel(errorCode: '100', errorMessage: 'No Internet Connection'));
  //   } catch (e) {
  //     showLoader.value = false;
  //     isNetworkError.value = false;
  //     isServerError.value = true;

  //     if (e.runtimeType == DioException) {
  //       DioException exception = e as DioException;
  //       if (exception.response != null) {
  //         final error = ErrorModel.fromJson(exception.response!.data);

  //         Dialogs.showErrorDialog(
  //           titleText: error.errorMessage!,
  //         );
  //       } else {
  //         Dialogs.showErrorDialog(
  //           titleText: 'Something went wrong. Please Try Again',
  //         );
  //       }
  //     }
  //     return left(
  //         ErrorModel(errorCode: '100', errorMessage: 'No Internet Connection'));
  //   }
  // }

  FutureWithEither<AdminLoginModel> putAdminLogin(
      AdminLoginParam adminLoginParam) async {
    showLoader.value = true;
    isNetworkError.value = false;
    isServerError.value = false;

    final connectivityResult = await (Connectivity().checkConnectivity());
    // if (connectivityResult != ConnectivityResult.wifi) {
    if (connectivityResult.contains(ConnectivityResult.none)) {
      constants.showSnackbar('Not Connected to Rio WiFi Router',
          'Please connect to Rio WiFi router', 0);

      showLoader.value = false;
      isServerError.value = false;
      isNetworkError.value = true;

      return left(
          ErrorModel(errorCode: '100', errorMessage: 'No Internet Connection'));
    }

    Map params = adminLoginParam.toJson();

    String url = AppConstants.baseUrlAsKey + EndPoints.adminLoginEndPoint;

    final response = await apiUtils.put(url: url, data: jsonEncode(params));

    return response.fold((l) {
      showLoader.value = false;

      // 590 is Other than Dio Error
      // 598 is Connection Timeout
      // 599 is Connection Error

      if (l.status == '598') {
        // Dialogs.showDialogWithSingleButtonMsg(
        //   msg: 'Your network is slow. Connection Timed Out',
        //   button1Text: 'Try Again',
        //   button1Color: AppColors.red,
        //   button1Func: () {},
        // );
      } else if (l.status == '599') {
        // Dialogs.showDialogWithSingleButtonMsg(
        //   msg: 'No Internet Connection. Please connect to Rio router',
        //   button1Text: 'Router Connection Instructions',
        //   button1Color: AppColors.red,
        //   button1Func: () {
        //     Get.toNamed(Routes.ONBOARDING);
        //   },
        // );
      } else {
        // Dialogs.showErrorDialog(
        //   titleText: l.errorMessage!,
        // );
      }

      return left(
          ErrorModel(errorCode: '100', errorMessage: 'No Internet Connection'));
    }, (r) async {
      adminLoginModel = AdminLoginModel.fromJson(r.data);
      ApiUtilsWithHeader.token = adminLoginModel.token!;
      asKeyStorage.saveAdminLoginModel(adminLoginModel);

      asKeyStorage.saveAsKeyToken(adminLoginModel.token!);
      asKeyStorage.saveAsKeyAdminUserName(adminLoginParam.username);
      asKeyStorage.saveAsKeyAdminPassword(adminLoginParam.password);
      asKeyStorage.saveAsKeyDeviceToken(adminLoginModel.deviceToken!);

      asKeyStorage.saveAsKeyLoggedIn(true);

      asKeyStorage.saveAsKeyResetStatus(false);

      FlutterBackgroundService().invoke("setAsForeground", {
        'AdminUserName': adminLoginParam.username,
        'AdminPassword': adminLoginParam.password,
        'token': adminLoginModel.token,
      });

      //For sharing password in QR Code. WifiList required

      await apiRepo.getWifiList().then((value) {
        getDeviceInfo().then((value) {
          value.fold((l) => null, (r) async {
            await updateAttributes(fillUpdateAttribute(
                amzStorage.getAMZUserEmail().toLowerCase(),
                // signInController.emailTextCtrl.text.toLowerCase(),
                r.serialNumber!));
          });
        });
      });
      // .then((value) => getAdminPassword());

      await apiRepo.getRoomList(apiRepo.fillGetAllRooms());

      Get.toNamed(Routes.ROUTER_SETUP);

      showLoader.value = false;

      return right(adminLoginModel);
    });
  }

  FutureWithEither<GetDeviceInfoModel> getDeviceInfo() async {
    String url = AppConstants.baseUrlAsKey + EndPoints.deviceInfoEndPoint;

    final response = await apiUtilsWithHeader.get(url: url, firstTime: true);

    return response.fold((l) => left(l), (r) {
      getDeviceInfoModel = GetDeviceInfoModel.fromJson(r.data);
      // showLoader.value = false;
      return right(getDeviceInfoModel);
    });
  }

  UpdateAttributeParam fillUpdateAttribute(String email, String serialNumber) {
    return UpdateAttributeParam(
      clientId: AppConstants.clientId,
      username: email.toLowerCase(),
      accessToken:
          amzStorage.getInitAuthModel().authenticationResult!.accessToken!,
      // signInController.initAuthModel.authenticationResult!.accessToken!,
      userAttributes: [
        UserAttribute(name: 'custom:RouterSerialNumber', value: serialNumber),
      ],
    );
  }

  FutureWithEitherSign<UpdateAttributeParam> updateAttributes(
      UpdateAttributeParam updateAttributeParams) async {
    // showLoader.value = true;
    isNetworkError.value = false;
    isServerError.value = false;

    final connectivityResult = await (Connectivity().checkConnectivity());
    if (connectivityResult.contains(ConnectivityResult.none)) {
      constants.showSnackbar('Network Error', 'No internet access', 0);
      showLoader.value = false;
      isServerError.value = false;
      isNetworkError.value = true;
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
      showLoader.value = false;
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

      // constants.showSnackbar('Welcome to Rio', 'Signed Up Successfully', 1);
    });
  }
}
