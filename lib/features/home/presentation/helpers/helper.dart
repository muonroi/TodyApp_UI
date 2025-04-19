import 'package:tudy/features/home/data/enums/priority_level.dart';
import 'package:tudy/features/home/data/models/task_model.dart';

int compareTasks(TaskModel a, TaskModel b) {
  if (a.isDone != b.isDone) {
    return a.isDone ? 1 : -1;
  }

  int lowestPriorityIndex = PriorityLevel.p4.index + 1;
  final int aPriorityIndex = a.priority?.index ?? lowestPriorityIndex;
  final int bPriorityIndex = b.priority?.index ?? lowestPriorityIndex;

  if (aPriorityIndex != bPriorityIndex) {
    return aPriorityIndex.compareTo(bPriorityIndex);
  }

  final aDueDate = a.dueDate ?? DateTime(9999);
  final bDueDate = b.dueDate ?? DateTime(9999);
  if (aDueDate != bDueDate) {
    return aDueDate.compareTo(bDueDate);
  }

  return a.name.toLowerCase().compareTo(b.name.toLowerCase());
}
