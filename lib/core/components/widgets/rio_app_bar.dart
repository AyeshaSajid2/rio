import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../theme/colors.dart';

class RioAppBar extends StatelessWidget implements PreferredSizeWidget {
  @override
  final Size preferredSize;
  final String titleText;
  // final String actionIconPath;
  // final void Function()? onTap;
  final bool backOn;
  final bool refresh;
  final Rx<String>? refreshText;
  final List<Widget>? actions;
  // final String? actionButtonText;

  const RioAppBar({
    super.key,
    required this.titleText,
    // this.onTap,
    // this.actionIconPath = 'assets/svgs/add.svg',
    this.backOn = true,
    this.refresh = false,
    this.refreshText,
    this.actions,
  }) : preferredSize = const Size.fromHeight(56.0);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: AppColors.white.withOpacity(0.75),
      shape: Border(
          bottom: BorderSide(
              width: 0.3333, color: AppColors.black.withOpacity(0.33))),
      title: refresh
          ? Obx(() {
              return SizedBox(
                  width: (refreshText!.value.length * 10.w) > Get.width * 0.75
                      ? Get.width * 0.75
                      : (refreshText!.value.length * 10.w),
                  // width: 120,
                  height: 24.h,
                  child: FittedBox(child: Text(refreshText!.value.trim())));
            })
          : SizedBox(
              // width: (titleText.length * 10.25.w) > Get.width * 0.75
              //     ? Get.width * 0.75
              //     : (titleText.length * 10.25.w),
              child: FittedBox(
                child: Text(
                  titleText,
                ),
              ),
            ),
      centerTitle: true,
      leading: backOn
          ? IconButton(
              icon: Icon(
                Platform.isIOS ? Icons.arrow_back_ios : Icons.arrow_back,
              ),
              onPressed: () => Navigator.of(context).pop(),
            )
          : null,
      actions: actions,
      // [
      //   if (onTap != null && actionButtonText == null)
      //     IconButton(
      //       icon: SvgPicture.asset(actionIconPath),
      //       onPressed: onTap,
      //     ),
      //   if (onTap != null && actionButtonText != null) ...[
      //     InkWell(
      //       onTap: onTap,
      //       child: Padding(
      //         padding: const EdgeInsets.all(4.0),
      //         child: Row(
      //           children: [
      //             Text(actionButtonText!),
      //             Padding(
      //               padding: const EdgeInsets.only(left: 4.0),
      //               child: SvgPicture.asset(actionIconPath),
      //             ),
      //           ],
      //         ),
      //       ),
      //     ),
      //   ]
      // ],
      automaticallyImplyLeading: true,
    );
  }
}
