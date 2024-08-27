import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:usama/core/utils/helpers/amz_storage.dart';

import '../../../../core/extensions/imports.dart';
import '../../../data/models/sign_up_apis/init_auth_model.dart';
import '../../../data/params/sign_up_apis/confirm_user_sign_up_param.dart';
import '../../../data/params/sign_up_apis/initiate_auth_param.dart';
import '../../../data/params/sign_up_apis/user_sign_up_param.dart';
import '../../../routes/app_pages.dart';

class VerifyController extends GetxController {
  final GlobalKey<FormState> verifyKey = GlobalKey<FormState>();
  final GlobalKey<FormState> mobileVerifyKey = GlobalKey<FormState>();

  // SignUpController signUpController = Get.find<SignUpController>();

  InitAuthModel initAuthModel = InitAuthModel();

  RxBool showLoader = false.obs;
  RxBool isNetworkError = false.obs;
  RxBool isServerError = false.obs;

  // bool isForgotPasswordVerify = false;
  String userEmail = 'abc@xyz.com';
  // String userMobile = '+1XXXXXXXX';
  String userPassword = '';

  Map<String, dynamic> args = {};

  TextEditingController emailOtpTextCtrl = TextEditingController();
  TextEditingController mobileOtpTextCtrl = TextEditingController();
  @override
  void onInit() {
    args = Get.arguments;
    userEmail = args['Email'];
    // userMobile = args['Mobile'] ?? '';
    userPassword = args['Password'] ?? '';
    // isForgotPasswordVerify = args['ForgotPasswordPage'];
    super.onInit();
  }

  @override
  void onReady() {
    //
    super.onReady();
  }

  @override
  void onClose() {
    emailOtpTextCtrl.dispose();
    mobileOtpTextCtrl.dispose();
    super.onClose();
  }

  ConfirmUserSignUpParam fillEmailVerificationSignUp() {
    return ConfirmUserSignUpParam(
      username: userEmail.toLowerCase(),
      secretHash: AppConstants.getSecretHash(userEmail.toLowerCase()),
      clientId: AppConstants.clientId,
      confirmationCode: emailOtpTextCtrl.text,
    );
  }

  void verifySignUP(ConfirmUserSignUpParam confirmSignUpParams) async {
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

    Map params = confirmSignUpParams.toJson();

    String url = AppConstants.baseURLpcMatic;

    final response = await apiUtils.post(
      url: url,
      data: jsonEncode(params),
      options: Options(
        headers: {
          "Content-Type": 'application/x-amz-json-1.1',
          "X-Amz-Target": EndPoints.confirmSignUpHeader,
        },
      ),
    );

    return response.fold((l) {
      showLoader.value = false;

      Dialogs.showErrorDialog(errorCode: l.type!, errorMessage: l.message!);
    }, (r) async {
      // UserSignUpModel userSignUpModel = UserSignUpModel.fromJson(r.data);
      // box.write('UserPCMaticEmail', confirmSignUpParams.username);
      // box.write('UserPCMaticPassword', confirmSignUpParams.password);

      await postSignIn(fillSignIn(
              confirmSignUpParams.username, amzStorage.getAMZUserPassword()))
          .then((value) {
        value.fold((l) => amzStorage.saveAMZLoggedIn(false),
            (r) => amzStorage.saveAMZLoggedIn(true));
      });

      showLoader.value = false;

      // Get.to(() => const MobileVerifyView());
      Get.toNamed(Routes.MOBILE_NO_VERIFY);
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
      initAuthModel = initAuthModelFromJson(r.data);

      amzStorage.saveInitAuthModel(initAuthModel);

      amzStorage.saveAMZUserEmail(signInParams.authParameters.username);

      amzStorage.saveAMZUserPassword(signInParams.authParameters.password);

      showLoader.value = false;

      return right(initAuthModel);

      // constants.showSnackbar('Welcome to Rio', 'Signed Up Successfully', 1);
    });
  }

  UserSignUpParam fillSignUp() {
    return UserSignUpParam(
        username: userEmail.toLowerCase(),
        password: userPassword,
        secretHash: AppConstants.getSecretHash(userEmail.toLowerCase()),
        clientId: AppConstants.clientId,
        userAttributes: [
          // UserAttribute(name: 'phone_number', value: userMobile)
        ]);
  }

  void postSignUP(UserSignUpParam signUpParams) async {
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

    Map params = signUpParams.toJson();

    String url = AppConstants.baseURLpcMatic;

    final response = await apiUtils.post(
      url: url,
      data: jsonEncode(params),
      options: Options(
        headers: {
          "Content-Type": 'application/x-amz-json-1.1',
          "X-Amz-Target": EndPoints.signUpHeader,
        },
      ),
    );

    return response.fold((l) {
      showLoader.value = false;

      Dialogs.showErrorDialog(errorCode: l.type!, errorMessage: l.message!);
    }, (r) {
      // UserSignUpModel userSignUpModel = userSignUpModelFromJson(r.data);

      // amzStorage.saveAMZUserEmail(signUpParams.username);
      // amzStorage.saveAMZUserPassword(signUpParams.password);

      showLoader.value = false;

      constants.showSnackbar(
          'Code Sent to your Email', 'Please check your email for code', 1);
    });
  }
}
