import 'package:dartz/dartz.dart';
import '../../../../core/error/failures.dart';
import '../entities/device_telemetry.dart';

abstract class HomeRepository {
  Future<Either<Failure, DeviceTelemetry>> getDeviceTelemetry(String deviceId);
}
