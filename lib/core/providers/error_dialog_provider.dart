import 'package:flutter_riverpod/flutter_riverpod.dart';

typedef ErrorInfo = List<Map<String, String>>;

class ErrorStateNotifier extends StateNotifier<AsyncValue<ErrorInfo>> {
  ErrorStateNotifier() : super(const AsyncValue.data([]));

  void setErrors(ErrorInfo errors) {
    if (errors.isNotEmpty) {
      state = AsyncValue.data(errors);
    } else {
      clearErrors();
    }
  }

  void clearErrors() {
    if (state is! AsyncData<ErrorInfo> ||
        (state as AsyncData<ErrorInfo>).value.isNotEmpty) {
      state = const AsyncValue.data([]);
    }
  }

  void setInternalError(Object error, StackTrace stackTrace) {
    state = AsyncValue.error(error, stackTrace);
  }
}

final errorStateNotifierProvider =
    StateNotifierProvider<ErrorStateNotifier, AsyncValue<ErrorInfo>>((ref) {
  return ErrorStateNotifier();
});

class ErrorDialogService {
  final Ref ref;

  ErrorDialogService(this.ref);

  void show(List<Map<String, String>> errors) {
    ref.read(errorStateNotifierProvider.notifier).setErrors(errors);
  }
}
