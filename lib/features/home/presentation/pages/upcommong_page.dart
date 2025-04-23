import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
// Giả sử bạn có file định nghĩa TaskModel ở đây
// import 'package:tudy/features/home/data/models/task_model.dart';
// Giả sử bạn có TaskTile ở đây
// import 'package:tudy/features/home/presentation/widgets/task_tile.dart';
// Giả sử bạn có AppLocalizations ở đây
// import 'package:tudy/l10n/app_localizations.dart';

// --- PHẦN GIẢ LẬP DATA VÀ MODEL (Sẽ thay thế bằng Riverpod) ---

// Model Task đơn giản (Bạn hãy dùng TaskModel thật của mình)
class TaskModel {
  final String id;
  final String name;
  final DateTime dueDate;
  bool isDone;
  // Thêm các trường khác nếu cần (priority, description,...)

  TaskModel({
    required this.id,
    required this.name,
    required this.dueDate,
    this.isDone = false,
  });
}

// Dữ liệu giả lập cho UpcomingScreen
final Map<DateTime, List<TaskModel>> upcomingTasksData = {
  DateTime.now().add(const Duration(days: 1)): [
    TaskModel(
        id: 't1',
        name: 'Họp team dự án X',
        dueDate: DateTime.now().add(const Duration(days: 1))),
    TaskModel(
        id: 't2',
        name: 'Chuẩn bị slide thuyết trình',
        dueDate: DateTime.now().add(const Duration(days: 1)),
        isDone: true),
  ],
  DateTime.now().add(const Duration(days: 2)): [
    TaskModel(
        id: 't3',
        name: 'Đi siêu thị mua đồ',
        dueDate: DateTime.now().add(const Duration(days: 2))),
  ],
  DateTime.now().add(const Duration(days: 4)): [
    TaskModel(
        id: 't4',
        name: 'Nộp báo cáo tháng',
        dueDate: DateTime.now().add(const Duration(days: 4))),
    TaskModel(
        id: 't5',
        name: 'Gọi điện cho khách hàng A',
        dueDate: DateTime.now().add(const Duration(days: 4))),
    TaskModel(
        id: 't6',
        name: 'Đặt vé máy bay',
        dueDate: DateTime.now().add(const Duration(days: 4))),
  ],
  // Thêm các ngày và task khác nếu muốn
};

// Widget TaskTile giả lập (Bạn hãy dùng TaskTile thật của mình)
class TaskTilePlaceholder extends StatelessWidget {
  final TaskModel task;
  final VoidCallback onTap;
  final ValueChanged<bool?> onCompleted;

  const TaskTilePlaceholder({
    super.key,
    required this.task,
    required this.onTap,
    required this.onCompleted,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final textStyle = theme.textTheme.bodyMedium?.copyWith(
      decoration: task.isDone ? TextDecoration.lineThrough : null,
      color: task.isDone ? theme.textTheme.bodySmall?.color : null,
    );

    return ListTile(
      leading: Checkbox(
        value: task.isDone,
        onChanged: onCompleted,
        visualDensity: VisualDensity.compact,
        // shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)), // Tùy chỉnh hình dạng nếu muốn
      ),
      title: Text(task.name, style: textStyle),
      onTap: onTap,
      dense: true,
      contentPadding: const EdgeInsets.only(
          left: 16.0, right: 16.0), // Điều chỉnh padding nếu cần
      // Thêm các yếu tố khác như priority indicator nếu TaskTile thật của bạn có
    );
  }
}

// --- KẾT THÚC PHẦN GIẢ LẬP ---

class UpcomingScreen extends StatelessWidget {
  const UpcomingScreen({super.key});

  // Hàm định dạng ngày tháng (ví dụ)
  String _formatDateHeader(BuildContext context, DateTime date) {
    // final l10n = AppLocalizations.of(context); // Dùng khi có AppLocalizations
    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);
    final tomorrow = today.add(const Duration(days: 1));
    final targetDate = DateTime(date.year, date.month, date.day);

