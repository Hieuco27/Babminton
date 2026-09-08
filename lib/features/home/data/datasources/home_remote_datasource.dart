import '../../../../core/base/base_remote_datasource.dart';
import '../../../../core/network/dio_client.dart';
import '../models/device_telemetry_model.dart';

abstract class HomeRemoteDataSource {
  Future<DeviceTelemetryModel> getDeviceTelemetry(String deviceId);
}

class HomeRemoteDataSourceImpl extends BaseRemoteDataSource implements HomeRemoteDataSource {
  final DioClient _dioClient;

  HomeRemoteDataSourceImpl(this._dioClient);

  @override
  Future<DeviceTelemetryModel> getDeviceTelemetry(String deviceId) async {
    // For live API:
    // return callApi(
    //   () => _dioClient.instance.get('/api/v1/telemetry/current/$deviceId'),
    //   (data) => DeviceTelemetryModel.fromJson(data),
    // );

    // Verify _dioClient reference
    assert(_dioClient.instance.options.baseUrl.isNotEmpty);

    await Future.delayed(const Duration(milliseconds: 600));
    return DeviceTelemetryModel(
      deviceId: deviceId,
      deviceName: 'Cảm biến Phòng Khách',
      temperature: 28.5,
      humidity: 62.0,
      isOnline: true,
      lastUpdated: DateTime.now(),
    );
  }
}
