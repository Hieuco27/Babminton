import 'package:dartz/dartz.dart';
import '../../../../core/base/base_usecase.dart';
import '../../../../core/error/failures.dart';
import '../entities/device_telemetry.dart';
import '../repositories/home_repository.dart';

class GetDeviceTelemetryParams {
  final String deviceId;
  const GetDeviceTelemetryParams({required this.deviceId});
}

class GetDeviceTelemetryUseCase implements UseCase<DeviceTelemetry, GetDeviceTelemetryParams> {
  final HomeRepository repository;

  GetDeviceTelemetryUseCase(this.repository);

  @override
  Future<Either<Failure, DeviceTelemetry>> call(GetDeviceTelemetryParams params) {
    return repository.getDeviceTelemetry(params.deviceId);
  }
}
