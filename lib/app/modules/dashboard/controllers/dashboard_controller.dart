import 'package:flutter/material.dart';
import 'package:flutter_background_service/flutter_background_service.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:get/get.dart';
import 'package:network_info_plus/network_info_plus.dart';
import 'package:usama/app/data/models/wifi/get_wifi_list_model.dart';
import 'package:usama/core/utils/helpers/askey_storage.dart';
import 'package:usama/core/utils/services/api/repository/common_repository.dart';
import 'package:wifi_iot/wifi_iot.dart';

import '../../../../core/extensions/imports.dart';
import '../../../data/models/device/get_device_list_model.dart';
import '../../../data/models/room/get_room_list_model.dart';
import '../../../data/models/status_model.dart';
import '../../../data/params/device/delete_device_param.dart';
import '../../../data/params/device/get_device_list_param.dart';
import '../../../data/params/device/move_device_param.dart';
import '../../../data/params/device/set_device_admin_param.dart';
import '../../../data/params/device/set_device_block_param.dart';
import '../../../data/params/device/set_device_label_param.dart';
import '../../../data/params/rooms/get_room_list_param.dart';
import '../../home/controllers/home_controller.dart';

class DashboardController extends GetxController {
  final ScrollController dashboardScrollController = ScrollController();

  RxBool roomListBottomBarShowLoader = false.obs;
  RxBool roomListShowLoader = false.obs;
  RxBool showLoader = false.obs;

  GetWifiListModel getWifiListModel = asKeyStorage.getAsKeyWifiListModel();

  GetDeviceListModel getDevicesListModel = GetDeviceListModel();
  HomeController homeController = Get.find<HomeController>();

  RxList<DeviceListItem> allDevicesList = <DeviceListItem>[].obs;
  RxList<DeviceListItem> blockedDevicesList = <DeviceListItem>[].obs;
  RxList<DeviceListItem> waitingDevicesList = <DeviceListItem>[].obs;
  RxList<DeviceListItem> roomsDevicesList = <DeviceListItem>[].obs;

  RxString connectedDevicesCount = ''.obs;
  RxString pendingDevicesCount = ''.obs;
  RxString blockedDevicesCount = ''.obs;

  final String allDeviceType = 'all';
  final String waitDeviceType = 'wait';
  final String roomDeviceType = 'room';
  final String blockDeviceType = 'block';

  Rx<DeviceListItem> selectedDeviceListItem = DeviceListItem().obs;
  String selectedDeviceType = 'all';
  bool isSelectedDeviceAdministrator = false;

  Rx<RoomListItem> selectedRoom = RoomListItem().obs;
  GetRoomListModel getRoomsListForMoveToOtherRooms =
      GetRoomListModel(listOfRoom: []);
  GetRoomListModel getRoomListModel = asKeyStorage.getAsKeyRoomListModel();

  RxList<RoomListItem> adminRoomList = <RoomListItem>[].obs;
  RxList<RoomListItem> managedRoomList = <RoomListItem>[].obs;
  RxList<RoomListItem> sharedRoomList = <RoomListItem>[].obs;
  RxList<RoomListItem> guestRoomList = <RoomListItem>[].obs;

  List<List<RoomListItem>> allWifiRoomsList = [];
  RxList<RoomListItem> allRoomsList = <RoomListItem>[].obs;

  RxList<RoomListItem> ethernetLanRoomList = <RoomListItem>[].obs;

  RxString pageTitle = 'Admin'.obs;
  RoomListItem connectedDeviceRoom = RoomListItem();

  RxBool showRefreshTitle = false.obs;

  final connectivity = Connectivity();
  List<ConnectivityResult> connectivityResult = [ConnectivityResult.none];
  late StreamSubscription connectivityStreamSubscription;

  RxString? wifiName = ''.obs;
  RxString statusText = 'No internet connection'.obs;
  RxBool isWifiConnected = false.obs;

  FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  RxString routerStatus = 'Online'.obs;

