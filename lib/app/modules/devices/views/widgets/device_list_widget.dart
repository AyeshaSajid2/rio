import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:usama/app/modules/dashboard/controllers/dashboard_controller.dart';
import 'package:usama/app/routes/app_pages.dart';

import '../../../../data/models/device/get_device_list_model.dart';
import '../../../../../core/extensions/imports.dart';
import '../../../../../core/theme/colors.dart';

class DeviceListWidget extends StatelessWidget {
  const DeviceListWidget({
    super.key,
    required this.deviceList,
    required this.deviceType,
    required this.isDeviceAdministrator,
  });

  final RxList<DeviceListItem> deviceList;
  final String deviceType;
  final bool isDeviceAdministrator;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: Get.width,
      margin: const EdgeInsets.only(
        top: 24,
        bottom: 24,
        left: 16,
        right: 16,
      ),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(6),
      ),
      child: ListView.builder(
          itemCount: deviceList.length,
          shrinkWrap: true,
          padding: EdgeInsets.zero,
          physics: const NeverScrollableScrollPhysics(),
          itemBuilder: (context, index) {
            return (isDeviceAdministrator)
                ? deviceList[index].ssidId == '0'
                    ? DeviceListTile(
                        deviceListItem: deviceList[index],
                        deviceType: deviceType,
                        isDeviceAdministrator: isDeviceAdministrator,
                        isLast: deviceList.length - 1 == index,
                      )
                    : null
                : DeviceListTile(
                    deviceListItem: deviceList[index],
                    deviceType: deviceType,
                    isDeviceAdministrator: isDeviceAdministrator,
                    isLast: deviceList.length - 1 == index,
                  );
          }),
    );
  }
}

class DeviceListTile extends StatelessWidget {
  const DeviceListTile({
    super.key,
    required this.deviceListItem,
    required this.deviceType,
    required this.isDeviceAdministrator,
    required this.isLast,
  });

  final DeviceListItem deviceListItem;
  final String deviceType;
  final bool isDeviceAdministrator;
  final bool isLast;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          width: Get.width,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(
                  left: 8.0,
                  top: 8,
                  right: 8,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      flex: 3,
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            height: 12,
                            width: 12,
                            margin: const EdgeInsets.only(
                              right: 4,
                              top: 8,
                            ),
                            decoration: BoxDecoration(
                                color: deviceListItem.status!.toLowerCase() ==
                                        'online'
                                    ? AppColors.primary
                                    : AppColors.inActiveColor,
                                shape: BoxShape.circle),
                          ),
                          Expanded(
                            child: Text(
                              deviceListItem.labelEncode!.isNotEmpty
                                  ? utf8.decode(base64
                                      .decode(deviceListItem.labelEncode!))
                                  : deviceListItem.name!,
                              style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.w300,
                                  color: deviceListItem.name!.isNotEmpty
                                      ? AppColors.appBlack
                                      : AppColors.appGrey),
                              softWrap: true,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Expanded(
                      child: InkWell(
                        onTap: () {
                          DashboardController dashboardController =
                              Get.find<DashboardController>();
                          dashboardController.selectedDeviceListItem.value =
                              deviceListItem;
                          dashboardController.selectedDeviceType = deviceType;
                          dashboardController.isSelectedDeviceAdministrator =
                              isDeviceAdministrator;
                          Get.toNamed(
                            Routes.DEVICE_DETAILS,
                            // arguments: {
                            //   'DeviceListItem': deviceListItem,
                            //   'DeviceType': deviceType,
                            //   'isDeviceAdministrator': isDeviceAdministrator
                            // }
                          );
                        },
                        child: const SizedBox(
                          width: 100,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Text(
                                'Detail',
                                style: TextStyle(
                                    fontSize: 17,
                                    fontWeight: FontWeight.w400,
                                    color: AppColors.blue),
                              ),
                              Icon(
                                Icons.chevron_right_outlined,
                                size: 24,
                                color: AppColors.blue,
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(
                  left: 24.0,
                  bottom: 12,
                  right: 16,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: Text(
                        'Room: ${deviceListItem.roomName!}',
                        style: const TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w400,
                            color: AppColors.appGrey),
                      ),
                    ),
                    Text(
                      'Type: ${deviceListItem.role!}',
                      style: const TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w400,
                          color: AppColors.appGrey),
                      textAlign: TextAlign.end,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        if (!isLast)
          const Divider(
            height: 0,
            indent: 16,
          ),
      ],
    );
  }
}
