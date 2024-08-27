import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:usama/core/utils/helpers/amz_storage.dart';

import '../../../../core/extensions/imports.dart';
import '../../../data/models/sign_up_apis/forgot_password_model.dart';
import '../../../data/params/sign_up_apis/confirm_forgot_password_param.dart';
import '../../../data/params/sign_up_apis/forgot_password_param.dart';
import '../views/password_changed_view.dart';

class ResetPasswordController extends GetxController {
  final GlobalKey<FormState> resetPasswordKey = GlobalKey<FormState>();

  RxBool showLoader = false.obs;
  RxBool isNetworkError = false.obs;
  RxBool isServerError = false.obs;

  RxBool showPassword = false.obs;
  RxBool showConfirmPassword = false.obs;

  final box = GetStorage();

  TextEditingController otpTextCtrl = TextEditingController();
  TextEditingController passwordTextCtrl = TextEditingController();
  TextEditingController confirmPasswordTextCtrl = TextEditingController();
  String email = '';

  AttributeResponseModel attributeResponseModel = AttributeResponseModel();

  @override
  void onInit() {
    //
    email = Get.arguments['Email'] ?? '';
    attributeResponseModel =
        Get.arguments['Response'] ?? AttributeResponseModel();
    super.onInit();
  }

  @override
  void onReady() {
    //
    super.onReady();
  }

  @override
  void onClose() {
    // otpTextCtrl.dispose();
    // confirmPasswordTextCtrl.dispose();
    // passwordTextCtrl.dispose();
    super.onClose();
  }

  ConfirmForgotPasswordParam fillForgotPasswordVerification() {
    return ConfirmForgotPasswordParam(
      username: email.toLowerCase(),
      secretHash: AppConstants.getSecretHash(email.toLowerCase()),
      clientId: AppConstants.clientId,
      confirmationCode: otpTextCtrl.text,
      password: passwordTextCtrl.text,
    );
  }

  void verifyForgotPassword(
      ConfirmForgotPasswordParam confirmForgotPasswordParam) async {
    showLoader.value = true;
    isNetworkError.value = false;
    isServerError.value = false;

    final connectivityResult = await (Connectivity().checkConnectivity());
    if (connectivityResult.contains(ConnectivityResult.none)) {
      constants.showSnackbar('Network Error', 'No internet access', 0);
      showLoader.value = false;
      isServerError.value = false;
      isNetworkError.value = true;
    }

    Map params = confirmForgotPasswordParam.toJson();

    String url = AppConstants.baseURLpcMatic;

    final response = await apiUtils.post(
      url: url,
      data: jsonEncode(params),
      options: Options(
        headers: {
          "Content-Type": 'application/x-amz-json-1.1',
          "X-Amz-Target": EndPoints.confirmForgotPasswordHeader,
        },
      ),
    );

    return response.fold((l) {
      showLoader.value = false;

      Dialogs.showErrorDialog(errorCode: l.type!, errorMessage: l.message!);
    }, (r) {
      // UserSignUpModel userSignUpModel = UserSignUpModel.fromJson(r.data);
      // box.write('UserPCMaticEmail', confirmSignUpParams.username);
      // box.write('UserPCMaticPassword', confirmSignUpParams.password);
      amzStorage.saveAMZUserEmail(confirmForgotPasswordParam.username);
      amzStorage.saveAMZUserPassword(confirmForgotPasswordParam.password);

      showLoader.value = false;

      Get.to(() => const PasswordChangedView());
      // Get.to(() => const AccountCreatedView());

      // if (userSignUpModel.userConfirmed!) {
      //   //If User is already Confirmed
      // } else {
      //   Get.toNamed(Routes.VERIFY, arguments: {
      //     'Email': confirmSignUpParams.username,
      //     'ForgotPasswordPage': false
      //   });
      // }

      // constants.showSnackbar('Welcome to Rio', 'Signed Up Successfully', 1);
    });
  }

  ForgotPasswordParam fillForgotPassword() {
    return ForgotPasswordParam(
      username: email.toLowerCase(),
      secretHash: AppConstants.getSecretHash(email.toLowerCase()),
      clientId: AppConstants.clientId,
    );
  }

  void forgotPassword(ForgotPasswordParam forgotPasswordParams) async {
    showLoader.value = true;
    isNetworkError.value = false;
    isServerError.value = false;

    final connectivityResult = await (Connectivity().checkConnectivity());
    if (connectivityResult.contains(ConnectivityResult.none)) {
      constants.showSnackbar('Network Error', 'No internet access', 0);
      showLoader.value = false;
      isServerError.value = false;
      isNetworkError.value = true;
    }

    Map params = forgotPasswordParams.toJson();

    String url = AppConstants.baseURLpcMatic;

    final response = await apiUtils.post(
      url: url,
      data: jsonEncode(params),
      options: Options(
        headers: {
          "Content-Type": 'application/x-amz-json-1.1',
          "X-Amz-Target": EndPoints.forgotPasswordHeader,
        },
      ),
    );

    return response.fold((l) {
      showLoader.value = false;

      Dialogs.showErrorDialog(errorCode: l.type!, errorMessage: l.message!);
    }, (r) {
      showLoader.value = false;

      constants.showSnackbar(
          'Code Sent to your Email', 'Please check your email for code', 1);
    });
  }
}
