import 'package:dio/dio.dart';
import 'package:tudy/core/models/mresponse.dart';
import 'package:tudy/core/providers/error_dialog_provider.dart';
import 'package:flutter/foundation.dart';

import 'base_api_client.dart';

class BaseService {
  final BaseApiClient apiClient;
  final ErrorDialogService errorDialogService;

  BaseService({
    required this.apiClient,
    required this.errorDialogService,
  });

  void _showBusinessErrorDialog(List<String> errorMessages) {
    final formattedErrors = errorMessages
        .map((msg) => {
              'errorCode': 'Lỗi nghiệp vụ',
              'errorMessage': msg,
            })
        .toList();
    errorDialogService.show(formattedErrors);
  }

  Future<T?> getData<T>(
    String url, {
    Map<String, dynamic>? params,
    required T Function(dynamic) fromJson,
  }) async {
    try {
      final data = await apiClient.get(url, params: params);

      final response = MResponse<T>.fromJson(data, fromJson);

      if (!response.isOK) {
        _showBusinessErrorDialog(response.errorMessages);
        return null;
      }

      return response.result;
    } on DioException catch (e) {
      if (kDebugMode) {
        print("DioException in BaseService.getData: ${e.message}");
      }

      return null;
    } catch (e) {
      if (kDebugMode) {
        print("Error in BaseService.getData: $e");
      }

      return null;
    }
  }

  Future<List<T>?> getListData<T>(
    String url, {
    Map<String, dynamic>? params,
    required T Function(dynamic) fromJson,
  }) async {
    try {
      final data = await apiClient.get(url, params: params);

      final isOK = data['isOK'] ?? false;
      final errorMessages = List<String>.from(data['errorMessages'] ?? []);

      if (!isOK) {
        _showBusinessErrorDialog(errorMessages);
        return null;
      }

      if (data['result'] == null) {
        if (kDebugMode) {
          print(
              "Error in BaseService.getListData: result is null although isOK was true.");
        }
        return null;
      }
      List<T> items =
          (data['result'] as List).map((item) => fromJson(item)).toList();
      return items;
    } on DioException catch (e) {
      if (kDebugMode) {
        print("DioException in BaseService.getListData: ${e.message}");
      }
      return null;
    } catch (e) {
      if (kDebugMode) {
        print("Error in BaseService.getListData: $e");
      }
      return null;
    }
  }

  Future<MPagingResponse<T>?> getPagedData<T>(
    String url, {
    Map<String, dynamic>? params,
    required T Function(dynamic) fromJson,
  }) async {
    try {
      final data = await apiClient.get(url, params: params);
      final response = MPagingResponse<T>.fromJson(data, fromJson);

      if (!response.responseInfo.isOK) {
        _showBusinessErrorDialog(response.responseInfo.errorMessages);
        return null;
      }
      return response;
    } on DioException catch (e) {
      if (kDebugMode) {
        print("DioException in BaseService.getPagedData: ${e.message}");
      }
      return null;
    } catch (e) {
      if (kDebugMode) {
        print("Error in BaseService.getPagedData: $e");
      }
      return null;
    }
  }

  Future<T?> postData<T>(
    String url,
    dynamic body, {
    Map<String, dynamic>? params,
    required T Function(dynamic) fromJson,
  }) async {
    try {
      final data = await apiClient.post(url, body, params: params);
      final response = MResponse<T>.fromJson(data, fromJson);

      if (!response.isOK) {
        _showBusinessErrorDialog(response.errorMessages);
        return null;
      }
      return response.result;
    } on DioException catch (e) {
      if (kDebugMode) {
        print("DioException in BaseService.postData: ${e.message}");
      }
      return null;
    } catch (e) {
      if (kDebugMode) {
        print("Error in BaseService.postData: $e");
      }
      return null;
    }
  }

  Future<T?> patchData<T>(
    String url,
    dynamic body, {
    required T Function(dynamic) fromJson,
  }) async {
    try {
      final data = await apiClient.patch(url, body);
      final response = MResponse<T>.fromJson(data, fromJson);
      if (!response.isOK) {
        _showBusinessErrorDialog(response.errorMessages);
        return null;
      }
      return response.result;
    } on DioException catch (e) {
      debugPrint("DioException in BaseService.patchData: ${e.message}");
      return null;
    } catch (e) {
      return null;
    }
  }

  Future<T?> putData<T>(
    String url,
    dynamic body, {
    required T Function(dynamic) fromJson,
  }) async {
    try {
      final data = await apiClient.put(url, body);
      final response = MResponse<T>.fromJson(data, fromJson);
      if (!response.isOK) {
        _showBusinessErrorDialog(response.errorMessages);
        return null;
      }
      return response.result;
    } on DioException catch (e) {
      debugPrint("DioException in BaseService.patchData: ${e.message}");
      return null;
    } catch (e) {
      return null;
    }
  }

  Future<T?> putDataFormData<T>(
    String url,
    FormData body, {
    required T Function(dynamic) fromJson,
  }) async {
    try {
      final data = await apiClient.put(url, body, isFormData: true);
      final response = MResponse<T>.fromJson(data, fromJson);
      if (!response.isOK) {
        _showBusinessErrorDialog(response.errorMessages);
        return null;
      }
      return response.result;
    } on DioException catch (e) {
      debugPrint("DioException in BaseService.patchData: ${e.message}");
      return null;
    } catch (e) {
      return null;
    }
  }

  Future<T?> deleteData<T>(
    String url, {
    Map<String, dynamic>? params,
    required T Function(dynamic) fromJson,
  }) async {
    try {
      final data = await apiClient.delete(url, params: params);

      final response = MResponse<T>.fromJson(data, fromJson);
      if (!response.isOK) {
        _showBusinessErrorDialog(response.errorMessages);
        return null;
      }

      return response.result;
    } on DioException catch (e) {
      debugPrint("DioException in BaseService.patchData: ${e.message}");
      return null;
    } catch (e) {
      return null;
    }
  }
}
