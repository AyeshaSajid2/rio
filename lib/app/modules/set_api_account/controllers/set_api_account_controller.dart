// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:get_storage/get_storage.dart';

// import '../../../../core/extensions/imports.dart';

// import '../../../data/models/api_account/get_api_account_model.dart';
// import '../../../data/models/status_model.dart';
// import '../../../data/models/vpn/get_vpn_login_status_model.dart';
// import '../../../data/params/api_account/set_api_account_param.dart';
// import '../../add_room/controllers/add_room_controller.dart';
// import '../../secure_room_tabs/controllers/secure_room_tabs_controller.dart';
// import '../../vpn/controllers/vpn_controller.dart';

// class SetApiAccountController extends GetxController {
//   final GlobalKey<FormState> apiAccountKey = GlobalKey<FormState>();

//   GetApiAccountModel getApiAccountModel = GetApiAccountModel();
//   GetVpnLoginStatusModel getVpnLoginStatusModel = GetVpnLoginStatusModel();

//   VpnController? vpnController;
//   AddRoomController? addRoomController;
//   SecureRoomTabsController? secureRoomTabsController;

//   RxBool showLoader = false.obs;

//   RxBool showPassword = false.obs;
//   // RxBool showConfirmWiFiPassword = false.obs;
//   // RxBool showAdminPassword = false.obs;
//   // RxBool showConfirmAdminPassword = false.obs;

//   final box = GetStorage('AsKey');

//   TextEditingController accountTEC = TextEditingController();
//   TextEditingController passwordTEC = TextEditingController();

//   late Map arg;
//   bool isFromVPN = true;
//   bool isFromAddRoom = false;
//   bool isFromVPNPlusAddRoom = false;
//   bool isFromVPNPlusSecureRoom = false;

//   @override
//   void onInit() {
//     arg = Get.arguments;

//     isFromVPN = arg['isFromVPN'];
//     isFromAddRoom = arg['isFromAddRoom'];

//     if (isFromVPN) {
//       isFromVPNPlusAddRoom = arg['isFromVPNPlusAddRoom'];
//       isFromVPNPlusSecureRoom = arg['isFromVPNPlusSecureRoom'];
//       vpnController = Get.find<VpnController>();
//     } else if (isFromAddRoom) {
//       addRoomController = Get.find<AddRoomController>();
//     } else {
//       secureRoomTabsController = Get.find<SecureRoomTabsController>();
//     }

//     getApiAccount();
//     super.onInit();
//   }

//   @override
//   void onReady() {
//     //
//     super.onReady();
//   }

//   @override
//   void onClose() {
//     //
//     super.onClose();
//   }

//   SetApiAccountParam fillSetApiAccount() {
//     return SetApiAccountParam(
//         host: 'api.wlvpn.com',
//         key: 'bca1909ef12d5b1bd171951d391bcee7',
//         account: accountTEC.text,
//         password: passwordTEC.text,
//         passwordEncode: base64Encode(utf8.encode(passwordTEC.text)));
//   }

//   Future<StatusModel?> setApiAccount(
//       SetApiAccountParam setApiAccountParam) async {
//     showLoader.value = true;

//     final connectivityResult = await (Connectivity().checkConnectivity());
//     if (connectivityResult == ConnectivityResult.none) {
//       constants.showSnackbar('Network Error', 'No internet access', 0);
//       showLoader.value = false;

//       return null;
//     }

//     Map params = setApiAccountParam.toJson();

//     String url = AppConstants.baseUrlAsKey + EndPoints.apiAccountEndPoint;

//     final response = await apiUtilsWithHeader.put(
//         url: url, data: jsonEncode(params), firstTime: true);

//     return response.fold((l) {
//       showLoader.value = false;

//       return null;
//     }, (r) async {
//       StatusModel status = StatusModel.fromJson(r.data);

