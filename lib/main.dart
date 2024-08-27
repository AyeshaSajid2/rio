import 'dart:async';
import 'dart:io';
import 'dart:ui';

import 'package:dio/io.dart';
import 'package:flex_color_scheme/flex_color_scheme.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_background_service/flutter_background_service.dart';
import 'package:flutter_background_service_android/flutter_background_service_android.dart';
import 'package:flutter_background_service_ios/flutter_background_service_ios.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:get/get.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:usama/app/data/params/admin_login/admin_login_param.dart';
import 'package:usama/core/constants/app_constants.dart';
import 'package:usama/core/utils/helpers/amz_storage.dart';
import 'package:usama/core/utils/helpers/askey_storage.dart';
import 'package:usama/core/utils/services/api/api_utils.dart';
import 'package:usama/core/utils/services/background_service/rio_background_services.dart';
import 'package:usama/core/utils/services/fcm/fcm_services.dart';

import 'app/routes/app_pages.dart';
import 'core/theme/colors.dart';
import 'core/theme/text_styles.dart';
import 'core/utils/services/api/api_utils_with_header.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  if (Platform.isAndroid) {
    await Permission.notification.isGranted.then((value) async {
      if (!value) {
        await Permission.notification.request();
      }
    });
    await Permission.locationWhenInUse.isGranted.then((value) async {
      if (!value) {
        await Permission.locationWhenInUse.request();
      }
    });
    await Permission.scheduleExactAlarm.isDenied.then((value) async {
      if (value) {
        await Permission.scheduleExactAlarm.request();
      }
    });
  }

  if (Platform.isIOS) {
    await Permission.notification.isGranted.then((notificationValue) async {
      if (!notificationValue) {
        await Permission.notification.request();
      }
    });
    await Permission.locationWhenInUse.isGranted.then((value) async {
      if (!value) {
        await Permission.locationWhenInUse.request();
      }
    });
  }

  await initializeService();

  await pinCertificatesAndInit();

  await amzStorage.initAMZStorage();
  await asKeyStorage.initAsKeyStorage();

  // asKeyStorage.saveAsKeyDeviceToken('JrtwsfT1zcmd4HJ6iCtSUkdrl1Hc0rhh');

  // asKeyStorage.saveAsKeyRouterSerialNumber('E1E9N000042');

  await SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
  runApp(
    ScreenUtilInit(
      designSize: const Size(375, 812),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child) {
        return GetMaterialApp(
          title: "RIO",

          defaultTransition: Transition.cupertino,
          themeMode: ThemeMode.light,
          theme: FlexThemeData.light(
              // useMaterial3: true,
              colors: FlexSchemeColor.from(
                primary: AppColors.primary,
                secondary: AppColors.blue,
              ),
              typography: Typography.material2021(
                platform: Platform.isAndroid
                    ? TargetPlatform.android
                    : TargetPlatform.iOS,
                tall: AppTS.getDarkTextTheme(),
              ),
              appBarBackground: AppColors.white,
              fontFamily: 'CircularStd'),
          debugShowCheckedModeBanner: false,
          initialRoute: AppPages.INITIAL,
          getPages: AppPages.routes,
          // defaultTransition: Transition.cupertino,
        );
      },
    ),
  );
}

////////////////////////////////////////////////
Future<void> pinCertificatesAndInit() async {
  // ByteData bundleCert = await PlatformAssetBundle()
  //     .load(Assets.certificates.cerCrtFiles.myCABundle);

  // ByteData cert4 = await PlatformAssetBundle()
  //     .load(Assets.certificates.cerCrtFiles.sTARRiorouterCom);

  // ByteData routerKey =
  //     await PlatformAssetBundle().load(Assets.certificates.starRiorouterComKey);
  SecurityContext securityContext = SecurityContext.defaultContext
    ..setTrustedCertificatesBytes(AppConstants.caBundleBytes)
    // ..setTrustedCertificatesBytes(bundleCert.buffer.asUint8List())
    ..useCertificateChainBytes(AppConstants.certificateBytes)
    // ..useCertificateChainBytes(cert4.buffer.asUint8List())
    ..usePrivateKeyBytes(AppConstants.keyBytes);
  // ..usePrivateKeyBytes(routerKey.buffer.asUint8List());

  (ApiUtils.dio.httpClientAdapter as IOHttpClientAdapter).createHttpClient =
      () {
    return HttpClient(context: securityContext);
  };
  (ApiUtilsWithHeader.dio.httpClientAdapter as IOHttpClientAdapter)
      .createHttpClient = () {
    return HttpClient(context: securityContext);
  };
}