  @override
  void onInit() {
    //

    // SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.light);

    // getAllDevices();
    getDeviceList(fillGetAllDevices(), null).then((value) => startFunc());

    // FlutterBackgroundService().invoke("setAsBackground");

    flutterLocalNotificationsPlugin.initialize(
      InitializationSettings(
        android: const AndroidInitializationSettings("@mipmap/ic_notification"),
        iOS: DarwinInitializationSettings(
          onDidReceiveLocalNotification: (id, title, body, payload) {
            pendingDevicesCount.value = payload.toString();
          },
        ),
      ),
    );

    super.onInit();
  }

  @override
  void onReady() async {
    //

    await checkWifi();

    FlutterBackgroundService().invoke("setAsForeground", {
      'AdminUserName': asKeyStorage.getAsKeyAdminUserName(),
      'AdminPassword': asKeyStorage.getAsKeyAdminPassword(),
      'token': asKeyStorage.getAdminLoginModel().token,
      'URL': AppConstants.baseUrlAsKey
    });
    super.onReady();
  }

  @override
  void onClose() {
    //

    connectivityStreamSubscription.cancel();
    super.onClose();
  }

  Future checkWifi() async {
    connectivityResult = await connectivity.checkConnectivity();

    await changeWifiStatus();

    connectivityStreamSubscription = connectivity.onConnectivityChanged
        .listen((List<ConnectivityResult> result) async {
      connectivityResult = result;
      await changeWifiStatus();
    });
    return;
  }

  Future changeWifiStatus() async {
    if (connectivityResult.contains(ConnectivityResult.wifi)) {
      isWifiConnected.value = true;
      statusText.value = 'Connected to WiFi';

      String? ssid = "";

      ssid = await WiFiForIoTPlugin.getSSID();

      wifiName!.value = ssid.toString().removeAllWhitespace;

      if (wifiName!.value == 'null') {
        final info = NetworkInfo();

        String? name = await info.getWifiName(); // "FooNetwork"
        if (name != null) {
          String a = name.replaceAll("\"", "");
          wifiName!.value = a.removeAllWhitespace;
        } else {
          wifiName!.value = 'null';
        }
      }
    } else if (connectivityResult.contains(ConnectivityResult.mobile)) {
      statusText.value = 'Connected to Mobile network';
      isWifiConnected.value = false;
    } else if (connectivityResult.contains(ConnectivityResult.none)) {
      // No available network types
      isWifiConnected.value = false;
      statusText.value = 'No internet connection';
      // print("No network connection");
      constants.showSnackbar('Network Error', 'No Internet Access', 0);
    }
  }

  updateWifiAndRoomsFunc() async {
    showLoader.value = true;
    await CommonRepo().getWifiList().then((value) async {
      value.fold((l) => null, (r) => getWifiListModel = r);
    });
    await CommonRepo()
        .getRoomList(CommonRepo().fillGetAllRooms())
        .then((value) async {
      if (value != null) {
        getRoomListModel = value;
        addAllRoomInLists();

        selectedRoom.value = getRoomListModel.listOfRoom!.first;
      }
      showLoader.value = false;
    });
  }

  Future<GetRoomListModel?> startFunc() async {
    // await getRoomList(fillGetAllRooms(), '');

    roomListShowLoader.value = true;
    return await CommonRepo()
        .getRoomList(CommonRepo().fillGetAllRooms())
        .then((value) async {
      if (value != null) {
        getRoomListModel = value;
        addAllRoomInLists();

        selectedRoom.value = getRoomListModel.listOfRoom!.first;
      }
      roomListShowLoader.value = false;
      return value;
    });
  }

