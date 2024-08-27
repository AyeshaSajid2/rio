import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:usama/app/data/params/settings/set_wan_access_param.dart';
import 'package:usama/app/routes/app_pages.dart';
import 'package:usama/core/utils/helpers/amz_storage.dart';
import 'package:usama/core/utils/helpers/askey_storage.dart';

import '../../../../core/components/dialogs/dialog.dart';
import '../../../../core/components/widgets/rio_app_bar.dart';
import '../../../../core/theme/colors.dart';
import '../../../../gen/assets.gen.dart';
import '../controllers/settings_controller.dart';
import 'timezone.dart';

class SettingsView extends GetView<SettingsController> {
  const SettingsView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: const RioAppBar(
        titleText: 'Settings',
        backOn: false,
      ),
      body: Obx(() {
        return Stack(
          children: [
            SingleChildScrollView(
              child: Column(
                children: [
                  AppCardView(
                    heading: 'GENERAL',
                    listOfCardTiles: [
                      AppCardTile(
                        title: 'Wireless Networks',
                        onTap: () {
                          Get.toNamed(Routes.WIRELESS_NETWORK);
                        },
                      ),
                      AppCardTile(
                        title: 'Wireless Mesh',
                        onTap: () {
                          Get.toNamed(Routes.MESH);
                        },
                      ),
                      AppCardTile(
                        title: 'Connection Speed',
                        onTap: () {
                          Get.toNamed(Routes.SPEED_TEST);
                        },
                        isLast: true,
                      ),
                    ],
                  ),
                  AppCardView(
                    heading: 'SYSTEM',
                    listOfCardTiles: [
                      AppCardTile(
                        title: 'WAN Access Management',
                        onTap: () {},
                        isWanAccess: true,
                        value: '',
                        trailing: CupertinoSwitch(
                            activeColor: AppColors.primary,
                            value: controller.isWanAccessOn.value,
                            onChanged: (statusValue) {
                              Dialogs.showDialogWithTwoButtonsMsg(
                                  context: context,
                                  title: 'Remote Management',
                                  subtitle:
                                      'Using this option you will be able to manage the router using the Rio Mobile App remotely over the internet.\nThe feature is disabled by default.\nAre you sure to ${statusValue ? 'enable' : 'disable'} WAN access?',
                                  button1Func: () {
                                    Get.back();
                                  },
                                  button2Func: () {
                                    Get.back();
                                    controller
                                        .setWanAccessStatus(
                                            SetWanAccessStatusParam(
                                                status: statusValue
                                                    ? 'enable'
                                                    : 'disable'))
                                        .then((value) {
                                      if (value != null) {
                                        controller.callGetWanAccess();
                                        controller.isWanAccessOn.value =
                                            statusValue;
                                      }
                                    });
                                  });
                            }),
                      ),
                      AppCardTile(
                        title: 'Device Administration',
                        onTap: () {
                          Get.toNamed(Routes.DEVICES, arguments: {
                            'pageTitle': 'Device Administration',
                            'deviceType':
                                controller.dashboardController.allDeviceType,
                          });
                        },
                      ),
                      AppCardTile(
                        title: 'Change Admin Password',
                        onTap: () {
                          Get.toNamed(Routes.CHANGE_ADMIN_PASSWORD,
                              arguments: false);
                        },
                      ),
                      AppCardTile(
                        title: 'Firmware Version',
                        value:
                            controller.getSystemSettingModel.firmwareVersion ??
                                '',
                        // onTap: () {
                        //   Get.toNamed(Routes.FIRMWARE_UPDATE);
                        // },
                      ),
                      // AppCardTile(
                      //   title: 'Backup Configuration',
                      //   onTap: () {
                      //     Get.toNamed(Routes.BACK_UP);
                      //   },
                      // ),
                      AppCardTile(
                        title: 'Reboot',
                        onTap: () {
                          // Get.offAllNamed(Routes.PROGRESS,
                          //     arguments: {'isReboot': false, 'Minutes': 2});
                          Dialogs.showDialogWithTwoButtonsMsg(
                              context: context,
                              title: 'Boot Router',
                              subtitle: 'Do you want to boot the Router?',
                              button1Func: () {
                                Get.back();
                              },
                              button2Func: () {
                                controller.rebootRouter();
                              });
                        },
                      ),
                      AppCardTile(
                        title: 'Reset to Factory Defaults',
                        onTap: () {
                          Dialogs.showDialogWithTwoButtonsMsg(
                              context: context,
                              title: 'Reset Router',
                              subtitle:
                                  'Do you want to reset the router to factory default settings?',
                              button1Func: () {
                                Get.back();
                              },
                              button2Func: () {
                                controller.factoryReset();
                              });
                        },
                      ),
                      AppCardTile(
                        title: 'Timezone',
                        onTap: () {
                          Get.to(() => const TimeZonePage());
                        },
                      ),
                      AppCardTile(
                        title: 'Activity Log',
                        onTap: () {
                          Get.toNamed(Routes.ACTIVITY_LOG);
                        },
                      ),
                      AppCardTile(
                        title: 'Router Setup',
                        onTap: () {
                          Get.toNamed(Routes.ROUTER_SETUP);
                        },
                      ),
                      AppCardTile(
                        title: 'Reset App',
                        onTap: () {
                          Dialogs.showDialogWithTwoButtonsMsg(
                              context: context,
                              title: 'Reset App',
                              subtitle:
                                  'This action takes you to the Router Setup Flow. Please click on YES button to confirm.',
                              button1Func: () {
                                Get.back();
                              },
                              button2Func: () {
                                Get.back();
                                asKeyStorage.saveAsKeyResetStatus(true);
                                Get.offAllNamed(Routes.SPLASH);
                              });
                        },
                      ),
                      AppCardTile(
                        title: 'Logout',
                        onTap: () {
                          Dialogs.showDialogWithTwoButtonsMsg(
                              context: context,
                              title: 'Logout',
                              subtitle: 'Are you sure to logout?',
                              button1Func: () {
                                Get.back();
                              },
                              button2Func: () {
                                Get.back();
                                amzStorage.saveAMZLoggedIn(false);
                                asKeyStorage.saveAsKeyLoggedIn(false);
                                // Get.offAllNamed(Routes.ADMIN_LOGIN,
                                //     arguments: false);
                                Get.offAllNamed(Routes.SIGN_IN,
                                    arguments: false);
                              });
                        },
                        isLast: true,
                      ),
                    ],
                  ),
                  SizedBox(height: Get.height * 0.04),
                ],
              ),
            ),
            if (controller.showLoader.value)
              Positioned(
                child: SizedBox(
                  height: Get.height,
                  width: Get.width,
                  child: ColoredBox(
                    color: Colors.black12,
                    child: Lottie.asset(Assets.animations.loading),
                  ),
                ),
              ),
          ],
        );
      }),
    );
  }
}

