import 'package:tudy/features/home/data/enums/priority_level.dart';

class TodoListRequestModel {
  final String name;
  bool isDone;
  DateTime? dueDate;
  PriorityLevel? priority;
  bool hasReminder;
  String? description;
  final String? reminderTime;
  final bool? reminderRepeats;
  String? category;

  TodoListRequestModel(
      {required this.name,
      this.isDone = false,
      this.dueDate,
      this.priority,
      this.hasReminder = false,
      this.description,
      this.reminderTime,
      this.reminderRepeats = false,
      this.category});
  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'isDone': isDone,
      'dueDate': dueDate?.toIso8601String(),
      'priority': priority?.index,
      'hasReminder': hasReminder,
      'description': description,
      'reminderTime': reminderTime ?? reminderTime,
      'reminderRepeats': reminderRepeats,
      'category': category,
    };
  }
}