  void addAllRoomInLists() {
    allRoomsList.clear();
    allWifiRoomsList.clear();
    adminRoomList.clear();
    managedRoomList.clear();
    guestRoomList.clear();
    sharedRoomList.clear();
    ethernetLanRoomList.clear();

    for (var i = 0; i < getWifiListModel.listOfWifi!.length; i++) {
      allWifiRoomsList.add([]);
    }
    for (var room in getRoomListModel.listOfRoom!) {
      allRoomsList.add(room);
      if (room.ssidId != '') {
        allWifiRoomsList[int.parse(room.ssidId!)].add(room);
      } else {
        //Ethernet Rooms
        ethernetLanRoomList.add(room);
      }

      if (room.ssidId == '0') {
        //Admin Rooms
        adminRoomList.add(room);
      } else if (room.ssidId == '1') {
        //Managed Rooms
        managedRoomList.add(room);
      } else if (room.ssidId == '2') {
        //Guest Rooms
        guestRoomList.add(room);
      } else if (room.ssidId == '3') {
        //Shared Rooms
        sharedRoomList.add(room);
      }
    }
  }

  void addAllDevicesInLists(int? deviceId, String? roomId) {
    allDevicesList.clear();
    blockedDevicesList.clear();
    waitingDevicesList.clear();
    roomsDevicesList.clear();

    for (var device in getDevicesListModel.listOfDevices!) {
      allDevicesList.add(device);

      if (device.block == 'enable') {
        blockedDevicesList.add(device);
      }
      if (device.roomId == '') {
        //Pending/Waiting Devices
        waitingDevicesList.add(device);
      }
      if (roomId != null) {
        if (device.roomId == roomId) {
          //Rooms Device
          roomsDevicesList.add(device);
        }
      }
      if (deviceId != null) {
        if (device.id == deviceId) {
          selectedDeviceListItem.value = device;
        }
      }
    }
    connectedDevicesCount.value = allDevicesList.length.toString();
    pendingDevicesCount.value = waitingDevicesList.length.toString();
    blockedDevicesCount.value = blockedDevicesList.length.toString();
  }

  Future<GetDeviceListModel?> getAllDevices({int? deviceId}) async {
    return getDeviceList(fillGetAllDevices(), deviceId);
  }

  Future<void> getWaitingDevices() {
    return getDeviceList(fillGetWaitingDevices(), null);
  }

  // Future<void> getDevicesOfRoom(String roomId) {
  //   return getDeviceList(fillGetDevicesOfRoom(roomId));
  // }

  // Future<void> getBlockedDevices() {
  //   return getDeviceList(fillGetBlockedDevices());
  // }

  GetDeviceListParam fillGetAllDevices() {
    return GetDeviceListParam(id: '0', type: allDeviceType);
  }

  GetDeviceListParam fillGetWaitingDevices() {
    return GetDeviceListParam(id: '0', type: waitDeviceType);
  }

  // GetDeviceListParam fillGetDevicesOfRoom(String roomId) {
  //   return GetDeviceListParam(id: roomId, type: roomDeviceType);
  // }

  // GetDeviceListParam fillGetBlockedDevices() {
  //   return GetDeviceListParam(id: '0', type: blockDeviceType);
  // }

