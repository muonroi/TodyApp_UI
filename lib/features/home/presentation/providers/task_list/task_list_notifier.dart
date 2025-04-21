import 'package:equatable/equatable.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tudy/config/core_providers.dart';
import 'package:tudy/core/models/mresponse.dart';
import 'package:tudy/features/home/data/models/task_model.dart';
import 'package:tudy/features/home/data/models/todo_list_request_model.dart';
import 'package:tudy/features/home/data/repositories/home_repository.dart';
import 'package:uuid/uuid.dart';

part 'task_list_state.dart';

final homeRepositoryProvider = Provider<HomeRepository>((ref) {
  final baseService = ref.watch(baseServiceProvider);
  return HomeRepositoryImpl(baseService: baseService);
}, name: 'HomeRepositoryProvider');

class TaskListNotifier extends StateNotifier<TaskListState> {
  final HomeRepository _homeRepository;

  TaskListNotifier(this._homeRepository) : super(TaskListInitial());

  Future<bool> createTask(TodoListRequestModel request) async {
    try {
      final bool? success = await _homeRepository.createTaskList(request);

      if (success == true) {
        final newTaskModel = TaskModel(
          id: const Uuid().v4(),
          name: request.name,
          isDone: false,
          priority: request.priority,
          dueDate: request.dueDate,
          description: request.description,
          hasReminder: request.reminderTime != null,
          reminderTime: request.reminderTime,
          reminderRepeats: request.reminderRepeats,
        );

        if (state is TaskListData) {
          final currentState = state as TaskListData;

          state = currentState.copyWith(
            tasks: [...currentState.tasks, newTaskModel],
          );
        } else {
          state = TaskListData([newTaskModel]);
        }
        return true;
      } else {
        return false;
      }
    } catch (e) {
      return false;
    }
  }

  Future<void> loadTasks(int pageIndex) async {
    if (pageIndex == 1 || state is! TaskListData) {
      state = TaskListLoading();
    } else {}

    try {
      final MPagingResponse<TaskModel>? response =
          await _homeRepository.getTasks(pageIndex);
      if (response != null) {
        state = TaskListData(response.result, pagingInfo: response.pagingInfo);
      } else {
        if (state is TaskListLoading) {
          state = const TaskListError(
              message: "Không thể tải danh sách công việc.");
        } else if (state is TaskListData) {}
      }
    } catch (e) {
      if (state is TaskListLoading) {
        state = TaskListError(message: "Lỗi không xác định: ${e.toString()}");
      } else if (state is TaskListData) {}
    }
  }

  Future<void> loadMoreTasks() async {
    if (state is TaskListData) {
      final currentState = state as TaskListData;

      if (!currentState.canLoadMore || currentState.isLoadingMore) {
        return;
      }

      state = currentState.copyWith(isLoadingMore: true);

      final nextPage = currentState.nextPage;

      try {
        final MPagingResponse<TaskModel>? response =
            await _homeRepository.getTasks(nextPage);

        if (response != null) {
          final newTasks = response.result;
          final updatedTasks = List<TaskModel>.from(currentState.tasks)
            ..addAll(newTasks);

          state = TaskListData(updatedTasks,
              pagingInfo: response.pagingInfo, isLoadingMore: false);
        } else {
          state = currentState.copyWith(isLoadingMore: false);
        }
      } catch (e) {
        state = currentState.copyWith(isLoadingMore: false);
      }
    }
  }

  Future<void> toggleDone(String taskId) async {
    if (state is! TaskListData) return;

    final currentData = state as TaskListData;
    final currentTasks = currentData.tasks;

    final taskIndex = currentTasks.indexWhere((task) => task.id == taskId);
    if (taskIndex == -1) return;

    final taskToUpdate = currentTasks[taskIndex];
    final newIsDoneStatus = !taskToUpdate.isDone;

    taskToUpdate.isDone = newIsDoneStatus;

    String? reminderTimeStringForBackend;

    if (taskToUpdate.parsedReminderTime != null) {
      final int? hour = taskToUpdate.parsedReminderTime?.hour;
      final int? minute = taskToUpdate.parsedReminderTime?.minute;

      final String hourPadded = hour.toString().padLeft(2, '0');
      final String minutePadded = minute.toString().padLeft(2, '0');

      reminderTimeStringForBackend = "0.$hourPadded:$minutePadded:00";
    }

    final request = TodoListRequestModel(
        entityId: taskToUpdate.id,
        name: taskToUpdate.name,
        isDone: newIsDoneStatus,
        dueDate: taskToUpdate.dueDate,
        priority: taskToUpdate.priority,
        hasReminder: taskToUpdate.hasReminder,
        reminderTime: reminderTimeStringForBackend,
        reminderRepeats: taskToUpdate.reminderRepeats,
        description: taskToUpdate.description,
        category: taskToUpdate.categoryId);

    final bool? success = await _homeRepository.updateTaskList(request);

    if (success != null && success && mounted) {
      final updatedTask = taskToUpdate.copyWith(
        isDone: newIsDoneStatus,
      );

      final updatedTasks = List<TaskModel>.from(currentTasks);
      updatedTasks[taskIndex] = updatedTask;

      state = currentData.copyWith(tasks: updatedTasks);
    }
  }
}
