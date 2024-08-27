import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:usama/app/data/params/sign_up_apis/user_sign_up_param.dart';
import 'package:usama/core/utils/helpers/amz_storage.dart';

import '../../../../core/extensions/imports.dart';
import '../../../../core/utils/helpers/askey_storage.dart';
import '../../../data/models/sign_up_apis/get_user_model.dart';
import '../../../data/models/sign_up_apis/init_auth_model.dart';
import '../../../data/params/sign_up_apis/get_user_param.dart';
import '../../../data/params/sign_up_apis/initiate_auth_param.dart';
import '../../../routes/app_pages.dart';

class SignInController extends GetxController {
  final GlobalKey<FormState> signInKey = GlobalKey<FormState>();

  RxBool showLoader = false.obs;
  RxBool isNetworkError = false.obs;
  RxBool isServerError = false.obs;

  RxBool showPassword = false.obs;
  RxBool isTermsAccepted = false.obs;

  //Allow Skip
  // RxBool allowSkip = false.obs;

  // final box = GetStorage('PC_Matic');

  TextEditingController emailTextCtrl = TextEditingController();
  TextEditingController passwordTextCtrl = TextEditingController();
  InitAuthModel initAuthModel = InitAuthModel();
  GetUserModel getUserModel = GetUserModel();

  bool isEmailVerified = false;
  bool isMobileNoVerified = false;

  // SignInModel signInModel = SignInModel();

  // RxDouble pageHeight =
  //     (Get.height - Get.statusBarHeight + (Get.mediaQuery.padding.top / 2)).obs;

  // List<bool> didErrorOccurred = [false, false];

  @override
  void onInit() {
    super.onInit();

    emailTextCtrl.text = amzStorage.getAMZUserEmail();

    // passwordTextCtrl.text = amzStorage.getAMZUserPassword();
  }

  // @override
  // void onReady() {
  //   super.onReady();
  // }

  @override
  void onClose() {
    // emailTextCtrl.dispose();
    // passwordTextCtrl.dispose();
    super.onClose();
  }

  InitiateAuthParam fillSignIn() {
    return InitiateAuthParam(
      authFlow: 'USER_PASSWORD_AUTH',
      authParameters: AuthParameters(
        username: emailTextCtrl.text.toLowerCase(),
        password: passwordTextCtrl.text,
        secretHash:
            AppConstants.getSecretHash(emailTextCtrl.text.toLowerCase()),
      ),
      clientId: AppConstants.clientId,
    );
  }

  FutureWithEitherSign<InitAuthModel> postSignIn(
      InitiateAuthParam signInParams) async {
    showLoader.value = true;
    isNetworkError.value = false;
    isServerError.value = false;

    // final connectivityResult = await (Connectivity().checkConnectivity());
    // if (connectivityResult == ConnectivityResult.none) {
    //   constants.showSnackbar('Network Error', 'No internet access', 0);
    //   showLoader.value = false;
    //   isServerError.value = false;
    //   isNetworkError.value = true;
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
      showLoader.value = false;
      if (l.type == 'UserNotConfirmedException') {
        Get.toNamed(Routes.VERIFY, arguments: {
          'Email': signInParams.authParameters.username,
          'ForgotPasswordPage': false
        });
      } else {
        Dialogs.showErrorDialog(
            errorCode: l.type ?? 'Network Error',
            errorMessage: l.message ??
                l.type ??
                'Something went wrong. Please Try Again!');
      }
      return left(l);
    }, (r) async {
      initAuthModel = initAuthModelFromJson(r.data);

      amzStorage.saveInitAuthModel(initAuthModel);

      amzStorage.saveAMZUserEmail(signInParams.authParameters.username);

      amzStorage.saveAMZUserPassword(signInParams.authParameters.password);

      amzStorage.saveAMZLoggedIn(true);

      asKeyStorage.saveAsKeyResetStatus(false);

      showLoader.value = false;

      await getUser(fillGetUserParam());

      if (isMobileNoVerified) {
        if (!amzStorage.getAMZFirstTimeUser()) {
          Get.toNamed(Routes.ADMIN_LOGIN);
        } else {
          Get.toNamed(Routes.ONBOARDING);
        }
      } else {
        Get.toNamed(Routes.MOBILE_NO_VERIFY);
      }

      return right(initAuthModel);

      // constants.showSnackbar('Welcome to Rio', 'Signed Up Successfully', 1);
    });
  }

  GetUserParam fillGetUserParam() {
    return GetUserParam(
        username: emailTextCtrl.text.toLowerCase(),
        accessToken: initAuthModel.authenticationResult!.accessToken!,
        clientId: AppConstants.clientId,
        userAttributes: [
          UserAttribute(name: 'phone_number', value: ''),
          UserAttribute(name: 'custom:DeviceToken', value: ''),
          UserAttribute(name: 'custom:RouterSerialNumber', value: ''),
        ]);
  }

  FutureWithEitherSign<GetUserModel> getUser(GetUserParam getUserParam) async {
    showLoader.value = true;
    isNetworkError.value = false;
    isServerError.value = false;

    // final connectivityResult = await (Connectivity().checkConnectivity());
    // if (connectivityResult == ConnectivityResult.none) {
    //   constants.showSnackbar('Network Error', 'No internet access', 0);
    //   showLoader.value = false;
    //   isServerError.value = false;
    //   isNetworkError.value = true;
    // }

    Map params = getUserParam.toJson();

    String url = AppConstants.baseURLpcMatic;

    final response = await apiUtils.post(
      url: url,
      data: jsonEncode(params),
      options: Options(
        headers: {
          "Content-Type": 'application/x-amz-json-1.1',
          "X-Amz-Target": EndPoints.getUserHeader,
        },
      ),
    );

    return response.fold((l) {
      showLoader.value = false;

      Dialogs.showErrorDialog(
          errorCode: l.type!,
          errorMessage:
              l.message ?? l.type ?? 'Something went wrong. Please Try Again!');

      return left(l);
    }, (r) {
      getUserModel = getUserModelFromJson(r.data);

      for (var attribute in getUserModel.userAttributes!) {
        if (attribute.name == 'phone_number_verified') {
          isMobileNoVerified = bool.parse(attribute.value);
        }
        if (attribute.name == 'custom:DeviceToken') {
          if (attribute.value.isNotEmpty) {
            asKeyStorage.saveAsKeyDeviceToken(attribute.value);
          }
        }
        if (attribute.name == 'custom:RouterSerialNumber') {
          if (attribute.value.isNotEmpty) {
            asKeyStorage.saveAsKeyRouterSerialNumber(attribute.value);
          }
        }
      }

      // getUserModel.userAttributes!.where((element) {
      //   if (element.name == 'phone_number_verified') {
      //     isMobileNoVerified = bool.parse(element.value);
      //     print(isMobileNoVerified);
      //   }
      //   if (element.name == 'email_verified') {
      //     isEmailVerified = bool.parse(element.value);
      //   }
      //   print(isMobileNoVerified);
      //   return true;
      // });

      showLoader.value = false;

      // Get.toNamed(Routes.ADMIN_LOGIN);

      return right(getUserModel);

      // constants.showSnackbar('Welcome to Rio', 'Signed Up Successfully', 1);
    });
  }
}