///
Future<void> initializeService() async {
  final service = FlutterBackgroundService();

  // /// OPTIONAL, using custom notification channel id
  const AndroidNotificationChannel channel = AndroidNotificationChannel(
    'rio_notification', // id
    'Rio Router', // title
    // description:
    //     'This channel is used for important notifications.', // description
    importance: Importance.max,
    // importance must be at low or higher level
  );

  final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  if (Platform.isIOS || Platform.isAndroid) {
    await flutterLocalNotificationsPlugin.initialize(
      const InitializationSettings(
        iOS: DarwinInitializationSettings(),
        android: AndroidInitializationSettings("@mipmap/ic_notification"),
      ),
    );
  }

  await flutterLocalNotificationsPlugin
      .resolvePlatformSpecificImplementation<
          AndroidFlutterLocalNotificationsPlugin>()
      ?.createNotificationChannel(channel);

  await service.configure(
    androidConfiguration: AndroidConfiguration(
      // this will be executed when app is in foreground or background in separated isolate
      onStart: onStart,

      // auto start service
      autoStart: true,
      isForegroundMode: true,

      notificationChannelId: 'rio_notification',
      initialNotificationTitle: 'Rio Router',
      initialNotificationContent: 'Checking for New Connected Devices',
      foregroundServiceNotificationId: 111,
    ),
    iosConfiguration: IosConfiguration(
      // auto start service
      autoStart: true,

      // this will be executed when app is in foreground in separated isolate
      onForeground: onStart,

      // you have to enable background fetch capability on xcode project
      onBackground: onIosBackground,
    ),
  );

  service.startService();
}

// to ensure this is executed
// run app from xcode, then from xcode menu, select Simulate Background Fetch

@pragma('vm:entry-point')
Future<bool> onIosBackground(ServiceInstance service) async {
  WidgetsFlutterBinding.ensureInitialized();
  DartPluginRegistrant.ensureInitialized();

  await pinCertificatesAndInit();

  // await GetStorage.init('AsKey');

  await asKeyStorage.initAsKeyStorage();
  await amzStorage.initAMZStorage();

  // GetStorage box = GetStorage('AsKey');

  // if (box.read('AdminUserName') != null && box.read('AdminPassword') != null)
  if (asKeyStorage.getAsKeyAdminPassword().isNotEmpty) {
    RioBackgroundServices.putAdminLogin(
      AdminLoginParam(
        username: asKeyStorage.getAsKeyAdminUserName(),
        password: asKeyStorage.getAsKeyAdminPassword(),
        deviceToken: asKeyStorage.getAsKeyDeviceToken(),
        mailId: amzStorage.getAMZUserEmail(),
        rioPassword: '',
      ),
    ).then((value) {
      RioBackgroundServices.getDeviceList(
              RioBackgroundServices.fillGetWaitingDevices())
          .then((value) {
        value.fold((l) {
          return false;
        }, (r) {
          return true;
        });
      });
    });
  }

  return false;
}

