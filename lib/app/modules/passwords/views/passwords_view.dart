import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../../../../../core/components/widgets/rio_app_bar.dart';
import '../../../../../core/theme/colors.dart';
import '../../../routes/app_pages.dart';

import '../controllers/passwords_controller.dart';

class PasswordsView extends GetView<PasswordsController> {
  const PasswordsView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: const RioAppBar(
        titleText: 'Share Passwords',
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 24.0),
        child: ListView.builder(
            itemCount: controller.getWifiListModel.listOfWifi!.length,
            shrinkWrap: true,
            itemBuilder: (context, index) {
              return Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: Container(
                  padding: const EdgeInsets.all(16.0),
                  decoration: const BoxDecoration(
                    color: AppColors.white,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'SSID',
                        style: TextStyle(
                          color: AppColors.textGrey,
                          fontSize: 12,
                          fontWeight: FontWeight.normal,
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(controller
                              .getWifiListModel.listOfWifi![index].name!),
                          InkWell(
                            onTap: () {
                              Get.toNamed(Routes.SHARE_PASSWORD, arguments: {
                                'pageTitle': controller
                                    .getWifiListModel.listOfWifi![index].name!,
                                'ssid': controller
                                    .getWifiListModel.listOfWifi![index].name!,
                                'password': controller.getWifiListModel
                                    .listOfWifi![index].password!
                              });
                            },
                            child: const Row(
                              children: [
                                Text(
                                  'Share WiFi Password',
                                  style: TextStyle(
                                    fontSize: 12,
                                    fontWeight: FontWeight.w300,
                                  ),
                                ),
                                SizedBox(width: 4),
                                Icon(
                                  Icons.share_outlined,
                                  color: AppColors.primary,
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      const Divider(
                        thickness: 1,
                        height: 8,
                      ),
                      const SizedBox(height: 8),
                      const Text(
                        'Rooms',
                        style: TextStyle(
                          fontSize: 12,
                          color: AppColors.textGrey,
                        ),
                      ),

                      //
                      if (controller.allWifiRoomsList.isNotEmpty &&
                          ((controller.getWifiListModel.listOfWifi!.length) >
                              index) &&
                          controller.allWifiRoomsList.isNotEmpty)
                        ListView.builder(
                            itemCount:
                                controller.allWifiRoomsList[index].length,
                            shrinkWrap: true,
                            padding: EdgeInsets.zero,
                            physics: const NeverScrollableScrollPhysics(),
                            itemBuilder: (context, i) {
                              return
                                  // (controller.allWifiRoomsList[i]
                                  //             .ssidId! !=
                                  //         index.toString())
                                  //     ? Container()
                                  // :
                                  Padding(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 4.0),
                                child: Column(
                                  children: [
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(controller
                                            .allWifiRoomsList[index][i].name!),
                                        InkWell(
                                          onTap: () {
                                            Get.toNamed(Routes.SHARE_PASSWORD,
                                                arguments: {
                                                  'pageTitle': controller
                                                      .allWifiRoomsList[index]
                                                          [i]
                                                      .name!,
                                                  'ssid': controller
                                                      .getWifiListModel
                                                      .listOfWifi![index]
                                                      .name!,
                                                  'password': controller
                                                      .allWifiRoomsList[index]
                                                          [i]
                                                      .password!
                                                });
                                          },
                                          child: const Row(
                                            children: [
                                              Text(
                                                'Share Password',
                                                style: TextStyle(
                                                  fontSize: 12,
                                                  fontWeight: FontWeight.w300,
                                                ),
                                              ),
                                              SizedBox(width: 4),
                                              Icon(
                                                Icons.share_outlined,
                                                color: AppColors.primary,
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                    if (controller.allWifiRoomsList[index]
                                                .length -
                                            1 !=
                                        i)
                                      const Divider(
                                        thickness: 1,
                                        height: 8,
                                      ),
                                  ],
                                ),
                              );
                            }),
                    ],
                  ),
                ),
              );
            }),
      ),
    );
  }
}
