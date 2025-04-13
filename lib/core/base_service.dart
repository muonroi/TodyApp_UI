// base_service.dart
import 'package:tudy/core/models/mresponse.dart';

import 'base_api_client.dart';
import 'package:dio/dio.dart';

class BaseService {
  final BaseApiClient apiClient;

  BaseService({required this.apiClient});

  Future<MPagingResponse<T>> getPagedData<T>(
    String url, {
    Map<String, dynamic>? params,
    required T Function(dynamic) fromJson,
  }) async {
    final data = await apiClient.get(url, params: params);
    return MPagingResponse<T>.fromJson(data, fromJson);
  }

  Future<MResponse<T>> getData<T>(
    String url, {
    Map<String, dynamic>? params,
    required T Function(dynamic) fromJson,
  }) async {
    final data = await apiClient.get(url, params: params);
    return MResponse<T>.fromJson(data, fromJson);
  }

  Future<MResponse<List<T>>> getListData<T>(
    String url, {
    Map<String, dynamic>? params,
    required T Function(dynamic) fromJson,
  }) async {
    final data = await apiClient.get(url, params: params);
    if (data['result'] == null) {
      throw Exception("Invalid response structure from API");
    }
    List<T> items =
        (data['result'] as List).map((item) => fromJson(item)).toList();
    return MResponse<List<T>>(
      result: items,
      id: data['id'] ?? '',
      utcTime: DateTime.parse(data['utcTime'].toString()),
      errorMessages: List<String>.from(data['errorMessages'] ?? []),
      isOK: data['isOK'] ?? false,
    );
  }

  Future<MResponse<T>> postData<T>(
    String url,
    dynamic body, {
    Map<String, dynamic>? params,
    required T Function(dynamic) fromJson,
  }) async {
    final data = await apiClient.post(url, body, params: params);
    return MResponse<T>.fromJson(data, fromJson);
  }

  Future<MResponse<T>> patchData<T>(
    String url,
    dynamic body, {
    required T Function(dynamic) fromJson,
  }) async {
    final data = await apiClient.patch(url, body);
    return MResponse<T>.fromJson(data, fromJson);
  }

  Future<MResponse<T>> putData<T>(
    String url,
    dynamic body, {
    required T Function(dynamic) fromJson,
  }) async {
    final data = await apiClient.put(url, body);
    return MResponse<T>.fromJson(data, fromJson);
  }

  Future<MResponse<T>> putDataFormData<T>(
    String url,
    FormData body, {
    required T Function(dynamic) fromJson,
  }) async {
    final data = await apiClient.put(url, body, isFormData: true);
    return MResponse<T>.fromJson(data, fromJson);
  }

  Future<MResponse<T>> deleteData<T>(
    String url, {
    Map<String, dynamic>? params,
    required T Function(dynamic) fromJson,
  }) async {
    final data = await apiClient.delete(url, params: params);
    return MResponse<T>.fromJson(data, fromJson);
  }
}
