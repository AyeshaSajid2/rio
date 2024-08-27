import 'package:flutter/services.dart';

class WifiMethodChannel {
  static const MethodChannel _channel = MethodChannel('connectRioWifi');
  static const MethodChannel _batteryChannel = MethodChannel('BatterLevel');

  /// Method Channel For connecting Wifi
  static Future<bool> connectToWifi(
    String ssid,
    String password,
  ) async {
    try {
      final Map<String, String> params = {
        'ssid': ssid,
        'password': password,
      };

      final bool isConnected =
          await _channel.invokeMethod('connectToWifi', params);

      return isConnected;
    } catch (e) {
      throw Exception("Error connecting to WiFi: $e");
    }
  }

  /// Method Channel For Battery Level
  static Future<int> getBatteryLevel() async {
    try {
      final Map<String, String> params = {
        'name': "Usama",
      };

      final int batteryLevel =
          await _batteryChannel.invokeMethod('getBatterLevel', params);
      return batteryLevel;
    } catch (e) {
      throw Exception("Error in getting Battery Level: $e");
    }
  }
}
