import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../core/extensions/imports.dart';
import '../../../../core/utils/helpers/amz_storage.dart';
import '../../../data/models/sign_up_apis/forgot_password_model.dart';
import '../../../data/params/sign_up_apis/get_user_attribute_verification_code.dart';
import '../../../data/params/sign_up_apis/update_attribute_param.dart';
import '../../../data/params/sign_up_apis/user_sign_up_param.dart';
import '../../../data/params/sign_up_apis/verify_user_attribute_code_param.dart';
import '../../sign_up/views/account_created_view.dart';
import '../views/mobile_verify_view.dart';

class MobileNoVerifyController extends GetxController {
  RxBool showLoader = false.obs;
  RxBool isNetworkError = false.obs;
  RxBool isServerError = false.obs;

  final GlobalKey<FormState> mobileNoVerifyKey = GlobalKey<FormState>();
  final GlobalKey<FormState> mobileVerifyKey = GlobalKey<FormState>();

  TextEditingController mobileTextCtrl = TextEditingController();

  TextEditingController mobileOtpTextCtrl = TextEditingController();

  String completeMobileNo = '';

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
    //
    super.onClose();
  }

  submit() async {
    await updateAttributes(fillUpdateAttribute());
    getUserAttributeVerificationCode(fillGetUserAttributeVerificationCode());
  }

  resend() async {
    getUserAttributeVerificationCode(fillGetUserAttributeVerificationCode());
  }

  verifyCode() {
    verifyUserAttributeCode(fillVerifyUserAttributeCodeParam());
  }

  UpdateAttributeParam fillUpdateAttribute() {
    return UpdateAttributeParam(
      clientId: AppConstants.clientId,
      username: amzStorage.getAMZUserEmail().toLowerCase(),
      accessToken:
          amzStorage.getInitAuthModel().authenticationResult!.accessToken!,
      userAttributes: [
        UserAttribute(name: 'phone_number', value: completeMobileNo),
      ],
    );
  }

  FutureWithEitherSign<UpdateAttributeParam> updateAttributes(
      UpdateAttributeParam updateAttributeParams) async {
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
      amzStorage.saveAMZUserMobileNo(completeMobileNo);

      Get.to(() => const MobileVerifyView());

      return right(updateAttributeParams);
    });
  }

  GetUserAttributeVerificationCodeParam fillGetUserAttributeVerificationCode() {
    return GetUserAttributeVerificationCodeParam(
      attributeName: 'phone_number',
      accessToken:
          amzStorage.getInitAuthModel().authenticationResult!.accessToken!,
    );
  }

  FutureWithEitherSign<AttributeResponseModel> getUserAttributeVerificationCode(
      GetUserAttributeVerificationCodeParam
          getUserAttributeVerificationCodeParam) async {
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

    Map params = getUserAttributeVerificationCodeParam.toJson();

    String url = AppConstants.baseURLpcMatic;

    final response = await apiUtils.post(
      url: url,
      data: jsonEncode(params),
      options: Options(
        headers: {
          "Content-Type": 'application/x-amz-json-1.1',
          "X-Amz-Target": EndPoints.getUserAttributeVerificationCode,
        },
      ),
    );

    return response.fold((l) {
      showLoader.value = false;
      // if (l.type == 'UsernameExistsException') {
      //   Get.toNamed(Routes.VERIFY, arguments: {
      //     'Email': signUpParams.username,
      //     'Mobile': mobileTextCtrl.text,
      //     'Password': signUpParams.password,
      //   });
      // } else {
      Dialogs.showErrorDialog(errorCode: l.type!, errorMessage: l.message!);
      // }
      return left(l);
    }, (r) {
      AttributeResponseModel attributeResponseModel = AttributeResponseModel();
      attributeResponseModel = attributeResponseModelFromJson(r.data);
      showLoader.value = false;

      return right(attributeResponseModel);
    });
  }

  VerifyUserAttributeCodeParam fillVerifyUserAttributeCodeParam() {
    return VerifyUserAttributeCodeParam(
      attributeName: 'phone_number',
      code: mobileOtpTextCtrl.text,
      accessToken:
          amzStorage.getInitAuthModel().authenticationResult!.accessToken!,
    );
  }

  void verifyUserAttributeCode(
      VerifyUserAttributeCodeParam verifyUserAttributeCodeParam) async {
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

    Map params = verifyUserAttributeCodeParam.toJson();

    String url = AppConstants.baseURLpcMatic;

    final response = await apiUtils.post(
      url: url,
      data: jsonEncode(params),
      options: Options(
        headers: {
          "Content-Type": 'application/x-amz-json-1.1',
          "X-Amz-Target": EndPoints.verifyUserAttribute,
        },
      ),
    );

    return response.fold((l) {
      showLoader.value = false;

      Dialogs.showErrorDialog(errorCode: l.type!, errorMessage: l.message!);
    }, (r) {
      showLoader.value = false;

      constants.showSnackbar('Mobile Number Verification',
          'Your mobile number is successfully verified.', 1);
      // Get.offAllNamed(Routes.ONBOARDING);
      Get.offAll(() => const AccountCreatedView());
    });
  }
}
