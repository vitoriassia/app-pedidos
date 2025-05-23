import 'package:dio/dio.dart';
import 'package:pedidos_app/core/network/api_client.dart';

class DioHttpClient implements ApiClient {
  final Dio _dio;

  @override
  Future<dynamic> get(String path, {Map<String, dynamic>? queryParams, dynamic options}) {
    return _dio.get(path, queryParameters: queryParams, options: options);
  }

  DioHttpClient({required Dio dio, List<Interceptor>? interceptors}) : _dio = dio {
    if (interceptors != null) {
      _dio.interceptors.addAll(interceptors);
    }
  }

  @override
  Future<dynamic> post(
    String path, {
    Map<String, dynamic>? queryParams,
    dynamic body,
    options,
  }) {
    return _dio.post(path, data: body, queryParameters: queryParams, options: options);
  }

  @override
  Future<dynamic> put(
    String path, {
    Map<String, dynamic>? queryParams,
    dynamic body,
    options,
  }) {
    return _dio.put(path, data: body, queryParameters: queryParams);
  }

  @override
  Future<dynamic> delete(String path, {Map<String, dynamic>? queryParams}) {
    return _dio.delete(path, queryParameters: queryParams);
  }

  /// Adds a single interceptor to the underlying Dio instance.
  void addInterceptor(Interceptor interceptor) {
    _dio.interceptors.add(interceptor);
  }

  /// Adds multiple interceptors to the underlying Dio instance.
  void addInterceptors(List<Interceptor> interceptors) {
    _dio.interceptors.addAll(interceptors);
  }
}
