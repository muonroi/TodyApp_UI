import 'package:dio/dio.dart';
import 'package:tudy/core/providers/error_dialog_provider.dart';
import 'package:tudy/core/storages/token.dart';

class AuthInterceptor extends Interceptor {
  final Dio dio;
  final TokenStorage tokenStorage;
  final ErrorDialogService errorDialogService;

  bool _isRefreshing = false;
  final List<RequestOptions> _failedQueue = [];

  AuthInterceptor({
    required this.dio,
    required this.tokenStorage,
    required this.errorDialogService,
  });

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    final token = tokenStorage.getAccessToken();
    if (token != null && token.isNotEmpty) {
      options.headers["Authorization"] = "Bearer $token";
    }
    handler.next(options);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) async {
    final int? statusCode = err.response?.statusCode;

    if (statusCode == 401) {
      RequestOptions requestOptions = err.requestOptions;

      if (_isRefreshing) {
        _failedQueue.add(requestOptions);
        return;
      }
      _isRefreshing = true;

      try {
        final refreshToken = tokenStorage.getRefreshToken();
        if (refreshToken == null || refreshToken.isEmpty) {
          handler.next(err);
          return;
        }

        final Response refreshResponse = await dio.post(
          "/refresh-token",
          data: {"refreshToken": refreshToken},
        );

        if (refreshResponse.statusCode == 200 &&
            refreshResponse.data != null &&
            refreshResponse.data["result"] != null) {
          final newAccessToken = refreshResponse.data["result"]["accessToken"];
          final newRefreshToken =
              refreshResponse.data["result"]["refreshToken"];

          tokenStorage.setAccessToken(newAccessToken);
          tokenStorage.setRefreshToken(newRefreshToken);

          requestOptions.headers["Authorization"] = "Bearer $newAccessToken";
          final Response clonedResponse = await dio.request(
            requestOptions.path,
            options: Options(
              method: requestOptions.method,
              headers: requestOptions.headers,
              extra: requestOptions.extra,
              contentType: requestOptions.contentType,
            ),
            data: requestOptions.data,
            queryParameters: requestOptions.queryParameters,
          );

          for (final req in _failedQueue) {
            req.headers["Authorization"] = "Bearer $newAccessToken";
            await dio.request(
              req.path,
              options: Options(
                method: req.method,
                headers: req.headers,
                extra: req.extra,
                contentType: req.contentType,
              ),
              data: req.data,
              queryParameters: req.queryParameters,
            );
          }
          _failedQueue.clear();

          handler.resolve(clonedResponse);
          return;
        } else {
          handler.next(err);
          return;
        }
      } catch (e) {
        handler.next(err);
        return;
      } finally {
        _isRefreshing = false;
      }
    } else if (statusCode == 500) {
      errorDialogService.show([
        {
          'errorCode': 'Server Error',
          'errorMessage': 'Internal Server Error. Please try again later.',
        },
      ]);
      handler.next(err);
      return;
    }

    handler.next(err);
  }
}