class AppCardView extends StatelessWidget {
  const AppCardView({
    super.key,
    required this.heading,
    required this.listOfCardTiles,
  });

  final String heading;
  final List<AppCardTile> listOfCardTiles;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(
            left: 24.0,
            top: 16.0,
          ),
          child: Text(
            heading,
            style: const TextStyle(color: AppColors.cardTitleTextColor),
          ),
        ),
        Container(
          width: Get.width,
          margin: const EdgeInsets.only(
            left: 16,
            right: 16,
            top: 8,
          ),
          padding: EdgeInsets.only(left: 12.h),
          decoration: BoxDecoration(
            color: AppColors.white,
            borderRadius: BorderRadius.circular(6),
          ),
          child: Column(
            children: listOfCardTiles,
          ),
        ),
      ],
    );
  }
}

class AppCardTile extends StatelessWidget {
  const AppCardTile({
    super.key,
    this.onTap,
    required this.title,
    this.value,
    this.isLast = false,
    this.isWanAccess,
    this.trailing,
  });

  final void Function()? onTap;
  final String title;
  final String? value;
  final bool isLast;
  final bool? isWanAccess;
  final Widget? trailing;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        height: 55,
        padding: const EdgeInsets.only(top: 12, bottom: 12),
        decoration: BoxDecoration(
          border: isLast
              ? null
              : Border(
                  bottom: BorderSide(
                    width: 0.5,
                    color: AppColors.black.withOpacity(0.2),
                  ),
                ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              title,
              style: const TextStyle(
                  fontSize: 17,
                  fontWeight: FontWeight.w300,
                  color: AppColors.appBlack),
            ),
            value == null
                ? const Padding(
                    padding: EdgeInsets.only(right: 12.0),
                    child: Icon(Icons.chevron_right,
                        size: 32, color: AppColors.appGrabber),
                  )
                : isWanAccess == null
                    ? Padding(
                        padding: const EdgeInsets.only(right: 12.0),
                        child: Text(
                          value!,
                          style: const TextStyle(
                              fontSize: 17,
                              fontWeight: FontWeight.w400,
                              color: AppColors.appGrey),
                        ),
                      )
                    : trailing!,
          ],
        ),
      ),
    );
  }
}
