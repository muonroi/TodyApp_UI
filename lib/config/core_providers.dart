import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tudy/core/base_api_client.dart';
import 'package:tudy/core/base_service.dart';
import 'package:tudy/core/intercepters/auth.dart';
import 'package:tudy/core/providers/error_dialog_provider.dart';
import 'package:tudy/core/storages/token.dart';

final tokenStorageProvider = Provider<TokenStorage>((ref) {
  return TokenStorage();
}, name: 'TokenStorage');

final errorDialogServiceProvider = Provider<ErrorDialogService>((ref) {
  return ErrorDialogService();
}, name: 'ErrorDialogService');

final dioProvider = Provider<Dio>((ref) {
  final tokenStorage = ref.watch(tokenStorageProvider);
  final errorDialogService = ref.watch(errorDialogServiceProvider);

  final dioInstance = Dio(BaseOptions(
    baseUrl: 'http://10.0.2.2:5181/api/v1',
    connectTimeout: const Duration(seconds: 15),
    receiveTimeout: const Duration(seconds: 15),
  ));

  dioInstance.interceptors.add(
    AuthInterceptor(
      dio: dioInstance,
      tokenStorage: tokenStorage,
      errorDialogService: errorDialogService,
    ),
  );

  return dioInstance;
}, name: 'Dio');

final baseApiClientProvider = Provider<BaseApiClient>((ref) {
  final dio = ref.watch(dioProvider);
  return BaseApiClient(dio);
}, name: 'BaseApiClient');

final baseServiceProvider = Provider<BaseService>((ref) {
  final apiClient = ref.watch(baseApiClientProvider);
  final errorDialogService = ref.watch(errorDialogServiceProvider);
  return BaseService(
    apiClient: apiClient,
    errorDialogService: errorDialogService,
  );
}, name: 'BaseService');
