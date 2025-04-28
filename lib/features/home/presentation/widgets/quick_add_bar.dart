import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:tudy/features/home/data/enums/priority_level.dart';
import 'package:tudy/features/home/data/models/category_model.dart';
import 'package:tudy/features/home/data/models/datetime_package_result_model.dart';
import 'package:tudy/features/home/data/models/priority_info.dart';
import 'package:tudy/features/home/data/enums/remider.dart';
import 'package:tudy/features/home/data/models/todo_list_request_model.dart';
import 'package:tudy/features/home/presentation/providers/quickadd_upcoming.dart';
import 'package:tudy/features/home/presentation/providers/task_list/task_list_provider.dart';
import 'package:tudy/features/home/presentation/widgets/date_time_picker_sheet.dart';
import 'package:tudy/l10n/app_localizations.dart';
import 'package:uuid/uuid.dart';

List<Category> mockCategories = [
  Category(
      id: '0e1ed570-3beb-4efa-be59-8b19e4f1beb0',
      name: 'Công việc',
      color: Colors.blue,
      icon: Icons.work),
  Category(
      id: 'cf6b7a28-2155-4db4-a76b-f3d73ca50231',
      name: 'Cá nhân',
      color: Colors.green,
      icon: Icons.person),
  Category(
      id: 'da1fea33-fd8e-4688-aa27-b85ac2d1bbb0',
      name: 'Mua sắm',
      color: Colors.orange,
      icon: Icons.shopping_cart),
];

class QuickAddBar extends ConsumerStatefulWidget {
  const QuickAddBar({super.key});

  @override
  ConsumerState<QuickAddBar> createState() => _QuickAddBarState();
}

class _QuickAddBarState extends ConsumerState<QuickAddBar> {
  final _controller = TextEditingController();
  final _focusNode = FocusNode();
  final LayerLink _priorityLayerLink = LayerLink();
  final LayerLink _categoryLayerLink = LayerLink();
  final LayerLink _alarmLayerLink = LayerLink();
  List<String> _suggestions = [];

  bool _isExpanded = false;
  bool _showSuggestions = false;
  PriorityLevel _selectedPriority = defaultPriority;
  Category? _selectedCategory;
  DateTime? _selectedDate;
  TimeOfDay? _selectedTime;

  TimeOfDay? _selectedReminderTime;
  bool _isReminderRepeating = false;

  @override
  void initState() {
    super.initState();
    _focusNode.addListener(_onFocusChange);
    _controller.addListener(_onTextChanged);
  }

  @override
  void dispose() {
    _controller.removeListener(_onTextChanged);
    _focusNode.removeListener(_onFocusChange);
    _controller.dispose();
    _focusNode.dispose();
    super.dispose();
  }

  void _onFocusChange() {
    if (_focusNode.hasFocus) {
      if (!_isExpanded) {
        setState(() {
          _isExpanded = true;
        });
      }
    } else {
      setState(() {
        _showSuggestions = false;
      });
      _checkCollapse();
    }
  }

  void _onTextChanged() {
    final text = _controller.text;
    if (text.isNotEmpty && _focusNode.hasFocus) {
      _fetchSuggestions(text);
      _parseTextForEntities(text);
      if (!_showSuggestions) setState(() => _showSuggestions = true);
    } else {
      if (_showSuggestions) setState(() => _showSuggestions = false);
    }
  }

  void _fetchSuggestions(String query) {
    setState(() {
      _suggestions = query.isEmpty ? [] : ['$query 1', '$query 2'];
    });
  }

  void _parseTextForEntities(String text) {
    final lowerText = text.toLowerCase();

    if (lowerText.contains('tomorrow') && _selectedDate == null) {
      final tomorrow = DateTime.now().add(const Duration(days: 1));
      setState(() {
        _selectedDate = DateTime(tomorrow.year, tomorrow.month, tomorrow.day);
        _selectedTime = null;
      });
    }

    if (lowerText.contains(' p1') && _selectedPriority == defaultPriority) {
      setState(() => _selectedPriority = PriorityLevel.p1);
    }
    if (lowerText.contains('#công việc') && _selectedCategory == null) {
      final cat = mockCategories.firstWhere(
          (c) => c.name.toLowerCase() == 'công việc',
          orElse: () => mockCategories.first);
      setState(() => _selectedCategory = cat);
    }
  }

