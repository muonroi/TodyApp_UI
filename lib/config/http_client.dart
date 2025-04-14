import 'package:dio/dio.dart';
import 'package:tudy/core/intercepters/auth.dart';
import 'package:tudy/core/providers/error_dialog_provider.dart';
import 'package:tudy/core/storages/token.dart';

final tokenStorage = TokenStorage();
final errorDialogService = ErrorDialogService();

Dio createDio() {
  final dioInstance = Dio(BaseOptions(baseUrl: 'http://localhost:3000/'));
  dioInstance.interceptors.add(
    AuthInterceptor(
      dio: dioInstance,
      tokenStorage: tokenStorage,
      errorDialogService: errorDialogService,
    ),
  );
  return dioInstance;
}
