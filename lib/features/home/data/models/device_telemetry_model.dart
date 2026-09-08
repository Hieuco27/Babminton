import '../../domain/entities/device_telemetry.dart';

class DeviceTelemetryModel extends DeviceTelemetry {
  const DeviceTelemetryModel({
    required super.deviceId,
    required super.deviceName,
    required super.temperature,
    required super.humidity,
    required super.isOnline,
    required super.lastUpdated,
  });

  factory DeviceTelemetryModel.fromJson(Map<String, dynamic> json) {
    return DeviceTelemetryModel(
      deviceId: json['device_id'] ?? json['deviceId'] ?? '',
      deviceName: json['device_name'] ?? json['deviceName'] ?? 'Unknown Device',
      temperature: (json['temperature'] as num?)?.toDouble() ?? 0.0,
      humidity: (json['humidity'] as num?)?.toDouble() ?? 0.0,
      isOnline: json['is_online'] ?? json['isOnline'] ?? false,
      lastUpdated: json['last_updated'] != null
          ? DateTime.parse(json['last_updated'])
          : DateTime.now(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'device_id': deviceId,
      'device_name': deviceName,
      'temperature': temperature,
      'humidity': humidity,
      'is_online': isOnline,
      'last_updated': lastUpdated.toIso8601String(),
    };
  }
}