  Future<GetDeviceListModel?> getDeviceList(
      GetDeviceListParam getDeviceListParam, int? deviceId) async {
    showLoader.value = true;

    final connectivityResult = await (Connectivity().checkConnectivity());
    if (connectivityResult.contains(ConnectivityResult.none)) {
      constants.showSnackbar('Network Error', 'No internet access', 0);
      showLoader.value = false;

      return null;
    }

    Map params = getDeviceListParam.toJson();

    String url = AppConstants.baseUrlAsKey + EndPoints.deviceListGetEndPoint;

    final response = await apiUtilsWithHeader.put(
        url: url, data: jsonEncode(params), firstTime: true);
    return response.fold((l) {
      showLoader.value = false;

      return null;
    }, (r) async {
      getDevicesListModel = GetDeviceListModel.fromJson(r.data);

      if (getDeviceListParam.type == 'wait') {
        waitingDevicesList.value = getDevicesListModel.listOfDevices!;
        pendingDevicesCount.value = waitingDevicesList.length.toString();
      } else {
        addAllDevicesInLists(selectedDeviceListItem.value.id,
            selectedDeviceListItem.value.roomId);
      }

      // if (getDeviceListParam.type == 'all') {
      //   allDevicesList.value = getDevicesListModel.listOfDevices!;
      //   connectedDevicesCount.value = allDevicesList.length.toString();

      //   blockedDevicesList.clear();
      //   waitingDevicesList.clear();

      //   for (var device in getDevicesListModel.listOfDevices!) {
      //     if (device.block == 'enable') {
      //       //Blocked Devices

      //       blockedDevicesList.add(device);
      //     } else if (device.roomId!.isEmpty) {
      //       //  Pending/Waiting Devices
      //       waitingDevicesList.add(device);
      //     } else {
      //       //Connected Device whether online or offline
      //       // listOfAllDeviceBlockStatus.add(false.obs);//when you consider it as Connected Device
      //     }
      //   }
      //   pendingDevicesCount.value = waitingDevicesList.length.toString();
      //   blockedDevicesCount.value = blockedDevicesList.length.toString();
      // }

      // if (getDeviceListParam.type == 'wait') {
      //   waitingDevicesList.value = getDevicesListModel.listOfDevices!;
      //   pendingDevicesCount.value = waitingDevicesList.length.toString();
      // }

      // if (getDeviceListParam.type == 'room') {
      //   roomsDevicesList.value = getDevicesListModel.listOfDevices!;
      // }
      // if (getDeviceListParam.type == 'block') {
      //   blockedDevicesList.value = getDevicesListModel.listOfDevices!;

      //   blockedDevicesCount.value = blockedDevicesList.length.toString();
      // }
      showRefreshTitle.value = false;

      Timer(const Duration(seconds: 10), () {
        showRefreshTitle.value = true;
      });

      showLoader.value = false;

      return getDevicesListModel;
    });
  }

  RxList<DeviceListItem> findDeviceListByType(String type) {
    switch (type) {
      case 'all':
        return allDevicesList;
      case 'wait':
        return waitingDevicesList;
      case 'room':
        return roomsDevicesList;
      case 'block':
        return blockedDevicesList;
      default:
        return allDevicesList;
    }
  }

  // Future<void> updateDeviceListByType(String type, String currentRoomId) async {
  //   if (type == roomDeviceType) {
  //     await getDeviceList(fillGetDevicesOfRoom(currentRoomId));
  //   } else if (type == waitDeviceType) {
  //     await getDeviceList(fillGetWaitingDevices());
  //   } else if (type == blockDeviceType) {
  //     await getDeviceList(fillGetBlockedDevices());
  //   } else {
  //     await getDeviceList(fillGetAllDevices());
  //   }
  // }

  MoveDeviceParam fillMoveDevice(
      {required int deviceId, required String type}) {
    return MoveDeviceParam(
      deviceId: deviceId.toString(),
      roomId: selectedRoom.value.id!,
    );
  }

  Future<StatusModel?> moveDevice(
      {required MoveDeviceParam moveDeviceParam,
      required String type,
      required String currentRoomId}) async {
    showLoader.value = true;

    final connectivityResult = await (Connectivity().checkConnectivity());
    if (connectivityResult.contains(ConnectivityResult.none)) {
      constants.showSnackbar('Network Error', 'No internet access', 0);
      showLoader.value = false;

      return null;
    }

    Map params = moveDeviceParam.toJson();

    String url = AppConstants.baseUrlAsKey + EndPoints.moveDeviceEndPoint;

    final response = await apiUtilsWithHeader.put(
        url: url, data: jsonEncode(params), firstTime: true);
    return response.fold((l) {
      showLoader.value = false;

      return null;
    }, (r) async {
      var statusModel = StatusModel.fromJson(r.data);

      await getAllDevices(deviceId: int.parse(moveDeviceParam.deviceId));

      if (currentRoomId.isEmpty) {
        Get.back();
        constants.showSnackbar('Device Status',
            'Successfully moved to ${selectedRoom.value.name} room', 1);
      } else {
        constants.showSnackbar(
            'Device Status', 'Successfully changed device room', 1);
      }

      showLoader.value = false;

      return statusModel;
    });
  }

