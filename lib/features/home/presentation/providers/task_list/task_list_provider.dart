import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tudy/features/home/presentation/providers/task_list/task_list_notifier.dart';

final taskListProvider =
    StateNotifierProvider<TaskListNotifier, TaskListState>((ref) {
  final repository = ref.watch(homeRepositoryProvider);

  return TaskListNotifier(repository);
});
