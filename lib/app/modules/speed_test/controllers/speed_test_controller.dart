import 'dart:developer';

import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:usama/core/extensions/imports.dart';
import 'package:webview_flutter/webview_flutter.dart';

import '../../dashboard/controllers/dashboard_controller.dart';

class SpeedTestController extends GetxController {
  RxBool isStarted = false.obs;

  DashboardController dashboardController = Get.find<DashboardController>();

  RxDouble downloadSpeed = 0.0.obs;
  RxDouble uploadSpeed = 0.0.obs;

  int currentCycle = 1;
  List<double> listOfDownloadValues = [];
  List<double> listOfUploadValues = [];
  RxString selectedServer = 'Server C'.obs; // Default server
  final List<String> servers = [
    'Server A',
    'Server B',
    'Server C',
    'Server F',
    'Server E',
  ];

  Dio dio = Dio();

  late WebViewController webViewController;

  RxString lastSpeedTestDate = DateTime.now().dayWithMonth.obs;

  final box = GetStorage('AsKey');

  RxBool pageOpened = true.obs;

  @override
  void onInit() {
    //

    webViewController = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setNavigationDelegate(
        NavigationDelegate(
          onProgress: (int progress) {
            // Update loading bar.
          },
          onPageStarted: (String url) {
            pageOpened.value = false;
          },
          onPageFinished: (String url) {
            // saveLastSpeedTestDate();
            pageOpened.value = true;
          },
          onWebResourceError: (WebResourceError error) {
            pageOpened.value = true;
          },
          onNavigationRequest: (NavigationRequest request) {
            if (request.url.startsWith('https://www.youtube.com/')) {
              return NavigationDecision.prevent;
            }
            return NavigationDecision.navigate;
          },
        ),
      )
      ..loadRequest(
        Uri.dataFromString('''<html>
            <head>
            <meta name="viewport" content="width=device-width, initial-scale=1.0"></head>
            <body>
              <iframe style="border:none;position:absolute;top:0;left:0;width:100%;height:100%;min-height:360px;border:none;overflow:hidden !important;" src="https://openspeedtest.com/speedtest">
              </iframe>
            </body>
            </html>''', mimeType: 'text/html'),
      );
    // ..loadRequest(Uri.parse('https://openspeedtest.com/speedtest'));
    // ..loadRequest(Uri.parse('https://pcmag.speedtestcustom.com'));
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

  // void saveLastSpeedTestDate() {
  //   box.write('LastSpeedTestDate', DateTime.now().dayWithMonth);
  //   dashboardController.lastSpeedTestDate.value = DateTime.now().dayWithMonth;
  // }

  Future<void> runSpeedTest() async {
    final selectedServerUrl = getServerUrl(selectedServer.value);

    try {
      final downloadStartTime = DateTime.now();
      final downloadResponse = await dio.get(selectedServerUrl);
      final downloadEndTime = DateTime.now();

      final downloadTime =
          downloadEndTime.difference(downloadStartTime).inMilliseconds;
      final downloadContentLength = downloadResponse.data.length;

      // downloadSpeed.value = (downloadContentLength / downloadTime) *
      //     1000; // Speed in bytes per second
      downloadSpeed.value =
          (downloadContentLength * 8 * 1000 * 1000) / ((downloadTime * 1000));

      // (time*1000) /(bytes * 8) bps
      // (time*1000)/(bytes* 8) /(1024*1024)

      // Upload Speed Test
      final uploadStartTime = DateTime.now();
      final uploadResponse =
          await dio.post(selectedServerUrl, data: {'dummy': 'data'});
      final uploadEndTime = DateTime.now();

      final uploadTime =
          uploadEndTime.difference(uploadStartTime).inMilliseconds;
      final uploadContentLength = uploadResponse.data.length;

      uploadSpeed.value = (uploadContentLength / uploadTime) *
          1000; // Speed in bytes per second
    } catch (e) {
      log('Error: $e');
    }
  }

  String getServerUrl(String serverName) {
    // Replace with the actual URLs of your speed test servers
    switch (serverName) {
      case 'Server A':
        return 'http://www.speedtest.net/speedtest-servers.php';
      case 'Server B':
        return 'http://speedtest.ftp.otenet.gr/files/test1Mb.db';
      case 'Server C':
        return 'http://speedtest.ftp.otenet.gr/';
      case 'Server F':
        return 'https://fast.com';
      case 'Server E':
        return 'https://fal.openspeedtest.com/upload';
      default:
        return 'http://www.speedtest.net/speedtest-servers.php';
    }
  }

  //  {"ServerName":"Home", "Download":"//open.cachefly.net/downloading", "Upload":"//fal.openspeedtest.com/upload", "ServerIcon":"DefaultIcon"}
}
