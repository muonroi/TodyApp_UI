part of 'task_list_notifier.dart';

abstract class TaskListState extends Equatable {
  const TaskListState();
  @override
  List<Object?> get props => [];
}

class TaskListInitial extends TaskListState {}

class TaskListLoading extends TaskListState {}

class TaskListData extends TaskListState {
  final List<TaskModel> tasks;
  final PagingInfo? pagingInfo;
  final bool isLoadingMore;

  const TaskListData(this.tasks, {this.pagingInfo, this.isLoadingMore = false});

  @override
  List<Object?> get props => [tasks, pagingInfo, isLoadingMore];

  TaskListData copyWith({
    List<TaskModel>? tasks,
    PagingInfo? pagingInfo,
    bool? isLoadingMore,
  }) {
    return TaskListData(
      tasks ?? this.tasks,
      pagingInfo: pagingInfo ?? this.pagingInfo,
      isLoadingMore: isLoadingMore ?? this.isLoadingMore,
    );
  }

  bool get canLoadMore =>
      pagingInfo != null && pagingInfo!.currentPage < pagingInfo!.pageCount;

  int get nextPage => (pagingInfo?.currentPage ?? 0) + 1;
}

class TaskListError extends TaskListState {
  final String? message;
  const TaskListError({this.message});
  @override
  List<Object?> get props => [message];
}
