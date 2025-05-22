abstract class ApiClient {
  Future<dynamic> post(
    String path, {
    Map<String, dynamic>? queryParams,
    dynamic body,
    dynamic options,
  });

  Future<dynamic> put(
    String path, {
    Map<String, dynamic>? queryParams,
    dynamic body,
    dynamic options,
  });

  Future<dynamic> delete(String path, {Map<String, dynamic>? queryParams});
}
