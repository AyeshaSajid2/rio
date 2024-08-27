import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:usama/app/data/params/sign_up_apis/get_user_param.dart';
import 'package:usama/app/data/params/sign_up_apis/user_sign_up_param.dart';
import 'package:usama/core/utils/helpers/amz_storage.dart';
import 'package:webview_flutter/webview_flutter.dart';

import '../../../../core/extensions/imports.dart';
import '../../../../core/utils/helpers/askey_storage.dart';
import '../../../data/models/sign_up_apis/user_sign_up_model.dart';
import '../../../routes/app_pages.dart';

class SignUpController extends GetxController {
  final GlobalKey<FormState> signUpKey = GlobalKey<FormState>();

  ScrollController scrollController = ScrollController();

  RxBool showLoader = false.obs;
  RxBool isNetworkError = false.obs;
  RxBool isServerError = false.obs;

  RxBool showPassword = false.obs;
  RxBool showConfirmPassword = false.obs;
  RxBool isTermsAccepted = false.obs;

  // final box = GetStorage('PC_Matic');

  TextEditingController emailTextCtrl = TextEditingController();
  // TextEditingController mobileTextCtrl = TextEditingController();
  TextEditingController passwordTextCtrl = TextEditingController();
  TextEditingController passwordConfirmTextCtrl = TextEditingController();

  // String completeMobileNo = '';

  // RxDouble pageHeight =
  //     (Get.height - Get.statusBarHeight + (Get.mediaQuery.padding.top / 2)).obs;

  // List<bool> didErrorOccurred = [false, false];

  late WebViewController webViewController;
  RxBool pageOpened = true.obs;

  @override
  void onInit() {
    //

    webViewController = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setNavigationDelegate(
        NavigationDelegate(
          onProgress: (int progress) {
            // Update loading bar.
          },
          onPageStarted: (String url) {
            pageOpened.value = false;
          },
          onPageFinished: (String url) {
            // saveLastSpeedTestDate();
            pageOpened.value = true;
          },
          onWebResourceError: (WebResourceError error) {},
          onNavigationRequest: (NavigationRequest request) {
            if (request.url.startsWith('https://www.youtube.com/')) {
              return NavigationDecision.prevent;
            }
            return NavigationDecision.navigate;
          },
        ),
      )
      ..loadRequest(
          Uri.parse('https://riorouter.com/policies/terms-of-service'));
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
    passwordTextCtrl.dispose();
    super.onClose();
  }

  // void updateScreenSize(int index) {
  //   if (!didErrorOccurred[index]) {
  //     pageHeight.value = pageHeight.value + (Get.height * 0.025);
  //     didErrorOccurred[index] = true;
  //   }
  // }

  UserSignUpParam fillSignUp() {
    return UserSignUpParam(
        username: emailTextCtrl.text.trim().toLowerCase(),
        password: passwordTextCtrl.text.trim(),
        secretHash:
            AppConstants.getSecretHash(emailTextCtrl.text.toLowerCase()),
        clientId: AppConstants.clientId,
        userAttributes: [
          // UserAttribute(name: 'phone_number', value: completeMobileNo)
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
      // if (l.type == 'UsernameExistsException') {
      //   Get.toNamed(Routes.VERIFY, arguments: {
      //     'Email': signUpParams.username,
      //     'Mobile': mobileTextCtrl.text,
      //     'Password': signUpParams.password,
      //   });
      // } else {
      Dialogs.showErrorDialog(errorCode: l.type!, errorMessage: l.message!);
      // }
    }, (r) {
      UserSignUpModel userSignUpModel = UserSignUpModel();

      userSignUpModel = userSignUpModelFromJson(r.data);

      amzStorage.saveAMZUserEmail(signUpParams.username);
      // amzStorage.saveAMZUserMobileNo(completeMobileNo);
      amzStorage.saveAMZUserPassword(signUpParams.password);

      asKeyStorage.saveAsKeyResetStatus(false);

      showLoader.value = false;

      if (userSignUpModel.userConfirmed!) {
        //If User is already Confirmed
      } else {
        Get.toNamed(Routes.VERIFY, arguments: {
          'Email': signUpParams.username,
          // 'Mobile': completeMobileNo,
          'Password': signUpParams.password,
        });
      }
    });
  }

  GetUserParam fillGetUser() {
    return GetUserParam(
        username: emailTextCtrl.text.toLowerCase(),
        clientId: AppConstants.clientId,
        userAttributes: [UserAttribute(name: 'name', value: 'value')],
        accessToken: '');
  }

  void getUser(GetUserParam getUserParams) async {
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

    Map params = getUserParams.toJson();

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

      Dialogs.showErrorDialog(errorCode: l.type!, errorMessage: l.message!);
    }, (r) {
      // UserSignUpModel userSignUpModel = UserSignUpModel.fromJson(r.data);
      // box.write('UserPCMaticEmail', getUserParams.username);
      // box.write('UserPCMaticPassword', getUserParams.password);

      showLoader.value = false;

      // if (userSignUpModel.userConfirmed!) {
      //   //If User is already Confirmed
      // } else {
      //   Get.toNamed(Routes.VERIFY, arguments: {
      //     'Email': getUserParams.username,
      //     'ForgotPasswordPage': false
      //   });
      // }

      // constants.showSnackbar('Welcome to Rio', 'Signed Up Successfully', 1);
    });
  }
}
