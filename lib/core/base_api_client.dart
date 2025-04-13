import 'package:dio/dio.dart';

class BaseApiClient {
  final Dio _dio;

  BaseApiClient(Dio dio) : _dio = dio;

  Future<Map<String, dynamic>> get(String path,
      {Map<String, dynamic>? params}) async {
    try {
      Response response = await _dio.get(path, queryParameters: params);
      return response.data;
    } catch (e) {
      rethrow;
    }
  }

  Future<Map<String, dynamic>> post(String path, dynamic body,
      {Map<String, dynamic>? params, bool isFormData = false}) async {
    try {
      Response response = await _dio.post(
        path,
        data: body,
        queryParameters: params,
        options: Options(
            contentType:
                isFormData ? "multipart/form-data" : "application/json"),
      );
      return response.data;
    } catch (e) {
      rethrow;
    }
  }

  Future<Map<String, dynamic>> patch(String path, dynamic body) async {
    try {
      Response response = await _dio.patch(path, data: body);
      return response.data;
    } catch (e) {
      rethrow;
    }
  }

  Future<Map<String, dynamic>> put(String path, dynamic body,
      {bool isFormData = false}) async {
    try {
      Response response = await _dio.put(
        path,
        data: body,
        options: Options(
            contentType:
                isFormData ? "multipart/form-data" : "application/json"),
      );
      return response.data;
    } catch (e) {
      rethrow;
    }
  }

  Future<Map<String, dynamic>> delete(String path,
      {Map<String, dynamic>? params}) async {
    try {
      Response response = await _dio.delete(path, queryParameters: params);
      return response.data;
    } catch (e) {
      rethrow;
    }
  }
}
