import 'package:flutter/material.dart';
import 'package:tudy/features/home/data/enums/priority_level.dart';

TimeOfDay? _parseTimeOfDay(String? timeString) {
  if (timeString == null) return null;
  final parts = timeString.split(':');
  if (parts.length >= 2) {
    final hour = int.parse(parts[0]);
    final minute = int.parse(parts[1]);

    return TimeOfDay(hour: hour, minute: minute);
  }
  return null;
}

class TaskModel {
  final String id;
  final String name;
  bool isDone;
  DateTime? dueDate;
  PriorityLevel? priority;
  String? projectName;
  bool hasReminder;
  String? description;
  final String? reminderTime;
  final TimeOfDay? parsedReminderTime;
  final bool? reminderRepeats;
  String? categoryId;

  TaskModel(
      {required this.id,
      required this.name,
      this.isDone = false,
      this.dueDate,
      this.priority,
      this.projectName,
      this.hasReminder = false,
      this.description,
      this.reminderTime,
      this.reminderRepeats = false,
      this.categoryId,
      this.parsedReminderTime});
  TaskModel copyWith({
    String? id,
    String? name,
    bool? isDone,
    DateTime? dueDate,
    PriorityLevel? priority,
    String? projectName,
    bool? hasReminder,
    String? description,
    String? reminderTime,
    bool? reminderRepeats,
    String? categoryId,
    TimeOfDay? parsedReminderTime,
  }) {
    return TaskModel(
      id: id ?? this.id,
      name: name ?? this.name,
      isDone: isDone ?? this.isDone,
      dueDate: dueDate ?? this.dueDate,
      priority: priority ?? this.priority,
      projectName: projectName ?? this.projectName,
      hasReminder: hasReminder ?? this.hasReminder,
      description: description ?? this.description,
      reminderTime: reminderTime ?? this.reminderTime,
      reminderRepeats: reminderRepeats ?? this.reminderRepeats,
      categoryId: categoryId ?? this.categoryId,
      parsedReminderTime: parsedReminderTime ?? this.parsedReminderTime,
    );
  }

  // Bên trong class TaskModel

  factory TaskModel.fromJson(Map<String, dynamic> json) {
    final TimeOfDay? parsedReminderTime =
        _parseTimeOfDay(json['reminderTime'] as String?);

    final String? entityId = json['entityId'] as String?;
    final String? name = json['name'] as String?;

    if (entityId == null) {
      throw FormatException(
          "Missing required field 'entityId' in TaskModel JSON: $json");
    }
    if (name == null) {
      throw FormatException(
          "Missing required field 'name' in TaskModel JSON: $json");
    }

    // --- XỬ LÝ dueDate VÀ CHUYỂN SANG LOCAL TIME ---
    DateTime? localDueDate; // Biến để lưu kết quả Local Time
    if (json['dueDate'] != null && json['dueDate'] is String) {
      try {
        // 1. Parse chuỗi UTC từ JSON
        DateTime utcDueDate = DateTime.parse(json['dueDate'] as String);
        // 2. Chuyển đổi sang múi giờ Local của thiết bị
        localDueDate = utcDueDate.toLocal();
      } catch (e) {
        // Xử lý nếu chuỗi không đúng định dạng DateTime
        debugPrint("Error parsing dueDate string: ${json['dueDate']} - $e");
        localDueDate = null; // Gán null nếu parse lỗi
      }
    } else {
      localDueDate =
          null; // Gán null nếu key 'dueDate' không có hoặc không phải string
    }
    // --- KẾT THÚC XỬ LÝ dueDate ---

    return TaskModel(
      id: entityId,
      name: name,
      isDone: json['isDone'] as bool? ?? false,
      dueDate: localDueDate, // <<< Gán DateTime đã được chuyển sang Local
      priority: json['priority'] != null && json['priority'] is int
          ? ((json['priority'] as int) >= 0 &&
                  (json['priority'] as int) < PriorityLevel.values.length
              ? PriorityLevel.values[json['priority'] as int]
              : null)
          : null,
      categoryId: json['category'] as String?,
      hasReminder: json['hasReminder'] as bool? ?? false,
      description: json['description'] as String?,
      parsedReminderTime: parsedReminderTime,
      reminderRepeats: json['reminderRepeats'] as bool? ?? false,
    );
  }
}
