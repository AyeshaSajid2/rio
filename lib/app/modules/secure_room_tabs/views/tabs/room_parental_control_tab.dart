import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:usama/core/utils/helpers/common_func.dart';

import '../../../../../core/components/dialogs/dialog.dart';
import '../../../../../core/components/widgets/app_pop_up_menu.dart';
import '../../../../../core/components/widgets/app_text_field.dart';
import '../../../../../core/theme/colors.dart';
import '../../../../../gen/assets.gen.dart';
import '../../../../data/models/url/get_allowed_url_list_model.dart';
import '../../../../data/params/rooms/get_room_param.dart';
import '../../controllers/secure_room_tabs_controller.dart';

class RoomParentalControlTabView extends GetView<SecureRoomTabsController> {
  const RoomParentalControlTabView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      backgroundColor: AppColors.background,
      body: SingleChildScrollView(
        child: Obx(() {
          return Stack(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top: 24),
                      child: SizedBox(
                          width: Get.width,
                          child: Obx(() {
                            return ListTile(
                              title: const Text('Enable Parental Control'),
                              trailing: CupertinoSwitch(
                                  activeColor: AppColors.primary,
                                  value: controller.enableParentControl.value,
                                  onChanged: (value) {
                                    Dialogs.showDialogWithTwoButtonsMsg(
                                        context: context,
                                        title: 'Parental Control',
                                        subtitle:
                                            'Are you sure to ${value ? 'enable' : 'disable'} parental control on this room?',
                                        button1Func: () {
                                          Get.back();
                                        },
                                        button2Func: () {
                                          controller.enableParentControl.value =
                                              value;
                                          Get.back();
                                          controller
                                              .setRoom(controller
                                                  .fillSetRoomOnlyModifyParentalControl())
                                              .then((value) {
                                            if (value != null) {
                                              controller.getRoom(GetRoomParam(
                                                  id: controller
                                                      .roomListItem.id!));
                                              //     .then((value) => controller
                                              //         .getRoomList(controller
                                              //             .fillGetAllRooms()))
                                              //     .then((value) {
                                              //   if (value != null) {
                                              //     controller
                                              //             .secureRoomController
                                              //             .getRoomListModel =
                                              //         value;
                                              //   }
                                              // });
                                            }
                                          });
                                        });
                                  }),
                              tileColor: AppColors.white,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(6)),
                            );
                          })),
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: 30.h),
                      child: Text(
                        'Allowed Websites',
                        style: TextStyle(
                            fontSize: 18.sp,
                            fontWeight: FontWeight.w400,
                            color: AppColors.appBlack),
                      ),
                    ),
                    if (controller.getAllowedUrlListModel.listOfAllowedUrls !=
                            null &&
                        controller.getAllowedUrlListModel.listOfAllowedUrls!
                            .isNotEmpty)
                      Container(
                        width: Get.width,
                        padding: EdgeInsets.all(12.h),
                        decoration: BoxDecoration(
                          color: AppColors.white,
                          borderRadius: BorderRadius.circular(6),
                        ),
                        child: ListView.builder(
                            itemCount: controller.getAllowedUrlListModel
                                .listOfAllowedUrls!.length,
                            shrinkWrap: true,
                            padding: EdgeInsets.zero,
                            physics: const NeverScrollableScrollPhysics(),
                            itemBuilder: (context, index) {
                              return AllowedAppsTile(
                                allowedUrlItem: controller
                                    .getAllowedUrlListModel
                                    .listOfAllowedUrls![index],
                                hideBottomBorder: (index + 1) ==
                                    controller.getAllowedUrlListModel
                                        .listOfAllowedUrls!.length,
                                urlIndex: index,
                              );
                            }),
                      ),
                    Padding(
                      padding: const EdgeInsets.only(top: 12),
                      child: Text(
                        'Add to allowed websites',
                        style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w400,
                            color: AppColors.black.withOpacity(0.5)),
                      ),
                    ),
                    Form(
                      key: controller.urlCheckKey,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 4.0),
                        child: AppTextField(
                          controller: controller.urlTEC,
                          obscureText: false,
                          keyboardType: TextInputType.url,
                          hintText: 'Enter URL',
                          suffixIcon: InkWell(
                              onTap: () {
                                if (controller.urlCheckKey.currentState!
                                    .validate()) {
                                  constants.dismissKeyboard(context);
                                  controller.listOfSelectedTimes
                                      .add('allow'.obs);
                                  Dialogs.showAllowedTimesDialog(
                                      allowedUrlItem: AllowedUrlItem(
                                          url: controller.urlTEC.text),
                                      urlIndex: controller
                                              .listOfSelectedTimes.length -
                                          1);
                                }
                              },
                              child: SvgPicture.asset(Assets.svgs.addSquare)),
                          errorMaxLength: 3,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please Enter URL';
                            } else if (!value.contains(
                                RegExp(r'^([a-zA-Z0-9\-\.]){1,63}$'))) {
                              return 'Can only contain letters, numbers, dash (-) and period (.) with maximum length of 63';
                            }
                            //  else if (!value.isURL) {
                            //   return 'Please Enter valid URL';
                            // }
                            else {
                              return null;
                            }
                          },
                        ),
                      ),
                    ),
                    SizedBox(height: Get.height * 0.08),
                  ],
                ),
              ),
              if (controller.showLoader.value)
                Positioned(
                  child: SizedBox(
                    height: Get.height - Get.statusBarHeight,
                    width: Get.width,
                    child: ColoredBox(
                      color: Colors.black38,
                      child: Lottie.asset(Assets.animations.loading),
                    ),
                  ),
                ),
            ],
          );
        }),
      ),
    );
  }
}

class AllowedAppsTile extends StatelessWidget {
  const AllowedAppsTile({
    super.key,
    required this.allowedUrlItem,
    this.hideBottomBorder = false,
    required this.urlIndex,
  });
  final AllowedUrlItem allowedUrlItem;
  final int urlIndex;

  final bool hideBottomBorder;

  @override
  Widget build(BuildContext context) {
    return Container(
      // height: Get.height * 0.05,
      padding: EdgeInsets.symmetric(horizontal: 2.h),
      decoration: hideBottomBorder
          ? null
          : BoxDecoration(
              border: Border(
                  bottom: BorderSide(color: AppColors.black.withOpacity(0.2)))),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            allowedUrlItem.url!,
            style: TextStyle(
                fontSize: 16.sp,
                fontWeight: FontWeight.w400,
                color: AppColors.appBlack),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: AppPopUpMenu(
              listOfPopupMenuItems: [
                AppPopupMenuItem.item(
                    menuText: 'Time Settings', svgPath: Assets.svgs.settings),
                // AppPopupMenuItem.item(
                //     menuText: 'Connected Devices',
                //     svgPath: Assets.svgs.connectedDevices),
              ],
              onSelected: (menuItemString) {
                //
                if (menuItemString == 'Time Settings') {
                  //
                  Dialogs.showAllowedTimesDialog(
                      allowedUrlItem: allowedUrlItem, urlIndex: urlIndex);
                }
                //  else if (menuItemString == 'Connected Devices') {
                //   Get.to(
                //     () => const ConnectedDevicesWithRoomView(),
                //   );
                // } else {}
              },
            ),
          ),
        ],
      ),
    );
  }
}
