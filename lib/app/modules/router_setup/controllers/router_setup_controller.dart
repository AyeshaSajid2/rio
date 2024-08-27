import 'dart:math';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:usama/app/data/models/wifi/get_wifi_list_model.dart';
import 'package:usama/core/utils/helpers/askey_storage.dart';

import '../../../../core/extensions/imports.dart';
import '../../../../core/utils/services/api/repository/common_repository.dart';
import '../../../data/models/room/get_room_list_model.dart';
import '../../../data/models/room/set_room_model.dart';
import '../../../data/models/status_model.dart';
import '../../../data/params/rooms/set_room_param.dart';
import '../../../data/params/rooms/set_rooms_param.dart';
import '../../../data/params/wifi/set_wifi_param.dart';
import '../views/router_config_view.dart';

class RouterSetupController extends GetxController with WidgetsBindingObserver {
  CommonRepo apiRepo = CommonRepo();
  final GlobalKey<FormState> routerSettingsKey = GlobalKey<FormState>();

  ScrollController routerSetupInfoSC = ScrollController();
  ScrollController routerSetupSettingSC = ScrollController();

  RxBool isNetworkError = false.obs;
  RxBool isServerError = false.obs;
  RxBool showLoader = false.obs;

  GetWifiListModel getWifiListModel = asKeyStorage.getAsKeyWifiListModel();
  GetRoomListModel getRoomListModel = asKeyStorage.getAsKeyRoomListModel();

  List<TextEditingController> listOfWifiNameTEC = [];
  List<TextEditingController> listOfWifiPasswordsTEC = [];
  List<String> listOfSuffixText = ['-Admin', '-Managed', '-Guest', '-Shared'];

  RxList<RxList<SetRoomParam>> allWifiRoomsParamsList =
      <RxList<SetRoomParam>>[].obs;
  List<SetWifiParam> allSsidList = <SetWifiParam>[];

  RxInt roomCount = 0.obs;
  RxDouble percentageIndicator = 0.0.obs;

  List<RxBool> listOfExpandedRooms = [
    false.obs,
    false.obs,
    false.obs,
    false.obs,
  ];
  List<RxBool> listOfShowPassword = [
    false.obs,
    false.obs,
    false.obs,
    false.obs,
  ];

  List<Map<String, String>> listOfSSIDAndRoomsInfo = [
    {
      'Wi-Fi networks and SecureRooms™':
          'Your Rio Router allows up to 4 different Wi-Fi Networks (SSIDs) and 16 SecureRooms for various purposes.'
    },
    {
      'SSID-ADMIN-CONSOLE':
          'This is reserved for the ADMINISTRATOR/SUPERVISOR of the router and cannot be changed. The other 3 SSIDs can retain their original names or be assigned unique names for easier identification.'
    },
    {
      'Admin Functions':
          'The first device connected to the admin room becomes the administrator of your Rio Router. The administrator controls all functions and features to your Rio. You can add unlimited devices with admin permissions, however be mindful that these devices will have complete control so for security reasons you should limit how many you want to have admin access.'
    },
    {
      'Setting up other SSIDs':
          'Each of the 3 SSIDs serves a different purpose:'
    },
    {
      'Device Protection':
          'Every device connecting to the router needs to be approved by the administrator before it can connect.'
    },
  ];
  List<Map<String, String>> listOfSubSSIDAndRoomsInfo = [
    {
      '• SSID-MANAGED':
          'Allows the admin to restrict the use of the secured rooms assigned to this SSID, such as “Parental Control”. Access can be restricted by duration or time.'
    },
    {
      '• SSID-SHARED':
          'For devices that can be shared by all devices within the network, like printers and security cameras.'
    },
    {
      '• SSID-GUEST':
          'For guest devices to connect to your Rio. Once a guest disconnects from the network, their credentials will be deleted. Returning guests would have to be re-admitted by the ADMIN.'
    }
  ];

