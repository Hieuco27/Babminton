import 'package:equatable/equatable.dart';

class DeviceTelemetry extends Equatable {
  final String deviceId;
  final String deviceName;
  final double temperature;
  final double humidity;
  final bool isOnline;
  final DateTime lastUpdated;

  const DeviceTelemetry({
    required this.deviceId,
    required this.deviceName,
    required this.temperature,
    required this.humidity,
    required this.isOnline,
    required this.lastUpdated,
  });

  @override
  List<Object?> get props => [
        deviceId,
        deviceName,
        temperature,
        humidity,
        isOnline,
        lastUpdated,
      ];
}
