import 'package:flutter/foundation.dart';

class Log {
  static void i(dynamic value) {
    if (kDebugMode) {
      print('BCoder info logs: $value');
    }
  }

  static void e(dynamic value) {
    if (kDebugMode) {
      print('BCoder error logs: $value');
    }
  }

  static void d(dynamic value) {
    if (kDebugMode) {
      print('BCoder debug logs: $value');
    }
  }
}