  List<Map<String, String>> listOfSSIDSetting = [
    {
      'Zero Trust Protection':
          'Your Rio delivers unparalleled zero trust security. This means that every device attempting to connect to the router must be approved and assigned by administrator before it can connect to your internet.'
    },
    {
      'SecureRoom Access':
          'Approved devices assigned to a SecureRoom cannot access other SecureRooms unless the admin authorizes the access.'
    },
    {
      'Group SecureRooms':
          'With up to 16 different SecureRooms available, you have the flexibility to group them under various SSIDs as per your preference.'
    }
  ];
  RxBool isKeyboardOpened = false.obs;

  @override
  void onInit() {
    callInitFunc();
    WidgetsBinding.instance.addObserver(this);

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
    WidgetsBinding.instance.removeObserver(this);

    super.onClose();
  }

  @override
  void didChangeMetrics() {
    super.didChangeMetrics();
    final bottomInset = WidgetsBinding
        .instance.platformDispatcher.views.first.viewInsets.bottom;
    isKeyboardOpened.value = bottomInset > 0.0;
  }

  String removeStrings(String input, List<String> stringsToRemove) {
    String pattern = stringsToRemove.map((s) => RegExp.escape(s)).join('|');
    RegExp regex = RegExp(pattern, caseSensitive: false);
    return input.replaceAll(regex, '');
  }

  saveAndContinue() async {
    Get.to(() => const RouterConfigView());

    await setWifi(allSsidList[0].copyWith(
            name: listOfWifiNameTEC[0].text,
            password: listOfWifiPasswordsTEC[0].text))
        .then((value) => percentageIndicator.value = 10);

    await setWifi(allSsidList[1].copyWith(
            name: listOfWifiNameTEC[1].text + listOfSuffixText[1],
            password: listOfWifiPasswordsTEC[1].text))
        .then((value) => percentageIndicator.value = 20);
    await setWifi(allSsidList[2].copyWith(
            name: listOfWifiNameTEC[2].text + listOfSuffixText[2],
            password: listOfWifiPasswordsTEC[2].text))
        .then((value) => percentageIndicator.value = 30);
    await setWifi(allSsidList[3].copyWith(
            name: listOfWifiNameTEC[3].text + listOfSuffixText[3],
            password: listOfWifiPasswordsTEC[3].text))
        .then((value) => percentageIndicator.value = 40);

    await callSetRoomAPIs();

    await apiRepo.getWifiList().then((value) {
      value.fold((l) => null, (r) {
        getWifiListModel = r;
        percentageIndicator.value = 85;
      });
    });
    await apiRepo.getRoomList(apiRepo.fillGetAllRooms()).then((value) {
      if (value != null) {
        getRoomListModel = value;
        percentageIndicator.value = 100;
      }
    });
  }

  callInitFunc() {
    addWifiAndRoomTECs();
    Future.wait([
      apiRepo.getWifiList().then((value) {
        value.fold((l) => null, (r) {
          getWifiListModel = r;
        });
      }),
      apiRepo.getRoomList(apiRepo.fillGetAllRooms()).then((value) {
        if (value != null) {
          getRoomListModel = value;
        }
      }),
    ]).then((value) {
      addWifiAndRoomTECs();
    });
  }

