import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:tudy/features/home/data/models/category_model.dart';
import 'package:tudy/features/home/data/providers/home_repository.dart';
import 'package:tudy/l10n/app_localizations.dart';
import '../../data/models/task_model.dart';

import 'package:tudy/features/home/data/models/priority_info.dart';

class TaskTile extends ConsumerWidget {
  final TaskModel task;
  final ValueChanged<bool?>? onCompleted;
  final VoidCallback? onTap;

  const TaskTile({
    super.key,
    required this.task,
    this.onCompleted,
    this.onTap,
  });

  String _formatDueDate(DateTime? dueDate, BuildContext context) {
    if (dueDate == null) return '';
    final l10n = AppLocalizations.of(context);
    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);
    final tomorrow = today.add(const Duration(days: 1));
    final yesterday = today.subtract(const Duration(days: 1));
    final dueDay = DateTime(dueDate.year, dueDate.month, dueDate.day);

    if (dueDay == today) return l10n.today;
    if (dueDay == tomorrow) return l10n.tomorrow;
    if (dueDay == yesterday) return l10n.yesterday;

    if (dueDate.year == now.year) {
      return DateFormat('E, MMM d', l10n.localeName).format(dueDate);
    } else {
      return DateFormat('E, MMM d, y', l10n.localeName).format(dueDate);
    }
  }

  Color _getDateColor(
      DateTime? dueDate, ThemeData theme, BuildContext context) {
    if (dueDate == null) return theme.disabledColor.withAlpha(128);
    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);
    final dueDay = DateTime(dueDate.year, dueDate.month, dueDate.day);

    if (task.isDone) return theme.disabledColor.withAlpha(178);

    if (dueDay.isBefore(today)) return Colors.red.shade700;
    if (dueDay == today) return Colors.blue.shade800;
    return theme.colorScheme.onSurfaceVariant.withAlpha(204);
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    final priorityInfo =
        task.priority != null ? priorityInfoMap[task.priority!] : null;

    final allCategories = ref.watch(categoryListProvider);
    Category? taskCategory;
    if (task.categoryId != null) {
      try {
        taskCategory =
            allCategories.firstWhere((cat) => cat.id == task.categoryId);
      } catch (e) {
        taskCategory = null;
      }
    }

    final subtitleStyle = theme.textTheme.bodySmall?.copyWith(
      color: task.isDone
          ? theme.disabledColor.withAlpha(178)
          : theme.colorScheme.onSurfaceVariant.withAlpha(204),
      fontSize: 11,
    );

    final iconColor = task.isDone
        ? theme.disabledColor.withAlpha(178)
        : theme.colorScheme.onSurfaceVariant.withAlpha(204);

    final bool hasDueDate = task.dueDate != null;

    final bool hasTime = hasDueDate &&
        (task.dueDate!.hour != 0 ||
            task.dueDate!.minute != 0 ||
            task.dueDate!.second != 0);

    final String dateText =
        hasDueDate ? _formatDueDate(task.dueDate, context) : '';
    final Color dateColor = _getDateColor(task.dueDate, theme, context);
    final l10n = AppLocalizations.of(context);

    final String timeText = hasDueDate && hasTime
        ? DateFormat.Hm(l10n.localeName).format(task.dueDate!)
        : '';

    final TimeOfDay? reminderTime = task.parsedReminderTime;

    String formattedReminderTime = "";

    if (reminderTime != null) {
      formattedReminderTime = MaterialLocalizations.of(context)
          .formatTimeOfDay(reminderTime, alwaysUse24HourFormat: true);
    }
    final Color reminderColor = theme.colorScheme.tertiary.withAlpha(230);

    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 1),
              child: Checkbox(
                value: task.isDone,
                onChanged: onCompleted,
                activeColor: Colors.blue.shade800,
                visualDensity: const VisualDensity(horizontal: 0, vertical: -2),
                materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
              ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.only(left: 6.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      task.name,
                      style: TextStyle(
                        fontSize: 14.5,
                        decoration:
                            task.isDone ? TextDecoration.lineThrough : null,
                        color: task.isDone
                            ? theme.disabledColor.withAlpha(178)
                            : theme.colorScheme.onSurface,
                        fontWeight:
                            task.isDone ? FontWeight.normal : FontWeight.w500,
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 3.0),
                      child: Wrap(
                        spacing: 6.0,
                        runSpacing: 2.0,
                        crossAxisAlignment: WrapCrossAlignment.center,
                        children: [
                          if (hasDueDate)
                            Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Icon(Icons.calendar_today_outlined,
                                    size: 11, color: dateColor),
                                const SizedBox(width: 3),
                                Text(dateText,
                                    style: subtitleStyle?.copyWith(
                                        color: dateColor)),
                                if (timeText.isNotEmpty)
                                  Padding(
                                    padding: const EdgeInsets.only(left: 3.0),
                                    child: Text(timeText,
                                        style: subtitleStyle?.copyWith(
                                            color: dateColor)),
                                  ),
                              ],
                            ),
                          if (taskCategory != null)
                            Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Icon(taskCategory.icon ?? Icons.label_outline,
                                    size: 11,
                                    color: taskCategory.color ?? iconColor),
                                const SizedBox(width: 3),
                                Text(taskCategory.name,
                                    style: subtitleStyle?.copyWith()),
                              ],
                            ),
                          if (reminderTime != null)
                            Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Icon(
                                  task.reminderRepeats == true
                                      ? Icons.repeat_on_outlined
                                      : Icons.alarm_on_outlined,
                                  size: 11,
                                  color: reminderColor,
                                ),
                                const SizedBox(width: 3),
                                Text(
                                  formattedReminderTime,
                                  style: subtitleStyle?.copyWith(
                                      color: reminderColor),
                                ),
                              ],
                            ),
                          if (task.description != null &&
                              task.description!.isNotEmpty)
                            Icon(Icons.notes_outlined,
                                size: 12, color: iconColor),
                          if (priorityInfo != null &&
                              task.priority != defaultPriority)
                            Icon(Icons.flag,
                                size: 12, color: priorityInfo.color),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
