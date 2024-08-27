import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:usama/app/modules/admin_login/controllers/admin_login_controller.dart';
import 'package:usama/core/utils/helpers/amz_storage.dart';

import '../../../../core/extensions/imports.dart';
import '../../../../core/theme/colors.dart';
import '../../../../core/utils/helpers/askey_storage.dart';
import '../../../data/models/admin_login/admin_login_model.dart';
import '../../../data/params/admin_login/admin_login_param.dart';
import '../../../routes/app_pages.dart';

class ForgotRouterPasswordController extends GetxController {
  final GlobalKey<FormState> forgotRouterPasswordKey = GlobalKey<FormState>();

  AdminLoginController adminLoginController = Get.find<AdminLoginController>();

  RxBool showLoader = false.obs;
  RxBool isNetworkError = false.obs;
  RxBool isServerError = false.obs;

  RxBool showWiFiPassword = false.obs;

  TextEditingController defaultPasswordTEC = TextEditingController();
  late Map<String, dynamic> arg;
  bool isInvalidDeviceToken = false;
  String password = '';
  RxString pageTitle = 'Forgot Router Password'.obs;
  @override
  void onInit() {
    arg = Get.arguments;

    isInvalidDeviceToken = arg['isDeviceTokenInvalid'];
    if (isInvalidDeviceToken) {
      password = arg['password'];
      pageTitle.value = 'Verify Router Password';
    }

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

  AdminLoginParam fillAdminLoginParam() {
    return AdminLoginParam(
      username: 'admin',
      password: password,
      deviceToken:
          isInvalidDeviceToken ? '' : asKeyStorage.getAsKeyDeviceToken(),
      rioPassword: defaultPasswordTEC.text,
      mailId: amzStorage.getAMZUserEmail(),
    );
  }

  FutureWithEither<AdminLoginModel> putAdminLogin(
      AdminLoginParam adminLoginParam) async {
    showLoader.value = true;
    isNetworkError.value = false;
    isServerError.value = false;

    final connectivityResult = await Connectivity().checkConnectivity();
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
        Dialogs.showDialogWithSingleButtonMsg(
          msg: 'No Internet Connection. Please connect to Rio router',
          button1Text: 'Router Connection Instructions',
          button1Color: AppColors.red,
          button1Func: () {
            Get.toNamed(Routes.ONBOARDING);
          },
        );
      } else {
        // Dialogs.showErrorDialog(
        //   titleText: l.errorMessage!,
        // );
      }

      return left(
          ErrorModel(errorCode: '100', errorMessage: 'No Internet Connection'));
    }, (r) async {
      AdminLoginModel adminLoginModel = AdminLoginModel.fromJson(r.data);
      ApiUtilsWithHeader.token = adminLoginModel.token!;

      asKeyStorage.saveAsKeyToken(adminLoginModel.token!);
      asKeyStorage.saveAsKeyAdminUserName(adminLoginParam.username);
      if (isInvalidDeviceToken) {
        asKeyStorage.saveAsKeyAdminPassword(adminLoginParam.password);
      }
      asKeyStorage.saveAsKeyDeviceToken(adminLoginModel.deviceToken!);

      if (adminLoginModel.move == 0) {
        //Move 0 means did not moved to admin room
        Get.toNamed(Routes.ROUTER_PASSWORD_CHANGE,
            arguments: {'isForgotPassword': true});
      } else {
        //Move 1 means device is moved to admin room

        await adminLoginController.authRepo
            .putAdminLogin(adminLoginController.fillAdminLoginParam());
      }

      showLoader.value = false;

      return right(adminLoginModel);
    });
  }
}
