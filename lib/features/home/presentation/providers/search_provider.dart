import 'package:collection/collection.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tudy/features/home/data/models/task_model.dart';
import 'package:tudy/features/home/presentation/helpers/helper.dart';
import 'package:tudy/features/home/presentation/providers/task_list/task_list_notifier.dart';
import 'package:tudy/features/home/presentation/providers/task_list/task_list_provider.dart';

final searchQueryProvider = StateProvider<String>((ref) => '');

final filteredTasksProvider = Provider<List<TaskModel>>((ref) {
  final taskListState = ref.watch(taskListProvider);

  final query = ref.watch(searchQueryProvider).toLowerCase();

  if (taskListState is TaskListData) {
    final allTasks = taskListState.tasks;

    final List<TaskModel> filteredList;
    if (query.isEmpty) {
      filteredList = allTasks;
    } else {
      filteredList = allTasks
          .where((task) => task.name.toLowerCase().contains(query))
          .toList();
    }

    final sortedList = filteredList.sorted(compareTasks);

    return sortedList;
  } else {
    return [];
  }
});