@pragma('vm:entry-point')
void onStart(ServiceInstance service) async {
  // Only available for flutter 3.0.0 and later
  DartPluginRegistrant.ensureInitialized();

  await pinCertificatesAndInit();

  // For flutter prior to version 3.0.0
  // We have to register the plugin manually

  /// OPTIONAL when use custom notification
  // final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
  //     FlutterLocalNotificationsPlugin();

  // bool storageStarted = await GetStorage.init('AsKey');
  await asKeyStorage.initAsKeyStorage();
  await amzStorage.initAMZStorage();

  // GetStorage box = GetStorage('AsKey');

  if (service is AndroidServiceInstance) {
    if (await service.isForegroundService()) {
      FcmServices.showNotifications(
          'Rio Router', 'Checking for New Connected Devices', '');

      // bring to foreground
      Timer.periodic(const Duration(seconds: 20), (timer) async {
        // print("Notification Status: ${RioBackgroundServices.notificationShown}");
        if (RioBackgroundServices.notificationShown) {
          if (timer.tick % 16 == 0) {
            RioBackgroundServices.notificationShown = false;
          }
        } else {
          if (asKeyStorage.getAsKeyToken().isNotEmpty) {
            ApiUtilsWithHeader.token = asKeyStorage.getAsKeyToken();
            RioBackgroundServices.getDeviceList(
                RioBackgroundServices.fillGetWaitingDevices());
          }
        }
      });
    } else {
      // Android Background Service
      Timer.periodic(const Duration(minutes: 15), (timer) async {
        // print('Timer Called on BackGround : ${timer.tick}');

        // bool storageStarted = await GetStorage.init('AsKey');
        bool storageStarted = await asKeyStorage.initAsKeyStorage();
        if (storageStarted) {}

        // GetStorage box = GetStorage('AsKey');

        // if (box.read('AdminUserName') != null &&
        //     box.read('AdminPassword') != null) {
        if (asKeyStorage.getAsKeyAdminPassword().isNotEmpty) {
          RioBackgroundServices.putAdminLogin(
            AdminLoginParam(
              username: asKeyStorage.getAsKeyAdminUserName(),
              password: asKeyStorage.getAsKeyAdminPassword(),
              deviceToken: asKeyStorage.getAsKeyDeviceToken(),
              mailId: amzStorage.getAMZUserEmail(),
              rioPassword: '',
            ),
          ).then((value) {
            // value.fold((l) => false, (r) {
            RioBackgroundServices.getDeviceList(
                RioBackgroundServices.fillGetWaitingDevices());
            // });
          });
        }
      });
    }

    service.on('setAsForeground').listen((event) {
      // service.setAsForegroundService();

      if (event != null) {
        ApiUtilsWithHeader.token = event['token'];
        asKeyStorage.saveAsKeyAdminUserName(event['AdminUserName']);
        asKeyStorage.saveAsKeyAdminPassword(event['AdminPassword']);
        asKeyStorage.saveAsKeyToken(event['token']);
        AppConstants.baseUrlAsKey = event['URL'];
        // box.write('AdminUserName', event['AdminUserName']);
        // box.write('AdminPassword', event['AdminPassword']);
        // box.write('token', event['token']);
      }
    });

    service.on('setAsBackground').listen((event) {
      service.setAsBackgroundService();
    });
  } else {
    // IOS Foreground Service
    // print('IOS Foreground Service Started');
    // FcmServices.showNotifications(
    //     'Rio Router', 'Checking for New Connected Devices');

    if (service is IOSServiceInstance) {
      service.on('setAsForeground').listen((event) {
        // service.setAsForegroundService();

        if (event != null) {
          ApiUtilsWithHeader.token = event['token'];
          asKeyStorage.saveAsKeyAdminUserName(event['AdminUserName']);
          asKeyStorage.saveAsKeyAdminPassword(event['AdminPassword']);
          asKeyStorage.saveAsKeyToken(event['token']);
          AppConstants.baseUrlAsKey = event['URL'];

          // box.write('AdminUserName', event['AdminUserName']);
          // box.write('AdminPassword', event['AdminPassword']);
          // box.write('token', event['token']);
        }
      });
    }

    // bring to foreground

    Timer.periodic(const Duration(seconds: 20), (timer) async {
      // print("Notification Status: ${RioBackgroundServices.notificationShown}");
      if (RioBackgroundServices.notificationShown) {
        if (timer.tick % 16 == 0) {
          RioBackgroundServices.notificationShown = false;
        }
      } else {
        if (asKeyStorage.getAsKeyToken().isNotEmpty) {
          ApiUtilsWithHeader.token = asKeyStorage.getAsKeyToken();
          RioBackgroundServices.getDeviceList(
              RioBackgroundServices.fillGetWaitingDevices());
        }
      }
    });
  }

  service.on('stopService').listen((event) {
    service.stopSelf();
  });
}