//       await getVPNLoginStatus().then((value) {
//         value.fold((l) {
//           showLoader.value = false;
//           if (l.status! == '598') {
//             constants.showSnackbar('Connection Timeout',
//                 'Please check your internet connection and try again.', 0);
//           } else if (l.status! == '599') {
//             constants.showSnackbar('Connection Error',
//                 'Please check your internet connection and try again.', 0);
//           } else {
//             constants.showSnackbar(
//                 'VPN Account',
//                 'Unable to setup VPN connection, please check and enter your VPN account and try again.',
//                 0);
//           }
//         }, (r) async {
//           if (r.loginStatus! == 'success') {
//             if (isFromVPN) {
//               if (isFromVPNPlusAddRoom) {
//                 addRoomController = Get.find<AddRoomController>();
//                 await addRoomController!.getVpnList();
//                 addRoomController!.showSetVpnButton.value = false;
//               } else if (isFromVPNPlusSecureRoom) {
//                 secureRoomTabsController = Get.find<SecureRoomTabsController>();
//                 await secureRoomTabsController!.getVpnList();
//                 secureRoomTabsController!.showSetVpnButton.value = false;
//               }
//               await vpnController!.getVpnList();
//               await vpnController!.getVpnServerList();
//               vpnController!.showEnableVPN.value = false;
//             } else if (isFromAddRoom) {
//               await addRoomController!.getVpnList();
//               addRoomController!.showSetVpnButton.value = false;
//             } else {
//               await secureRoomTabsController!.getVpnList();
//               secureRoomTabsController!.showSetVpnButton.value = false;
//             }

//             showLoader.value = false;

//             Get.back();

//             constants.showSnackbar(
//                 'VPN Account', 'VPN account is setup successfully', 1);
//           } else {
//             //"login_status":"forbid","login_status_str":"Too many failed attempts"
//             //"login_status":"auth fail","login_status_str":"The username or password provided is incorrect"

//             if (isFromVPN) {
//               vpnController!.showEnableVPN.value = true;
//               if (isFromVPNPlusAddRoom) {
//                 addRoomController = Get.find<AddRoomController>();
//                 addRoomController!.showSetVpnButton.value = true;
//               } else if (isFromVPNPlusSecureRoom) {
//                 secureRoomTabsController = Get.find<SecureRoomTabsController>();
//                 secureRoomTabsController!.showSetVpnButton.value = true;
//               }
//             } else {}

//             showLoader.value = false;

//             constants.showSnackbar(
//                 'VPN Account',
//                 'Unable to setup VPN connection, please check and enter your VPN account and try again.',
//                 0);
//           }
//         });
//       });

//       return status;
//     });
//   }

//   FutureWithEither<GetApiAccountModel> getApiAccount() async {
//     showLoader.value = true;

//     final connectivityResult = await (Connectivity().checkConnectivity());
//     if (connectivityResult == ConnectivityResult.none) {
//       constants.showSnackbar('Network Error', 'No internet access', 0);
//       showLoader.value = false;

//       return left(
//           ErrorModel(errorCode: '100', errorMessage: 'No Internet Connection'));
//     }

//     String url = AppConstants.baseUrlAsKey + EndPoints.apiAccountEndPoint;

//     final response = await apiUtilsWithHeader.get(url: url, firstTime: true);

//     return response.fold((l) {
//       showLoader.value = false;
//       return left(l);
//     }, (r) {
//       getApiAccountModel = GetApiAccountModel.fromJson(r.data);

//       accountTEC.text = getApiAccountModel.account!;
//       passwordTEC.text = getApiAccountModel.password!;

//       // clearAll();

//       showLoader.value = false;

//       return right(getApiAccountModel);
//     });
//   }

//   FutureWithEither<GetVpnLoginStatusModel> getVPNLoginStatus() async {
//     showLoader.value = true;

//     String url =
//         AppConstants.baseUrlAsKey + EndPoints.vpnLoginStatusGetEndPoint;

//     final response = await apiUtilsWithHeader.get(url: url, firstTime: true);

//     return response.fold((l) {
//       showLoader.value = false;
//       return left(l);
//     }, (r) {
//       getVpnLoginStatusModel = GetVpnLoginStatusModel.fromJson(r.data);

//       // showLoader.value = false;

//       return right(getVpnLoginStatusModel);
//     });
//   }
// }
