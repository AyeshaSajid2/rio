import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

import '../../theme/colors.dart';

class AppPopUpMenu<T> extends StatelessWidget {
  const AppPopUpMenu({
    super.key,
    required this.listOfPopupMenuItems,
    this.onSelected,
    this.child = const Icon(
      Icons.more_vert,
      color: AppColors.black,
    ),
  });

  final List<PopupMenuEntry<T>> listOfPopupMenuItems;
  final void Function(T)? onSelected;
  final Widget? child;

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton(
      padding: EdgeInsets.zero,
      position: PopupMenuPosition.over,
      constraints: BoxConstraints(
        minWidth: Get.width / 1.5,
        maxWidth: Get.width / 1.25,
      ),
      color: AppColors.appBlack,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      itemBuilder: (_) {
        return listOfPopupMenuItems;
      },
      onSelected: onSelected,
      child: child,
    );
  }
}

class AppPopupMenuItem {
  static PopupMenuItem item({
    required String menuText,
    required String svgPath,
  }) {
    return PopupMenuItem<String>(
      value: menuText,
      padding: EdgeInsets.zero,
      child: Container(
        alignment: Alignment.center,
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              menuText,
              style: TextStyle(
                  fontSize: 16.sp,
                  color: AppColors.white,
                  fontWeight: FontWeight.w400),
              textAlign: TextAlign.center,
            ),
            svgPath != '' ? SvgPicture.asset(svgPath) : const SizedBox(),
          ],
        ),
      ),
    );
  }
}

class AppPopUpVpnMenu<T> extends StatelessWidget {
  const AppPopUpVpnMenu({
    super.key,
    required this.listOfPopupMenuItems,
    this.onSelected,
    this.child = const Icon(
      Icons.more_vert,
      color: AppColors.black,
    ),
  });

  final List<PopupMenuEntry<T>> listOfPopupMenuItems;
  final void Function(T)? onSelected;
  final Widget? child;

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton(
      padding: EdgeInsets.zero,
      position: PopupMenuPosition.over,
      constraints: BoxConstraints(
        minWidth: Get.width / 1.3,
        maxWidth: Get.width / 1.1,
      ),
      color: AppColors.appBlack,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      itemBuilder: (_) {
        return listOfPopupMenuItems;
      },
      onSelected: onSelected,
      child: child,
    );
  }
}

class AppPopupVpnMenuItem {
  static PopupMenuItem item({
    required String vpnName,
    required String country,
    required String city,
  }) {
    return PopupMenuItem<String>(
      value: vpnName,
      padding: EdgeInsets.zero,
      child: Container(
        alignment: Alignment.center,
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              vpnName,
              style: TextStyle(
                  fontSize: 16.sp,
                  color: AppColors.white,
                  fontWeight: FontWeight.w400),
              textAlign: TextAlign.center,
            ),
            Text(
              city,
              style: TextStyle(
                  fontSize: 16.sp,
                  color: AppColors.white,
                  fontWeight: FontWeight.w400),
              textAlign: TextAlign.center,
            ),
            Text(
              country,
              style: TextStyle(
                  fontSize: 16.sp,
                  color: AppColors.white,
                  fontWeight: FontWeight.w400),
              textAlign: TextAlign.center,
            ),
            const Divider(
              thickness: 1.5,
              color: AppColors.white,
            )
          ],
        ),
      ),
    );
  }
}
