import 'package:get/get.dart';
import 'package:webview_flutter/webview_flutter.dart';

class CustomerSupportController extends GetxController {
  late WebViewController webViewController;

  RxBool pageOpened = true.obs;

  @override
  void onInit() {
    webViewController = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..enableZoom(true)
      ..setNavigationDelegate(
        NavigationDelegate(
          onProgress: (int progress) {
            // Update loading bar.
            pageOpened.value = false;
          },
          onPageStarted: (String url) {
            pageOpened.value = false;
          },
          onPageFinished: (String url) {
            // saveLastSpeedTestDate();
            pageOpened.value = true;
          },
          onWebResourceError: (WebResourceError error) {
            // print(error.description);
          },
          onNavigationRequest: (NavigationRequest request) {
            if (request.url.startsWith('https://www.youtube.com/')) {
              return NavigationDecision.prevent;
            }
            return NavigationDecision.navigate;
          },
        ),
      )
      ..loadRequest(Uri.parse(
          'https://rio-chatbot.s3.us-east-2.amazonaws.com/chatbot-widget.html'));
//       ..loadRequest(
//         Uri.dataFromString('''
// <!DOCTYPE html>
// <html>
// <head>
//     <meta name="viewport" content="width=device-width, initial-scale=1.0"></head>
// <body>

// <!-- Enegel.ai bot widget begin -->
//     <link href="https://unpkg.com/@enegelai/bot-widget/dist/enegelaibot.css" rel="stylesheet">
//     <script src="https://unpkg.com/@enegelai/bot-widget/dist/enegelaibot.umd.js" type="text/javascript" async></script>
//     <style>
//         enegelai-bot {
//             --enegelai-bot-max-height: 200px;
//             --enegelai-bot-height-top-margin: 1px;
//         }
//     </style>
//     <enegelai-bot
//             name=""
//             url="bot-service.enegel.ai"
//             org-id="rio"
//             bot-id="1vogjoh4ve"
//             logo-url="https://riorouter.com/cdn/shop/files/rio-logo_280x.png"

//     >
//     </enegelai-bot>
//     <!-- Enegel.ai bot widget end -->

// </body>
// </html>
// ''', mimeType: 'text/html'),
//       );
    super.onInit();
  }

  // @override
  // void onReady() {
  //   super.onReady();
  // }

  // @override
  // void onClose() {
  //   super.onClose();
  // }
}
