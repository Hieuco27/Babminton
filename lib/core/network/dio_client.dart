import 'package:dio/dio.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';
import '../config/app_config.dart';
import '../storage/secure_storage_service.dart';
import 'api_interceptors.dart';

class DioClient {
  late final Dio _dio;

  DioClient(SecureStorageService secureStorageService) {
    _dio = Dio(
      BaseOptions(
        baseUrl: AppConfig.apiBaseUrl,
        connectTimeout: Duration(milliseconds: AppConfig.connectTimeout),
        receiveTimeout: Duration(milliseconds: AppConfig.receiveTimeout),
      ),
    );

    _dio.interceptors.addAll([
      AuthInterceptor(secureStorageService),
      ErrorInterceptor(),
      if (AppConfig.isDevelopment)
        PrettyDioLogger(
          requestHeader: true,
          requestBody: true,
          responseBody: true,
          responseHeader: false,
          error: true,
          compact: true,
        ),
    ]);
  }

  Dio get instance => _dio;
}