  addWifiAndRoomTECs() {
    listOfWifiNameTEC.clear();
    listOfWifiPasswordsTEC.clear();
    allSsidList.clear();
    allWifiRoomsParamsList.clear();
    roomCount.value = 0;
    for (var i = 0; i < getWifiListModel.listOfWifi!.length; i++) {
      listOfWifiNameTEC.add(TextEditingController(
          text: (getWifiListModel.listOfWifi![i].id == '1' ||
                  getWifiListModel.listOfWifi![i].id == '2' ||
                  getWifiListModel.listOfWifi![i].id == '3')
              ? removeStrings(
                  getWifiListModel.listOfWifi![i].name!, listOfSuffixText)
              : getWifiListModel.listOfWifi![i].name!));

      listOfWifiPasswordsTEC.add(TextEditingController(
          text: (getWifiListModel.listOfWifi![i].password)));

      allSsidList.add(
        SetWifiParam(
          action: 'modify',
          id: getWifiListModel.listOfWifi![i].id!,
          name: (i == 1 || i == 2 || i == 3)
              ? listOfWifiNameTEC[i].text + listOfSuffixText[i]
              : listOfWifiNameTEC[i].text,
          status: getWifiListModel.listOfWifi![i].status!,
          password: getWifiListModel.listOfWifi![i].password!,
          broadcast: getWifiListModel.listOfWifi![i].broadcast!,
        ),
      );

      allWifiRoomsParamsList.add(<SetRoomParam>[].obs);
    }
    for (var room in getRoomListModel.listOfRoom!) {
      if (room.ssidId != '') {
        allWifiRoomsParamsList[int.parse(room.ssidId!)].add(SetRoomParam(
          action: 'modify',
          id: room.id!,
          nameEncode: room.nameEncode!,
          password: room.password!,
          ssidId: room.ssidId!,
          parentalControl: 'disable',
          vpnId: '0',
          roomStatus: 'enable',
        ));
        // allOldRoomsList.add(
        //   SetRoomsParam(
        //     action: 'modify',
        //     id: room.id!,
        //     nameEncode: room.nameEncode!,
        //     password: room.password!,
        //     ssidId: room.ssidId!,
        //     parentalControl: 'disable',
        //     vpnId: '',
        //     roomStatus: 'enable',
        //   ),
        // );
        roomCount.value++;
      }
    }
  }

  Future<void> callSetRoomAPIs() async {
    int currentRoomIndexInTotal = 0;
    for (var index = 0; index < allWifiRoomsParamsList.length; index++) {
      for (var i = 0; i < allWifiRoomsParamsList[index].length; i++) {
        await setRoom(allWifiRoomsParamsList[index][i]);
        currentRoomIndexInTotal++;
        percentageIndicator.value =
            (40 + ((currentRoomIndexInTotal / roomCount.value) * 30))
                .roundToDouble();
      }
    }
  }

  void modifyRoom(SetRoomParam modifiedRoom, int index, int i) {
    allWifiRoomsParamsList[index][i] = modifiedRoom;
  }

  void addNewRoom(SetRoomParam newRoom) {
    allWifiRoomsParamsList[int.parse(newRoom.ssidId)].add(newRoom);
    // allNewRoomsList.add(fillSetRoomAdd(newRoom));

    roomCount.value++;
  }

  SetRoomParam newRoom(int index) {
    return SetRoomParam(
      action: 'create',
      id: '0',
      nameEncode: '',
      password: '',
      ssidId: '$index',
      parentalControl: 'disable',
      vpnId: '0',
      roomStatus: 'enable',
    );
  }

  String generateRandomPassword(int length) {
    const chars =
        'abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789';
    final random = Random();
    return String.fromCharCodes(
      Iterable.generate(
        length,
        (_) => chars.codeUnitAt(random.nextInt(chars.length)),
      ),
    );
  }

  bool duplicatePasswordCheck(int wifiIndex, int roomIndex, String password) {
    bool result = false;
    for (var i = 0; i < allWifiRoomsParamsList.length; i++) {
      for (var j = 0; j < allWifiRoomsParamsList[i].length; j++) {
        if (allWifiRoomsParamsList[i][j].password == password &&
            i != wifiIndex &&
            j != roomIndex) {
          result = true;
        }
      }
    }

    return result;
  }

  bool duplicateRoomNameCheck(int wifiIndex, int roomIndex, String roomName) {
    bool result = false;
    for (var i = 0; i < allWifiRoomsParamsList.length; i++) {
      for (var j = 0; j < allWifiRoomsParamsList[i].length; j++) {
        if (allWifiRoomsParamsList[i][j].nameEncode.decodeBase64 == roomName &&
            i != wifiIndex &&
            j != roomIndex) {
          result = true;
        }
      }
    }

    return result;
  }

