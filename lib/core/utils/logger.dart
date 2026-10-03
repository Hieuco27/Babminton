import 'dart:developer' as developer;
import '../../app/config/app_config.dart';

class AppLogger {
  static void d(String message, {String tag = 'DEBUG'}) {
    if (AppConfig.isDevelopment) {
      developer.log('🔵 [$tag] $message');
    }
  }

  static void i(String message, {String tag = 'INFO'}) {
    developer.log('🟢 [$tag] $message');
  }

  static void w(String message, {String tag = 'WARN'}) {
    developer.log('🟠 [$tag] $message');
  }

  static void e(String message, {Object? error, StackTrace? stackTrace, String tag = 'ERROR'}) {
    developer.log('🔴 [$tag] $message', error: error, stackTrace: stackTrace);
  }
}