  SetDeviceBlockParam fillBlockDevice({required int deviceId}) {
    return SetDeviceBlockParam(id: deviceId.toString(), status: 'enable');
  }

  SetDeviceBlockParam fillUnBlockDevice({required int deviceId}) {
    return SetDeviceBlockParam(id: deviceId.toString(), status: 'disable');
  }

  Future<StatusModel?> blockDevice(
      {required SetDeviceBlockParam setDeviceBlockParam,
      required String type,
      required String currentRoomId}) async {
    showLoader.value = true;

    final connectivityResult = await (Connectivity().checkConnectivity());
    if (connectivityResult.contains(ConnectivityResult.none)) {
      constants.showSnackbar('Network Error', 'No internet access', 0);
      showLoader.value = false;

      return null;
    }

    Map params = setDeviceBlockParam.toJson();

    String url = AppConstants.baseUrlAsKey + EndPoints.deviceBlockSetEndPoint;

    final response = await apiUtilsWithHeader.put(
        url: url, data: jsonEncode(params), firstTime: true);

    return response.fold((l) {
      showLoader.value = false;
      return null;
    }, (r) async {
      var statusModel = StatusModel.fromJson(r.data);

      await getAllDevices(deviceId: int.parse(setDeviceBlockParam.id));

      if (setDeviceBlockParam.status == 'enable') {
        constants.showSnackbar(
            'Device Status', 'Successfully device blocked', 1);
      } else {
        constants.showSnackbar(
            'Device Status', 'Successfully device unblocked', 1);
      }

      showLoader.value = false;

      return statusModel;
    });
  }

  DeleteDeviceParam fillDeleteDevice({required int deviceId}) {
    return DeleteDeviceParam(id: deviceId.toString());
  }

  Future<StatusModel?> deleteDevice(
      {required DeleteDeviceParam setDeleteDeviceParam,
      required String type,
      required String currentRoomId}) async {
    showLoader.value = true;

    final connectivityResult = await (Connectivity().checkConnectivity());
    if (connectivityResult.contains(ConnectivityResult.none)) {
      constants.showSnackbar('Network Error', 'No internet access', 0);
      showLoader.value = false;

      return null;
    }

    Map params = setDeleteDeviceParam.toJson();

    String url = AppConstants.baseUrlAsKey + EndPoints.deleteDeviceEndPoint;

    final response = await apiUtilsWithHeader.put(
        url: url, data: jsonEncode(params), firstTime: true);
    return response.fold((l) {
      showLoader.value = false;

      return null;
    }, (r) async {
      var statusModel = StatusModel.fromJson(r.data);

      await getAllDevices();

      Future.delayed(const Duration(seconds: 30), () {
        getAllDevices();
      });

      // constants.showSnackbar('Device Status', 'Successfully deleted device', 1);

      // await getWaitingDevices();
      // await getAllDevices();

      showLoader.value = false;

      return statusModel;
    });
  }

  GetRoomListParam fillGetAllRooms() {
    return GetRoomListParam(type: 'none', id: '0');
  }

  GetRoomListParam fillGetAllRoomsOfSSID(String ssid) {
    return GetRoomListParam(type: 'ssid', id: ssid);
  }

  GetRoomListParam fillGetAllowedRoomsOfDevice(int deviceId) {
    return GetRoomListParam(type: 'device', id: '$deviceId');
  }

