import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:usama/app/modules/dashboard/views/rooms/admin_rooms_view.dart';
import 'package:usama/app/modules/dashboard/views/rooms/managed_rooms_view.dart';

import '../../dashboard/views/dashboard_view.dart';
import '../../settings/views/settings_view.dart';
import '../../vpn/views/vpn_view.dart';

class HomeController extends GetxController {
  final currentIndex = 0.obs;
  List<Widget> listOfBottomNavWidgets = [
    const DashboardView(),
    const AdminRoomsView(),
    const ManagedRoomsView(),
    const VpnView(),
    const SettingsView(),
  ];

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
}
