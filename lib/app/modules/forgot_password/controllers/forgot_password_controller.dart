import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:usama/core/extensions/imports.dart';

import '../../../data/models/sign_up_apis/forgot_password_model.dart';
import '../../../data/params/sign_up_apis/forgot_password_param.dart';
import '../../../routes/app_pages.dart';

class ForgotPasswordController extends GetxController {
  final GlobalKey<FormState> forgotPasswordKey = GlobalKey<FormState>();

  RxBool showLoader = false.obs;
  RxBool isNetworkError = false.obs;
  RxBool isServerError = false.obs;

  TextEditingController emailTextCtrl = TextEditingController();

  @override
  void onInit() {
    //
    super.onInit();
  }

  @override
  void onReady() {
    //
    super.onReady();
  }

  @override
  void onClose() {
    emailTextCtrl.dispose();
    super.onClose();
  }

  ForgotPasswordParam fillForgotPassword() {
    return ForgotPasswordParam(
      username: emailTextCtrl.text.toLowerCase(),
      secretHash: AppConstants.getSecretHash(emailTextCtrl.text.toLowerCase()),
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
      AttributeResponseModel attributeResponseModel =
          attributeResponseModelFromJson(r.data);
      showLoader.value = false;
      Get.toNamed(Routes.RESET_PASSWORD, arguments: {
        'Email': emailTextCtrl.text.toLowerCase(),
        'Response': attributeResponseModel
      });

      // constants.showSnackbar('Welcome to Rio', 'Signed Up Successfully', 1);
    });
  }
}
