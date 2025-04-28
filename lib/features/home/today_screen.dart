import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tudy/features/home/data/enums/priority_level.dart';
import 'package:tudy/features/home/data/models/task_model.dart';
import 'package:tudy/features/home/presentation/providers/task_list/task_list_notifier.dart';
import 'package:tudy/features/home/presentation/widgets/task_tile.dart';
import 'package:tudy/features/home/presentation/providers/search_provider.dart';
import 'package:tudy/features/home/presentation/providers/task_list/task_list_provider.dart';
import 'package:tudy/l10n/app_localizations.dart';

class TodayScreen extends ConsumerStatefulWidget {
  const TodayScreen({super.key});

  @override
  ConsumerState<TodayScreen> createState() => _TodayScreenState();
}

class _TodayScreenState extends ConsumerState<TodayScreen> {
  final _searchController = TextEditingController();
  final _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();

    _searchController.addListener(() {
      ref.read(searchQueryProvider.notifier).state = _searchController.text;
    });

    _scrollController.addListener(_onScroll);

    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (ref.read(taskListProvider) is TaskListInitial) {
        ref.read(taskListProvider.notifier).loadTasks(1);
      }
    });
  }

  void _onScroll() {
    if (_scrollController.position.pixels >=
        _scrollController.position.maxScrollExtent * 0.9) {
      final currentState = ref.read(taskListProvider);
      if (currentState is TaskListData) {
        if (!currentState.isLoadingMore && currentState.canLoadMore) {
          ref.read(taskListProvider.notifier).loadMoreTasks();
        }
      }
    }
  }

  @override
  void dispose() {
    _searchController.dispose();
    _scrollController.removeListener(_onScroll);
    _scrollController.dispose();
    super.dispose();
  }

  Widget _buildPersistentSearchBar(AppLocalizations l10n, ThemeData theme) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      child: TextField(
        controller: _searchController,
        decoration: InputDecoration(
          hintText: "${l10n.searchTitle}...",
          prefixIcon: Icon(Icons.search,
              size: 20,
              color: theme.iconTheme.color
                  ?.withValues(alpha: 0.6)), // Sử dụng withOpacity
          suffixIcon: _searchController.text.isNotEmpty
              ? IconButton(
                  icon: const Icon(Icons.clear, size: 20),
                  onPressed: () {
                    _searchController.clear();
                  },
                  splashRadius: 18,
                  color: theme.iconTheme.color
                      ?.withValues(alpha: 0.6), // Sử dụng withOpacity
                )
              : null,
          filled: true,
          fillColor: theme.colorScheme.surfaceContainerHighest
              .withValues(alpha: 0.8), // Sử dụng withOpacity
          contentPadding:
              const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10.0),
            borderSide: BorderSide.none,
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10.0),
            borderSide: BorderSide.none,
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10.0),
            borderSide: BorderSide(color: theme.primaryColor, width: 1.0),
          ),
        ),
        style: theme.textTheme.bodyMedium,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final theme = Theme.of(context);

    final taskListState = ref.watch(taskListProvider);
    final query = ref.watch(searchQueryProvider).toLowerCase();

    return Column(
      children: [
        _buildPersistentSearchBar(l10n, theme),
        Expanded(
          child: switch (taskListState) {
            TaskListInitial() => const SizedBox.shrink(),
            TaskListLoading() =>
              const Center(child: CircularProgressIndicator()),
            TaskListError(message: final msg) => Center(
                child: Text(msg ?? l10n.errorGeneral),
              ),
            TaskListData(
              tasks: final allTasks,
              isLoadingMore: final isLoadingMore
            ) =>
              Builder(builder: (context) {
                final filteredTasks = query.isEmpty
                    ? allTasks
                    : allTasks
                        .where(
                            (task) => task.name.toLowerCase().contains(query))
                        .toList();

                // ✨ START: Logic sắp xếp mới ✨
                int customTaskSort(TaskModel a, TaskModel b) {
                  // 1. Sắp xếp task chưa hoàn thành lên trước (isDone == false)
                  if (a.isDone != b.isDone) {
                    return a.isDone
                        ? 1
                        : -1; // Nếu a đã xong và b chưa xong, a xuống dưới (1); ngược lại, a lên trên (-1)
                  }

                  // 2. Nếu cùng trạng thái hoàn thành, sắp xếp theo độ ưu tiên (P1 > P2 > P3 > P4 > None)
                  final defaultPriorityIndex = PriorityLevel
                      .p4.index; // Giả định P4 là độ ưu tiên thấp nhất
                  final priorityA = a.priority?.index ??
                      defaultPriorityIndex +
                          1; // Gán index cao hơn default cho null để nó xuống dưới P4
                  final priorityB = b.priority?.index ??
                      defaultPriorityIndex +
                          1; // Gán index cao hơn default cho null để nó xuống dưới P4

                  return priorityA.compareTo(
                      priorityB); // Index nhỏ hơn (ưu tiên cao hơn) lên trước
                }

                // Áp dụng hàm sắp xếp mới
                final sortedTasks = List<TaskModel>.from(filteredTasks)
                  ..sort(customTaskSort);
                // ✨ END: Logic sắp xếp mới ✨

                if (sortedTasks.isEmpty && !isLoadingMore) {
                  return Center(
                      child: Text(
                          query.isEmpty ? l10n.noTasksYet : l10n.noTaskFound,
                          style: theme.textTheme.bodySmall));
                }

                return ListView.separated(
                  controller: _scrollController,
                  itemCount: sortedTasks.length + (isLoadingMore ? 1 : 0),
                  itemBuilder: (context, index) {
                    if (isLoadingMore && index == sortedTasks.length) {
                      return const Center(
                          child: Padding(
                              padding: EdgeInsets.symmetric(vertical: 16.0),
                              child: CircularProgressIndicator()));
                    }
                    final task = sortedTasks[index];
                    return TaskTile(
                      task: task,
                      onTap: () {
                        // Xử lý khi tap vào task (ví dụ: mở chi tiết task)
                      },
                      onCompleted: (bool? value) {
                        // Callback khi trạng thái hoàn thành thay đổi
                        ref.read(taskListProvider.notifier).toggleDone(task.id);
                        // Sau khi toggleDone, bạn có thể muốn tải lại hoặc sắp xếp lại danh sách
                        // ToggleDone trong TaskListNotifier của bạn đã cập nhật state,
                        // điều này sẽ tự động khiến widget này build lại và áp dụng sắp xếp mới.
                      },
                    );
                  },
                  separatorBuilder: (context, index) {
                    // Không vẽ divider sau item loading
                    if (isLoadingMore && index == sortedTasks.length - 1) {
                      return const SizedBox.shrink();
                    }
                    // Bạn có thể thêm logic để không vẽ divider giữa các task đã xong
                    // và các task chưa xong nếu cần phân biệt rõ ràng hơn.
                    // Ví dụ:
                    // if (index < sortedTasks.length -1 && sortedTasks[index].isDone != sortedTasks[index+1].isDone) {
                    //   return const SizedBox.shrink(); // Không vẽ divider giữa 2 nhóm khác trạng thái
                    // }
                    return const Divider(height: 1, indent: 56, endIndent: 16);
                  },
                  padding: EdgeInsets.zero,
                );
              }),
            _ => Center(
                // Fallback cho các trạng thái TaskListState khác (không mong muốn)
                child: Text(l10n.errorGeneral),
              )
          },
        ),
      ],
    );
  }
}
