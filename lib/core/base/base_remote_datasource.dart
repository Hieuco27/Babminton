import 'package:dio/dio.dart';
import '../error/exceptions.dart';

abstract class BaseRemoteDataSource {
  Future<T> callApi<T>(Future<Response> Function() apiCall, T Function(dynamic data) parse) async {
    try {
      final response = await apiCall();
      if (response.statusCode != null && response.statusCode! >= 200 && response.statusCode! < 300) {
        return parse(response.data);
      } else {
        throw ServerException(
          message: response.statusMessage ?? 'Server error',
          statusCode: response.statusCode,
        );
      }
    } on DioException catch (e) {
      if (e.type == DioExceptionType.connectionTimeout ||
          e.type == DioExceptionType.receiveTimeout ||
          e.type == DioExceptionType.connectionError) {
        throw const NetworkException();
      } else if (e.response?.statusCode == 401) {
        throw const UnauthorizedException();
      } else {
        final message = e.response?.data?['message'] ?? e.message ?? 'HTTP request failed';
        throw ServerException(
          message: message.toString(),
          statusCode: e.response?.statusCode,
        );
      }
    } catch (e) {
      if (e is Exception) rethrow;
      throw ServerException(message: e.toString());
    }
  }
}