    if (targetDate == today) {
      // return l10n.today; // "Hôm nay"
      return "Hôm nay"; // Tạm thời
    } else if (targetDate == tomorrow) {
      // return l10n.tomorrow; // "Ngày mai"
      return "Ngày mai"; // Tạm thời
    } else {
      // Định dạng khác cho các ngày xa hơn, ví dụ: "Thứ Sáu, 25 Thg 4"
      // Cần locale 'vi_VN' để có định dạng tiếng Việt
      // InitializeDateFormatting('vi_VN', null) cần được gọi ở main.dart
      try {
        // Thử định dạng đầy đủ theo Locale
        return DateFormat.MMMMEEEEd('vi_VN').format(date);
      } catch (e) {
        // Dự phòng nếu locale chưa sẵn sàng
        return DateFormat('EEE, dd MMM', 'vi_VN').format(date);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    // final l10n = AppLocalizations.of(context); // Sử dụng khi có AppLocalizations

    // Sắp xếp các ngày theo thứ tự tăng dần
    final sortedDates = upcomingTasksData.keys.toList()..sort();

    return ListView.builder(
      itemCount: sortedDates.length, // Số lượng ngày có task
      itemBuilder: (context, index) {
        final date = sortedDates[index];
        final tasksForDate = upcomingTasksData[date]!;

        // Phần này sẽ xây dựng header cho ngày và danh sách task của ngày đó
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // --- Date Header ---
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
                      color: theme.colorScheme.primary, // Hoặc màu bạn muốn
                    ),
                  ),
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      // Nút "Xem ngày" (Placeholder)
                      IconButton(
                        icon: Icon(Icons.visibility_outlined,
                            size: 20,
                            color: theme.iconTheme.color?.withOpacity(0.7)),
                        tooltip: 'Xem chi tiết ngày', // l10n.viewDayDetails
                        onPressed: () {
                          // TODO: Implement navigation to DayViewScreen with 'date'
                          print('View details for $date');
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                                content: Text(
                                    'Xem chi tiết ngày: ${DateFormat.yMd().format(date)}')),
                          );
                        },
                        splashRadius: 18,
                        visualDensity: VisualDensity.compact,
                      ),
                      // Nút "Thêm Task" (Placeholder)
                      IconButton(
                        icon: Icon(Icons.add_circle_outline,
                            size: 20,
                            color: theme.iconTheme.color?.withOpacity(0.7)),
                        tooltip: 'Thêm công việc', // l10n.addTask
                        onPressed: () {
                          // TODO: Implement showing add task dialog/screen for 'date'
                          print('Add task for $date');
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                                content: Text(
                                    'Thêm công việc cho ngày: ${DateFormat.yMd().format(date)}')),
                          );
                        },
                        splashRadius: 18,
                        visualDensity: VisualDensity.compact,
                      ),
                    ],
                  )
                ],
              ),
            ),

            // --- Task List for the Date ---
            // Sử dụng ListView.builder lồng nhau không tối ưu về hiệu năng nếu list quá dài.
            // Cân nhắc dùng các package như `grouped_list` hoặc cấu trúc phẳng hơn cho list chính nếu hiệu năng là vấn đề.
            // Tuy nhiên, với số lượng task/ngày không quá lớn, cách này vẫn ổn và dễ hiểu.
            ListView.builder(
              shrinkWrap: true, // Quan trọng khi lồng ListView
              physics:
                  const NeverScrollableScrollPhysics(), // Quan trọng khi lồng ListView
              itemCount: tasksForDate.length,
              itemBuilder: (context, taskIndex) {
                final task = tasksForDate[taskIndex];
                // TODO: Tích hợp logic kéo thả ở đây nếu cần. Bọc TaskTilePlaceholder bằng Draggable và DragTarget.
                return TaskTilePlaceholder(
                  task: task,
                  onTap: () {
                    // TODO: Implement navigation to task details screen
                    print('Tap on task: ${task.name}');
                  },
                  onCompleted: (bool? value) {
                    // TODO: Implement toggle done logic using Riverpod
                    print('Toggle task ${task.id} to $value');
                    // Tạm thời cập nhật UI giả lập (không có state management)
                    // Để thấy hiệu ứng, bạn cần chuyển Widget này thành StatefulWidget
                    // và gọi setState khi dữ liệu giả lập thay đổi.
                    // Hiện tại, checkbox sẽ không thay đổi trạng thái trực quan.
                  },
                );
              },
              // Thêm Divider giữa các task nếu muốn
              // separatorBuilder: (context, index) => const Divider(height: 1, indent: 56),
              // itemCount: tasksForDate.length * 2 - 1, // Nếu dùng separatorBuilder
              // itemBuilder: (context, taskIndex) {
              //   if (taskIndex.isOdd) return const Divider(height: 1, indent: 56);
              //   final itemIndex = taskIndex ~/ 2;
              //   // build TaskTile...
              // },
            ),
            const Divider(
                height: 1,
                indent: 16,
                endIndent: 16), // Phân cách giữa các ngày
          ],
        );
      },
    );
  }
}
