import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:tudy/features/home/data/models/task_model.dart';
import 'package:tudy/features/home/presentation/providers/quickadd_upcoming.dart';
import 'package:tudy/features/home/presentation/providers/task_list/task_list_notifier.dart';
import 'package:tudy/features/home/presentation/providers/task_list/task_list_provider.dart';
import 'package:tudy/features/home/presentation/widgets/task_tile.dart';
import 'package:tudy/l10n/app_localizations.dart';

class UpcomingScreen extends ConsumerStatefulWidget {
  const UpcomingScreen({super.key});

  @override
  ConsumerState<UpcomingScreen> createState() => _UpcomingScreenState();
}

class _UpcomingScreenState extends ConsumerState<UpcomingScreen> {
  // Hàm format ngày giống như ban đầu
  String _formatDateHeader(BuildContext context, DateTime date) {
    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);
    final tomorrow = today.add(const Duration(days: 1));
    final targetDate = DateTime(date.year, date.month, date.day);

    if (targetDate == today) {
      return "Hôm nay"; // Mặc dù màn hình Upcoming chỉ hiển thị từ ngày mai,
      // hàm này vẫn giữ logic cho Hôm nay nếu bạn tái sử dụng.
      // Thực tế, bạn sẽ không thấy "Hôm nay" ở màn hình này.
    } else if (targetDate == tomorrow) {
      return "Ngày mai";
    } else {
      try {
        // Sử dụng locale của context nếu có
        final locale = Localizations.localeOf(context).toString();
        return DateFormat.MMMMEEEEd(locale).format(date);
      } catch (e) {
        // Fallback nếu locale không hợp lệ
        return DateFormat('EEE, dd MMM').format(date);
      }
    }
  }

  // Hàm nhóm task theo ngày và lọc task tương lai
  Map<DateTime, List<TaskModel>> _groupAndFilterUpcomingTasks(
      List<TaskModel> allTasks) {
    final Map<DateTime, List<TaskModel>> groupedTasks = {};
    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);

    for (final task in allTasks) {
      // Lọc bỏ các task không có dueDate hoặc dueDate là hôm nay hoặc trước đó
      if (task.dueDate != null) {
        // Kiểm tra task có dueDate
        final taskDate = DateTime(
            task.dueDate!.year, task.dueDate!.month, task.dueDate!.day);
        if (taskDate.isAfter(today)) {
          // Chỉ lấy task từ ngày mai trở đi
          // Lấy ngày không có giờ để nhóm
          final dateKey = DateTime(
              task.dueDate!.year, task.dueDate!.month, task.dueDate!.day);
          groupedTasks.putIfAbsent(dateKey, () => []).add(task);
        }
      }
    }
    // Sắp xếp task trong mỗi ngày (ví dụ theo thời gian đến hạn hoặc độ ưu tiên)
    // Hiện tại giữ nguyên thứ tự thêm vào map value. Bạn có thể thêm logic sắp xếp ở đây.
    // Ví dụ:
    // groupedTasks.values.forEach((tasks) {
    //   tasks.sort((a, b) => a.dueDate!.compareTo(b.dueDate!)); // Sắp xếp theo thời gian đến hạn
    // });

    return groupedTasks;
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final l10n = AppLocalizations.of(context);

    // Watch task list state
    final taskListState = ref.watch(taskListProvider);

    return switch (taskListState) {
      TaskListInitial() =>
        const SizedBox.shrink(), // Hoặc một loading ban đầu khác
      TaskListLoading() => const Center(child: CircularProgressIndicator()),
      TaskListError(message: final msg) => Center(
          child: Text(
              msg ?? l10n.errorGeneral), // Giả định bạn có l10n.errorGeneral
        ),
      TaskListData(
        tasks: final allTasks,
        // isLoadingMore: final isLoadingMore // UpcomingScreen có thể không cần pagination
      ) =>
        Builder(builder: (context) {
          // Lọc và nhóm các task sắp tới
          final upcomingTasksGrouped = _groupAndFilterUpcomingTasks(allTasks);

          // Sắp xếp các ngày để hiển thị theo thứ tự
          final sortedDates = upcomingTasksGrouped.keys.toList()..sort();

          if (sortedDates.isEmpty) {
            return Center(
                child: Text(
                    l10n.noUpcomingTasks, // Cần thêm vào file localization của bạn
                    style: theme.textTheme.bodySmall));
          }

          return ListView.builder(
            itemCount: sortedDates.length,
            itemBuilder: (context, index) {
              final date = sortedDates[index];
              final tasksForDate = upcomingTasksGrouped[date]!;

              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(
                        left: 16.0, right: 8.0, top: 16.0, bottom: 4.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          _formatDateHeader(context, date),
                          style: theme.textTheme.titleSmall?.copyWith(
                            fontWeight: FontWeight.bold,
                            color: theme.colorScheme.primary, // Hoặc màu khác
                          ),
                        ),
                        Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            IconButton(
                              icon: Icon(Icons.add_circle_outline,
                                  size: 20,
                                  color: theme.iconTheme.color?.withValues(
                                      alpha: .7)), // Sử dụng withOpacity
                              tooltip: l10n
                                  .addTask, // Cần thêm vào file localization
                              onPressed: () {
                                // Cập nhật provider để báo cho HomeScreen và QuickAddBar
                                ref
                                    .read(quickAddIntentProvider.notifier)
                                    .state = date;

                                // HomeScreen sẽ lắng nghe provider này và tự chuyển tab
                                // Không cần ScaffoldMessenger ở đây nữa
                              },
                              splashRadius: 18,
                              visualDensity: VisualDensity.compact,
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                  ListView.builder(
                    shrinkWrap: true,
                    physics:
                        const NeverScrollableScrollPhysics(), // Ngăn cuộn riêng của ListView con
                    itemCount: tasksForDate.length,
                    itemBuilder: (context, taskIndex) {
                      final task = tasksForDate[taskIndex];

                      return TaskTile(
                        task: task,
                        onTap: () {},
                        onCompleted: (bool? value) {
                          ref
                              .read(taskListProvider.notifier)
                              .toggleDone(task.id);
                        },
                      );
                    },
                  ),
                  const Divider(height: 1, indent: 16, endIndent: 16),
                ],
              );
            },
          );
        }),
      _ => Center(
          child: Text(l10n.errorGeneral),
        )
    };
  }
}
