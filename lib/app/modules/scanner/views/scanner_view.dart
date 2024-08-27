import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:mobile_scanner/mobile_scanner.dart';

import '../../../../gen/assets.gen.dart';
import '../controllers/scanner_controller.dart';

class ScannerView extends GetView<ScannerController> {
  const ScannerView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Mobile Scanner')),
      body: Obx(() {
        if (!controller.isWifiConnected.value) {
          return MobileScanner(
            // fit: BoxFit.contain,
            controller: controller.mobileScannerController,
            scanWindow: Rect.fromCenter(
                center: Offset(Get.width / 2, Get.height / 2),
                width: 200,
                height: 200),
            overlayBuilder: ((context, constraints) {
              return AnimatedBuilder(
                  animation: controller.animationController,
                  builder: (context, child) {
                    return Transform.scale(
                      scale: controller.animation
                          .value, // Adjust the Y offset for the bounce
                      child: Container(
                        width: 200, // Adjust the width and height as needed
                        height: 200,
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.white, width: 2.0),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.2),
                              blurRadius: 5.0,
                            ),
                          ],
                          borderRadius: BorderRadius.circular(12.0),
                        ),
                      ),
                    );
                  });
            }),
            onDetect: (capture) {
              // WIFI:T:WPA2;S:$ssid;P:password;H:;;

              final List<Barcode> barcodes = capture.barcodes;
              // final Uint8List? image = capture.image;

              for (final barcode in barcodes) {
                if (barcode.wifi != null) {
                  controller.connectToWifiNetwork(
                      barcode.wifi!.ssid!, barcode.wifi!.password!);
                }
              }
            },
          );
        } else {
          return SizedBox(
            height: Get.height,
            width: Get.width,
            child: ColoredBox(
              color: Colors.white,
              child: Column(
                children: [
                  Lottie.asset(Assets.animations.loading),
                  const SizedBox(height: 8),
                  const Text(
                    'Connecting to WiFi Router',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.w300),
                  ),
                ],
              ),
            ),
          );
        }
      }),
    );
  }
}
