import 'dart:async';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ErrorDialogService {
  final _errorController =
      StreamController<List<Map<String, String>>>.broadcast();

  Stream<List<Map<String, String>>> get errorStream => _errorController.stream;

  void show(List<Map<String, String>> errors) {
    _errorController.add(errors);
  }

  void dispose() {
    _errorController.close();
  }
}

final errorDialogServiceProvider = Provider<ErrorDialogService>((ref) {
  final service = ErrorDialogService();
  ref.onDispose(() => service.dispose());
  return service;
});

final errorStreamProvider = StreamProvider<List<Map<String, String>>>((ref) {
  final service = ref.watch(errorDialogServiceProvider);
  return service.errorStream;
});
