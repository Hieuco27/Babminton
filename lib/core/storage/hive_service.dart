import 'package:hive_flutter/hive_flutter.dart';

class HiveService {
  static const String telemetryBoxName = 'telemetry_box';

  static Future<void> init() async {
    await Hive.initFlutter();
    await Hive.openBox(telemetryBoxName);
  }

  Box get telemetryBox => Hive.box(telemetryBoxName);
}