  FutureWithEither<GetWifiListModel> getWifiList() async {
    // wifiShowLoader.value = true;
    showLoader.value = true;
    isNetworkError.value = false;
    isServerError.value = false;

    final connectivityResult = await (Connectivity().checkConnectivity());
    if (connectivityResult.contains(ConnectivityResult.none)) {
      constants.showSnackbar('Network Error', 'No internet access', 0);
      // wifiShowLoader.value = false;
      showLoader.value = false;
      isServerError.value = false;
      isNetworkError.value = true;

      return left(
          ErrorModel(errorCode: '100', errorMessage: 'No Internet Connection'));
    }

    String url = AppConstants.baseUrlAsKey + EndPoints.wifiListGetEndPoint;

    final response = await apiUtilsWithHeader.get(url: url, firstTime: true);

    return response.fold((l) {
      showLoader.value = false;
      return left(l);
    }, (r) {
      getWifiListModel = GetWifiListModel.fromJson(r.data);
      asKeyStorage.saveAsKeyWifiListModel(getWifiListModel);

      showLoader.value = false;

      return right(getWifiListModel);
    });
  }

  Future<StatusModel?> setWifi(SetWifiParam setWifiParam) async {
    final connectivityResult = await (Connectivity().checkConnectivity());
    if (connectivityResult.contains(ConnectivityResult.none)) {
      return null;
    }

    Map params = setWifiParam.toJson();

    String url = AppConstants.baseUrlAsKey + EndPoints.wifiSetEndPoint;

    final response = await apiUtilsWithHeader.put(
        url: url, data: jsonEncode(params), firstTime: true);

    return response.fold((l) {
      return null;
    }, (r) async {
      StatusModel status = StatusModel.fromJson(r.data);

      return status;
    });
  }

  SetRoomParam fillSetRoomAdd(SetRoomsParam newRoom) {
    return SetRoomParam(
      action: 'create',
      id: '0',
      nameEncode: newRoom.nameEncode,
      password: newRoom.password,
      ssidId: newRoom.ssidId,
      parentalControl: newRoom.parentalControl,
      vpnId: newRoom.vpnId,
      roomStatus: newRoom.roomStatus,
    );
  }

  Future<SetRoomModel?> setRoom(SetRoomParam setRoomParam) async {
    final connectivityResult = await (Connectivity().checkConnectivity());
    if (connectivityResult.contains(ConnectivityResult.none)) {
      constants.showSnackbar('Network Error', 'No internet access', 0);

      return null;
    }

    Map params = setRoomParam.toJson();

    String url = AppConstants.baseUrlAsKey + EndPoints.roomSetEndPoint;

    final response = await apiUtilsWithHeader.put(
        url: url, data: jsonEncode(params), firstTime: true);
    return response.fold((l) {
      return null;
    }, (r) {
      SetRoomModel setRoomModel = SetRoomModel.fromJson(r.data);

      return setRoomModel;
    });
  }

  Future<StatusModel?> setRooms(List<SetRoomsParam> listOfSetRoomsParam) async {
    final connectivityResult = await (Connectivity().checkConnectivity());
    if (connectivityResult.contains(ConnectivityResult.none)) {
      constants.showSnackbar('Network Error', 'No internet access', 0);

      return null;
    }

    String url = AppConstants.baseUrlAsKey + EndPoints.roomsSetEndPoint;

    final response = await apiUtilsWithHeader.put(
        url: url,
        data: setRoomsParamToJson(listOfSetRoomsParam),
        firstTime: true);

    return response.fold((l) {
      showLoader.value = false;

      return null;
    }, (r) async {
      StatusModel status = StatusModel.fromJson(r.data);

      return status;
    });
  }
}
