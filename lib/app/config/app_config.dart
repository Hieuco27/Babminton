import 'package:flutter_dotenv/flutter_dotenv.dart';

class AppConfig {
  static String get appName => dotenv.env['APP_NAME'] ?? 'Thermo Humi';
  static String get environment => dotenv.env['ENV'] ?? 'development';
  static String get apiBaseUrl => dotenv.env['API_BASE_URL'] ?? 'https://api.thermohumi.example.com';
  static String get signalrUrl => dotenv.env['SIGNALR_URL'] ?? 'https://api.thermohumi.example.com/hubs/telemetry';
  static int get connectTimeout => int.tryParse(dotenv.env['CONNECT_TIMEOUT'] ?? '30000') ?? 30000;
  static int get receiveTimeout => int.tryParse(dotenv.env['RECEIVE_TIMEOUT'] ?? '30000') ?? 30000;

  static bool get isDevelopment => environment.toLowerCase() == 'development';
}
