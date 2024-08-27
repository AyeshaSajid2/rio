// lib/services/device_service.dart
import 'dart:async';

class TimerService {
  Future<void> connectDevices(Function(int) onUpdate) async {
    for (int i = 60; i >= 0; i--) {
      await Future.delayed(const Duration(seconds: 1));
      onUpdate(i);
    }
  }
}
