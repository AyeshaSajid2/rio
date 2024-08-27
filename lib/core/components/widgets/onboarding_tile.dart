import 'package:flutter/material.dart';
import 'package:get/get.dart';

class OnboardingTile extends StatelessWidget {
  final Color color;
  const OnboardingTile({
    super.key,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 8,
      width: Get.width * 0.15,
      margin: const EdgeInsets.symmetric(horizontal: 4.0),
      color: color,
    );
  }
}