  Future<void> _submitTask() async {
    final l10n = AppLocalizations.of(context);
    final taskName = _controller.text.trim();
    if (taskName.isEmpty) return;

    final TimeOfDay? reminderTime = _selectedReminderTime;

    String? reminderTimeStringForBackend;

    if (reminderTime != null) {
      final int hour = reminderTime.hour;
      final int minute = reminderTime.minute;

      final String hourPadded = hour.toString().padLeft(2, '0');
      final String minutePadded = minute.toString().padLeft(2, '0');

      reminderTimeStringForBackend = "0.$hourPadded:$minutePadded:00";
    }

    final selectedPriority = _selectedPriority;

    final selectedDate = _selectedDate;
    final selectedTime = _selectedTime;
    final isReminderRepeating = _isReminderRepeating;

    DateTime? combinedDateTime;
    if (selectedDate != null) {
      combinedDateTime = DateTime(
        selectedDate.year,
        selectedDate.month,
        selectedDate.day,
        selectedTime?.hour ?? 0,
        selectedTime?.minute ?? 0,
      );
    }

    final requestModel = TodoListRequestModel(
        name: taskName,
        isDone: false,
        priority: selectedPriority,
        hasReminder: reminderTime != null,
        description: null,
        dueDate: combinedDateTime,
        reminderTime: reminderTimeStringForBackend,
        reminderRepeats: isReminderRepeating,
        category: _selectedCategory?.id);

    bool success = false;
    try {
      success =
          await ref.read(taskListProvider.notifier).createTask(requestModel);
    } catch (e) {
      success = false;
    } finally {}

    if (success && mounted) {
      setState(() {
        _controller.clear();
        _suggestions = [];
        _showSuggestions = false;
        _selectedPriority = defaultPriority;
        _selectedCategory = null;
        _selectedDate = null;
        _selectedTime = null;
        _selectedReminderTime = null;
        _isReminderRepeating = false;

        if (!_focusNode.hasFocus) {
          _isExpanded = false;
        }
      });
      _focusNode.unfocus();
    } else if (mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(l10n.errorCreatingTask),
          backgroundColor: Theme.of(context).colorScheme.error,
        ),
      );
    }
  }

  void _checkCollapse() {
    if (!_focusNode.hasFocus &&
        _controller.text.isEmpty &&
        _selectedDate == null &&
        _selectedTime == null &&
        _selectedCategory == null &&
        _selectedPriority == defaultPriority &&
        _selectedReminderTime == null) {
      setState(() => _isExpanded = false);
    }
  }

  Future<void> _showReminderPicker() async {
    final l10n = AppLocalizations.of(context);
    final initialTime = _selectedReminderTime ?? TimeOfDay.now();
    final initialRepeat = _isReminderRepeating;

    if (!mounted) return;
    final TimeOfDay? pickedTime = await showTimePicker(
      context: context,
      initialTime: initialTime,
      helpText: l10n.selectReminderTime,
    );

    if (pickedTime == null || !mounted) return;

    bool currentRepeatSettingInDialog = initialRepeat;
    final result = await showDialog<ReminderDialogAction>(
      context: context,
      builder: (dialogContext) {
        return StatefulBuilder(
          builder: (stfContext, stfSetState) {
            return AlertDialog(
              title: Text(l10n.repeatReminder),
              content: SwitchListTile(
                title: Text(l10n.repeatsDaily),
                value: currentRepeatSettingInDialog,
                onChanged: (value) {
                  stfSetState(() {
                    currentRepeatSettingInDialog = value;
                  });
                },
                dense: true,
                contentPadding: EdgeInsets.zero,
              ),
              actions: [
                TextButton(
                  onPressed: () => Navigator.pop(dialogContext),
                  child: Text(l10n.cancel),
                ),
                if (_selectedReminderTime != null)
                  TextButton(
                    onPressed: () => Navigator.pop(
                        dialogContext, ReminderDialogAction.remove),
                    child: Text(l10n.removeReminder,
                        style: TextStyle(
                            color: Theme.of(context).colorScheme.error)),
                  ),
                TextButton(
                  onPressed: () {
                    if (currentRepeatSettingInDialog) {
                      Navigator.pop(
                          dialogContext, ReminderDialogAction.okRepeat);
                    } else {
                      Navigator.pop(
                          dialogContext, ReminderDialogAction.okNoRepeat);
                    }
                  },
                  child: Text(l10n.ok),
                ),
              ],
            );
          },
        );
      },
    );

    if (result == null || !mounted) return;

    setState(() {
      switch (result) {
        case ReminderDialogAction.okRepeat:
          _selectedReminderTime = pickedTime;
          _isReminderRepeating = true;
          _isExpanded = true;
          break;
        case ReminderDialogAction.okNoRepeat:
          _selectedReminderTime = pickedTime;
          _isReminderRepeating = false;
          _isExpanded = true;
          break;
        case ReminderDialogAction.remove:
          _selectedReminderTime = null;
          _isReminderRepeating = false;
          break;
      }
      _checkCollapse();
    });
  }

  Future<void> _showCustomDateTimePicker() async {
    final initialDate = _selectedDate;
    final initialTime = _selectedTime;

    final result = await showModalBottomSheet<DateTimePickerResult>(
      context: context,
      isScrollControlled: true,
      builder: (sheetContext) => DateTimePickerSheet(
        initialDate: initialDate,
        initialTime: initialTime,
      ),
    );

    if (!mounted ||
        result == null ||
        result.type == DateTimePickerResultType.cancelled) {
      return;
    }

    setState(() {
      if (result.type == DateTimePickerResultType.noDate) {
        _selectedDate = null;
        _selectedTime = null;
      } else if (result.type == DateTimePickerResultType.dateTime &&
          result.dateTime != null) {
        final dt = result.dateTime!;
        _selectedDate = DateTime(dt.year, dt.month, dt.day);

        if (dt.hour != 0 || dt.minute != 0) {
          _selectedTime = TimeOfDay(hour: dt.hour, minute: dt.minute);
        } else {
          _selectedTime = null;
        }
      }

      _isExpanded = true;
    });
  }

  Future<void> _showPriorityMenu() async {
    final l10n = AppLocalizations.of(context);
    final theme = Theme.of(context);

    final RenderBox button = context.findRenderObject() as RenderBox;
    final RenderBox overlay =
        Overlay.of(context).context.findRenderObject() as RenderBox;

    final RelativeRect position = RelativeRect.fromRect(
      Rect.fromPoints(
        button.localToGlobal(Offset.zero, ancestor: overlay),
        button.localToGlobal(button.size.bottomRight(Offset.zero),
            ancestor: overlay),
      ),
      Offset.zero & overlay.size,
    );

    final selected = await showMenu<PriorityLevel>(
      context: context,
      position: position.shift(const Offset(0, 40)),
      items: PriorityLevel.values.map((priority) {
        final info = priorityInfoMap[priority]!;
        final bool isSelected = priority == _selectedPriority;
        return PopupMenuItem<PriorityLevel>(
          value: priority,
          child: ListTile(
            leading: Icon(Icons.flag, color: info.color, size: 20),
            title: Text(
              info.getLabel(l10n),
              style: TextStyle(
                color: isSelected ? theme.colorScheme.primary : null,
                fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
              ),
            ),
            dense: true,
            contentPadding: EdgeInsets.zero,
          ),
        );
      }).toList(),
      elevation: 4.0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8.0),
      ),
    );

    if (selected != null) {
      setState(() {
        _selectedPriority = selected;
        _isExpanded = true;
      });
    }
  }

  Future<void> _showCategoryMenu() async {
    final l10n = AppLocalizations.of(context);
    final theme = Theme.of(context);
    final RenderBox button = context.findRenderObject() as RenderBox;
    final RenderBox overlay =
        Overlay.of(context).context.findRenderObject() as RenderBox;
    final RelativeRect position = RelativeRect.fromRect(
      Rect.fromPoints(
        button.localToGlobal(Offset.zero, ancestor: overlay),
        button.localToGlobal(button.size.bottomRight(Offset.zero),
            ancestor: overlay),
      ),
      Offset.zero & overlay.size,
    );

    final categories = mockCategories;

    final selected = await showMenu<Category?>(
      context: context,
      position: position.shift(const Offset(0, 40)),
      items: [
        ...categories.map((category) {
          final bool isSelected = _selectedCategory?.id == category.id;
          return PopupMenuItem<Category?>(
            value: category,
            child: ListTile(
              leading: Icon(category.icon, color: category.color, size: 20),
              title: Text(
                category.name,
                style: TextStyle(
                  color: isSelected ? theme.colorScheme.primary : null,
                  fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                ),
              ),
              dense: true,
              contentPadding: EdgeInsets.zero,
            ),
          );
        }),
        const PopupMenuDivider(),
        PopupMenuItem<Category?>(
          value: null,
          child: ListTile(
            leading:
                Icon(Icons.add, size: 20, color: theme.colorScheme.primary),
            title: Text(
              l10n.createNewCategory,
              style: TextStyle(color: theme.colorScheme.primary),
            ),
            dense: true,
            contentPadding: EdgeInsets.zero,
          ),
        ),
      ],
      elevation: 4.0,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.0)),
    );

    if (!mounted) return;

    if (selected != null) {
      setState(() {
        _selectedCategory = selected;
        _isExpanded = true;
      });
    } else if (selected == null &&
        (ModalRoute.of(context)?.isCurrent ?? false)) {
      await Future.delayed(const Duration(milliseconds: 100));

      if (!mounted) return;
      final newCategory = await _showCreateCategoryDialog();

      if (newCategory != null && mounted) {
        Future.delayed(Duration.zero, () {
          if (mounted) {
            setState(() {
              _selectedCategory = newCategory;
              _isExpanded = true;
            });
          }
        });
      }
    }
  }

  Future<Category?> _showCreateCategoryDialog() async {
    final newCategory = await showDialog<Category>(
      context: context,
      builder: (dialogContext) {
        return const _CreateCategoryDialogContent();
      },
    );
    return newCategory;
  }

  Widget _buildDateTimeChip(AppLocalizations l10n, ThemeData theme) {
    if (_selectedDate == null) return const SizedBox.shrink();

    String label = DateFormat.MMMEd().format(_selectedDate!);
    if (_selectedTime != null) {
      label += ', ${_selectedTime!.format(context)}';
    }

    return Chip(
      avatar: Icon(Icons.calendar_today,
          size: 14, color: theme.colorScheme.primary),
      label: Text(label),
      labelPadding: const EdgeInsets.only(left: 4, right: 2),
      labelStyle: theme.textTheme.labelSmall
          ?.copyWith(color: theme.colorScheme.primary, fontSize: 11),
      onDeleted: () {
        setState(() {
          _selectedDate = null;
          _selectedTime = null;

          if (!_focusNode.hasFocus &&
              _selectedCategory == null &&
              _selectedPriority == defaultPriority) {
            _isExpanded = false;
          }
        });
      },
      deleteIconColor: theme.colorScheme.primary.withValues(alpha: 0.7),
      backgroundColor:
          theme.colorScheme.primaryContainer.withValues(alpha: 0.3),
      visualDensity: VisualDensity.compact,
      padding: EdgeInsets.zero,
      materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
    );
  }

  String _formatReminderTooltip(AppLocalizations l10n) {
    if (_selectedReminderTime == null) return l10n.setReminder;
    String time = _selectedReminderTime!.format(context);
    String tooltip = "${l10n.reminder}: $time";
    if (_isReminderRepeating) {
      tooltip += " (${l10n.repeatsDaily})";
    }
    return tooltip;
  }

  @override
  Widget build(BuildContext context) {
    ref.listen<DateTime?>(quickAddIntentProvider, (previousDate, newDate) {
      if (newDate != null) {
        setState(() {
          _selectedDate = newDate;
          _selectedTime = null;
          _isExpanded = true;
        });
        _focusNode.requestFocus();
        WidgetsBinding.instance.addPostFrameCallback((_) {
          ref.read(quickAddIntentProvider.notifier).state = null;
        });
      }
    });
    final l10n = AppLocalizations.of(context);
    final theme = Theme.of(context);
    final currentPriorityInfo = priorityInfoMap[_selectedPriority]!;

    return Material(
      elevation: _isExpanded ? 4.0 : 1.0,
      color: theme.colorScheme.surface,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 8.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              children: [
                Expanded(
                  child: TextFormField(
                    controller: _controller,
                    focusNode: _focusNode,
                    decoration: InputDecoration(
                      hintText: l10n.addTaskHint,
                      border: InputBorder.none,
                      enabledBorder: InputBorder.none,
                      focusedBorder: InputBorder.none,
                      contentPadding: const EdgeInsets.symmetric(vertical: 8.0),
                      hintStyle: theme.textTheme.bodyMedium?.copyWith(
                          color: theme.colorScheme.onSurface
                              .withValues(alpha: 0.6)),
                    ),
                    style: theme.textTheme.bodyMedium,
                    onFieldSubmitted: (_) => _submitTask(),
                  ),
                ),
                if (_isExpanded) ...[
                  IconButton(
                    icon: const Icon(Icons.calendar_today_outlined),
                    iconSize: 20,
                    tooltip: l10n.date,
                    color: _selectedDate != null
                        ? theme.colorScheme.primary
                        : theme.colorScheme.onSurfaceVariant,
                    onPressed: _showCustomDateTimePicker,
                    splashRadius: 20,
                    padding: EdgeInsets.zero,
                    constraints: const BoxConstraints(),
                  ),
                  const SizedBox(width: 4),
                  CompositedTransformTarget(
                    link: _priorityLayerLink,
                    child: IconButton(
                      icon: Icon(
                        Icons.flag_outlined,
                        size: 20,
                        color: _selectedPriority == defaultPriority
                            ? theme.colorScheme.onSurfaceVariant
                            : currentPriorityInfo.color,
                      ),
                      tooltip: l10n.priority,
                      onPressed: _showPriorityMenu,
                      splashRadius: 20,
                      padding: EdgeInsets.zero,
                      constraints: const BoxConstraints(),
                    ),
                  ),
                  const SizedBox(width: 4),
                  CompositedTransformTarget(
                    link: _categoryLayerLink,
                    child: IconButton(
                      icon: Icon(
                        _selectedCategory?.icon ?? Icons.label_outline,
                        size: 20,
                        color: _selectedCategory?.color ??
                            theme.colorScheme.onSurfaceVariant,
                      ),
                      tooltip: _selectedCategory?.name,
                      onPressed: _showCategoryMenu,
                      splashRadius: 20,
                      padding: EdgeInsets.zero,
                      constraints: const BoxConstraints(),
                    ),
                  ),
                  const SizedBox(width: 4),
                  CompositedTransformTarget(
                    link: _alarmLayerLink,
                    child: IconButton(
                      icon: Icon(
                        _selectedReminderTime != null
                            ? Icons.alarm_on
                            : Icons.alarm_outlined,
                        size: 20,
                        color: _selectedReminderTime != null
                            ? theme.colorScheme.primary
                            : theme.colorScheme.onSurfaceVariant,
                      ),
                      tooltip: _selectedReminderTime != null
                          ? _formatReminderTooltip(l10n)
                          : l10n.setReminder,
                      onPressed: _showReminderPicker,
                      splashRadius: 20,
                      padding: EdgeInsets.zero,
                      constraints: const BoxConstraints(),
                    ),
                  ),
                ],
                const SizedBox(width: 8),
                if (_controller.text.isNotEmpty ||
                    _selectedDate != null ||
                    _selectedCategory != null ||
                    _selectedPriority != defaultPriority)
                  IconButton(
                    icon: const Icon(Icons.arrow_upward),
                    iconSize: 22,
                    style: IconButton.styleFrom(
                        backgroundColor: theme.colorScheme.primary,
                        foregroundColor: theme.colorScheme.onPrimary,
                        padding: const EdgeInsets.all(6)),
                    tooltip: l10n.submitTask,
                    onPressed: _submitTask,
                    constraints: const BoxConstraints(),
                    splashRadius: 20,
                  )
                else
                  const SizedBox(width: 44),
              ],
            ),
            if (_isExpanded &&
                (_selectedDate != null ||
                    _selectedPriority != defaultPriority ||
                    _selectedCategory != null))
              Padding(
                padding: const EdgeInsets.only(top: 4.0, left: 0.0, right: 0.0),
                child: Wrap(spacing: 6.0, runSpacing: 0.0, children: [
                  _buildDateTimeChip(l10n, theme),
                  if (_selectedPriority != defaultPriority)
                    Chip(
                      avatar: Icon(Icons.flag,
                          size: 14, color: currentPriorityInfo.color),
                      label: Text(currentPriorityInfo.getLabel(l10n)),
                      labelPadding: const EdgeInsets.only(left: 4, right: 2),
                      labelStyle: theme.textTheme.labelSmall?.copyWith(
                          color: currentPriorityInfo.color, fontSize: 11),
                      onDeleted: () {
                        setState(() {
                          _selectedPriority = defaultPriority;

                          if (!_focusNode.hasFocus &&
                              _selectedDate == null &&
                              _selectedCategory == null) {
                            _isExpanded = false;
                          }
                        });
                      },
                      deleteIconColor:
                          currentPriorityInfo.color.withValues(alpha: 0.7),
                      backgroundColor:
                          currentPriorityInfo.color.withValues(alpha: 0.1),
                      visualDensity: VisualDensity.compact,
                      padding: EdgeInsets.zero,
                      materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                    ),
                  if (_selectedCategory != null)
                    Chip(
                      avatar: Icon(_selectedCategory!.icon,
                          size: 14, color: _selectedCategory!.color),
                      label: Text(_selectedCategory!.name),
                      labelPadding: const EdgeInsets.only(left: 4, right: 2),
                      labelStyle: theme.textTheme.labelSmall?.copyWith(
                          color: _selectedCategory!.color, fontSize: 11),
                      onDeleted: () {
                        setState(() {
                          _selectedCategory = null;

                          if (!_focusNode.hasFocus &&
                              _selectedDate == null &&
                              _selectedPriority == defaultPriority) {
                            _isExpanded = false;
                          }
                        });
                      },
                      deleteIconColor:
                          _selectedCategory!.color?.withValues(alpha: 0.7),
                      backgroundColor:
                          _selectedCategory!.color?.withValues(alpha: 0.1),
                      visualDensity: VisualDensity.compact,
                      padding: EdgeInsets.zero,
                      materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                    ),
                  if (_selectedReminderTime != null)
                    Chip(
                      avatar: Icon(Icons.alarm,
                          size: 14, color: theme.colorScheme.primary),
                      label: Text(
                          '${_selectedReminderTime!.format(context)}${_isReminderRepeating ? ' (${l10n.dailyShort})' : ''}'),
                      labelPadding: const EdgeInsets.only(left: 4, right: 2),
                      labelStyle: theme.textTheme.labelSmall?.copyWith(
                          color: theme.colorScheme.primary, fontSize: 11),
                      onDeleted: () {
                        setState(() {
                          _selectedReminderTime = null;
                          _isReminderRepeating = false;
                          _checkCollapse();
                        });
                      },
                      deleteIconColor: theme.colorScheme.primary.withAlpha(180),
                      backgroundColor:
                          theme.colorScheme.primaryContainer.withAlpha(70),
                      visualDensity: VisualDensity.compact,
                      padding: EdgeInsets.zero,
                      materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                    ),
                ]),
              ),
            if (_showSuggestions && _suggestions.isNotEmpty)
              ConstrainedBox(
                constraints: const BoxConstraints(maxHeight: 100),
                child: ListView.builder(
                  shrinkWrap: true,
                  padding: const EdgeInsets.only(top: 6.0),
                  itemCount: _suggestions.length,
                  itemBuilder: (context, index) {
                    final suggestion = _suggestions[index];
                    return ListTile(
                      dense: true,
                      contentPadding: const EdgeInsets.symmetric(
                          horizontal: 16.0, vertical: 0),
                      title:
                          Text(suggestion, style: theme.textTheme.bodyMedium),
                      onTap: () {
                        _controller.text = suggestion;
                        _controller.selection = TextSelection.fromPosition(
                            TextPosition(offset: _controller.text.length));
                        setState(() {
                          _showSuggestions = false;

                          _parseTextForEntities(suggestion);
                        });
                      },
                    );
                  },
                ),
              ),
          ],
        ),
      ),
    );
  }
}

class _CreateCategoryDialogContent extends StatefulWidget {
  const _CreateCategoryDialogContent();

  @override
  State<_CreateCategoryDialogContent> createState() =>
      _CreateCategoryDialogContentState();
}

class _CreateCategoryDialogContentState
    extends State<_CreateCategoryDialogContent> {
  late final TextEditingController _categoryNameController;

  @override
  void initState() {
    super.initState();
    _categoryNameController = TextEditingController();
  }

  @override
  void dispose() {
    _categoryNameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);

    return AlertDialog(
      title: Text(l10n.createNewCategory),
      content: TextFormField(
        controller: _categoryNameController,
        autofocus: true,
        decoration: InputDecoration(hintText: l10n.categoryNameHint),
        textCapitalization: TextCapitalization.sentences,
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: Text(l10n.cancel),
        ),
        TextButton(
          onPressed: () {
            final name = _categoryNameController.text.trim();
            if (name.isNotEmpty) {
              final newCat = Category(
                id: const Uuid().v4(),
                name: name,
              );

              mockCategories.add(newCat);

              Navigator.pop(context, newCat);
            }
          },
          child: Text(l10n.create),
        ),
      ],
    );
  }
}