  Future<void> updateRoomList(
      String deviceType, String ssid, String deviceRoomId) async {
    roomListBottomBarShowLoader.value = true;
    await CommonRepo()
        .getRoomList(CommonRepo().fillGetAllRoomsOfSSID(ssid))
        .then((value) async {
      if (value != null) {
        getRoomsListForMoveToOtherRooms = value;

        if (deviceRoomId.isNotEmpty) {
          selectedRoom.value = getRoomsListForMoveToOtherRooms.listOfRoom!
              .firstWhere((element) => element.id == deviceRoomId);
        } else {
          selectedRoom.value =
              getRoomsListForMoveToOtherRooms.listOfRoom!.first;
        }
      }
      roomListBottomBarShowLoader.value = false;
    });

    // if (deviceType == 'wait') {
    //   await getRoomList(fillGetAllRoomsOfSSID(ssid), deviceRoomId);
    // } else if (deviceType == 'room') {
    //   await getRoomList(fillGetAllRoomsOfSSID(ssid), deviceRoomId);
    // } else {
    //   //All Connected Devices
    //   await getRoomList(fillGetAllRoomsOfSSID(ssid), deviceRoomId);
    // }
  }

  Future<void> updateWaitRoomList(
      String deviceType, int deviceId, String deviceRoomId) async {
    roomListBottomBarShowLoader.value = true;
    await CommonRepo()
        .getRoomList(CommonRepo().fillGetAllowedRoomsOfDevice(deviceId))
        .then((value) async {
      if (value != null) {
        getRoomsListForMoveToOtherRooms = value;

        if (deviceRoomId.isNotEmpty) {
          selectedRoom.value = getRoomsListForMoveToOtherRooms.listOfRoom!
              .firstWhere((element) => element.id == deviceRoomId);
        } else {
          selectedRoom.value =
              getRoomsListForMoveToOtherRooms.listOfRoom!.first;
        }
      }
      roomListBottomBarShowLoader.value = false;
    });

    // if (deviceType == 'wait') {
    //   await getRoomList(fillGetAllRoomsOfSSID(ssid), deviceRoomId);
    // } else if (deviceType == 'room') {
    //   await getRoomList(fillGetAllRoomsOfSSID(ssid), deviceRoomId);
    // } else {
    //   //All Connected Devices
    //   await getRoomList(fillGetAllRoomsOfSSID(ssid), deviceRoomId);
    // }
  }
  // Future<void> updateRoomList(
  //     String deviceType, int deviceId, String deviceRoomId) async {
  //   if (deviceType == 'wait') {
  //     await getRoomList(fillGetAllowedRoomsOfDevice(deviceId), deviceRoomId);
  //   } else if (deviceType == 'room') {
  //     await getRoomList(fillGetAllowedRoomsOfDevice(deviceId), deviceRoomId);
  //   } else {
  //     //All Connected Devices
  //     await getRoomList(fillGetAllowedRoomsOfDevice(deviceId), deviceRoomId);
  //   }
  // }

  Future<GetRoomListModel?> getRoomList(
      GetRoomListParam getRoomListParam, String currentRoomId) async {
    roomListBottomBarShowLoader.value = true;

    final connectivityResult = await (Connectivity().checkConnectivity());
    if (connectivityResult.contains(ConnectivityResult.none)) {
      constants.showSnackbar('Network Error', 'No internet access', 0);
      roomListBottomBarShowLoader.value = false;

      return null;
    }

    Map params = getRoomListParam.toJson();

    String url = AppConstants.baseUrlAsKey + EndPoints.roomListGetEndPoint;

    final response = await apiUtilsWithHeader.put(
        url: url, data: jsonEncode(params), firstTime: true);
    return response.fold((l) {
      roomListBottomBarShowLoader.value = false;

      return null;
    }, (r) {
      getRoomListModel = GetRoomListModel.fromJson(r.data);

      if (getRoomListParam.type == 'none') {
        addAllRoomInLists();
      }

      // if (getRoomListParam.type == 'ssid') {
      //   if (getRoomListParam.id == '0') {
      //     //Admin Wifi
      //     adminRoomListModel.clear();
      //     for (var room in getRoomListModel.listOfRoom!) {
      //       adminRoomListModel.add(room);
      //     }
      //   } else if (getRoomListParam.id == '1') {
      //     //Managed Wifi
      //     managedRoomListModel.clear();
      //     for (var room in getRoomListModel.listOfRoom!) {
      //       managedRoomListModel.add(room);
      //     }
      //   } else if (getRoomListParam.id == '2') {
      //     //Guest Wifi
      //     guestRoomListModel.clear();
      //     for (var room in getRoomListModel.listOfRoom!) {
      //       guestRoomListModel.add(room);
      //     }
      //   } else if (getRoomListParam.id == '3') {
      //     //Shared Wifi
      //     sharedRoomListModel.clear();
      //     for (var room in getRoomListModel.listOfRoom!) {
      //       sharedRoomListModel.add(room);
      //     }
      //   } else {}
      // } else {
      //   if (getRoomListParam.type == 'none') {
      //     allRoomsListModel.clear();
      //     for (var room in getRoomListModel.listOfRoom!) {
      //       allRoomsListModel.add(room);
      //     }
      //   }
      //   }
      //   //Ethernet Lan
      // if (getRoomListParam.type == 'none') {
      //   for (var room in getRoomListModel.listOfRoom!) {
      //     if (room.id == '0') {
      //       ethernetLanRoomListModel.clear();
      //       ethernetLanRoomListModel.add(room);
      //       break;
      //     }
      //   }
      // }
      // // }

      if (currentRoomId.isNotEmpty) {
        selectedRoom.value = getRoomListModel.listOfRoom!
            .firstWhere((element) => element.id == currentRoomId);
      } else {
        selectedRoom.value = getRoomListModel.listOfRoom!.first;
      }

      roomListBottomBarShowLoader.value = false;
      return getRoomListModel;
    });
  }

  SetDeviceLabelParam fillDeviceLabel(
      {required int deviceId, required String type, required String label}) {
    return SetDeviceLabelParam(
      id: deviceId.toString(),
      labelEncode: base64Encode(utf8.encode(label)),
    );
  }

  Future<StatusModel?> setDeviceLabel(
      {required SetDeviceLabelParam setDeviceLabelParam,
      required String type,
      required String currentRoomId}) async {
    showLoader.value = true;

    final connectivityResult = await (Connectivity().checkConnectivity());
    if (connectivityResult.contains(ConnectivityResult.none)) {
      constants.showSnackbar('Network Error', 'No internet access', 0);
      showLoader.value = false;

      return null;
    }

    Map params = setDeviceLabelParam.toJson();

    String url = AppConstants.baseUrlAsKey + EndPoints.setLabelEndPoint;

    final response = await apiUtilsWithHeader.put(
        url: url, data: jsonEncode(params), firstTime: true);
    return response.fold((l) {
      showLoader.value = false;

      return null;
    }, (r) async {
      var statusModel = StatusModel.fromJson(r.data);

      constants.showSnackbar(
          'Device Status', 'Successfully changed device label', 1);

      showLoader.value = false;

      return statusModel;
    });
  }

  SetDeviceAdminParam fillSetDeviceAdmin(int deviceId) {
    return SetDeviceAdminParam(id: deviceId.toString());
  }

  Future<StatusModel?> setDeviceAdmin(
      SetDeviceAdminParam setDeviceAdminParam) async {
    showLoader.value = true;

    final connectivityResult = await (Connectivity().checkConnectivity());
    if (connectivityResult.contains(ConnectivityResult.none)) {
      constants.showSnackbar('Network Error', 'No internet access', 0);
      showLoader.value = false;

      return null;
    }

    Map params = setDeviceAdminParam.toJson();

    String url = AppConstants.baseUrlAsKey + EndPoints.adminSetEndPoint;

    final response = await apiUtilsWithHeader.put(
        url: url, data: jsonEncode(params), firstTime: true);
    return response.fold((l) {
      showLoader.value = false;

      return null;
    }, (r) async {
      var statusModel = StatusModel.fromJson(r.data);

      await getAllDevices(deviceId: int.parse(setDeviceAdminParam.id));

      constants.showSnackbar(
          'Admin Status', 'Successfully made admin device', 1);

      showLoader.value = false;

      return statusModel;
    });
  }
}
