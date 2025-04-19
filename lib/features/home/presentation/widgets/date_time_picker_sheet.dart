import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:tudy/features/home/data/models/datetime_package_result_model.dart';
import 'package:tudy/l10n/app_localizations.dart';

class DateTimePickerSheet extends StatefulWidget {
  final DateTime? initialDate;
  final TimeOfDay? initialTime;

  const DateTimePickerSheet({
    super.key,
    this.initialDate,
    this.initialTime,
  });

  @override
  State<DateTimePickerSheet> createState() => _DateTimePickerSheetState();
}

class _DateTimePickerSheetState extends State<DateTimePickerSheet> {
  late DateTime _focusedDay;
  DateTime? _selectedDay;
  TimeOfDay? _selectedTime;
  late CalendarFormat _calendarFormat;

  @override
  void initState() {
    super.initState();
    final now = DateTime.now();

    if (widget.initialDate != null) {
      _selectedTime = widget.initialTime;
    } else {
      _selectedTime = null;
    }

    _selectedDay = widget.initialDate;
    _focusedDay = widget.initialDate ?? now;
    _calendarFormat = CalendarFormat.month;
  }

  Future<void> _pickTime() async {
    final initial = _selectedTime ?? TimeOfDay.now();
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: initial,
    );

    if (!mounted || picked == null) return;

    setState(() {
      _selectedTime = picked;

      _selectedDay ??= _focusedDay;
    });
  }

  void _selectQuickOption(DateTime? date, TimeOfDay? time) {
    setState(() {
      _selectedDay = date;
      _selectedTime = time;
      if (date != null) {
        _focusedDay = date;
      }
    });
  }

  void _confirmSelection() {
    if (_selectedDay != null) {
      final finalDateTime = DateTime(
        _selectedDay!.year,
        _selectedDay!.month,
        _selectedDay!.day,
        _selectedTime?.hour ?? 0,
        _selectedTime?.minute ?? 0,
      );
      Navigator.of(context).pop(DateTimePickerResult(
          DateTimePickerResultType.dateTime, finalDateTime));
    } else {
      Navigator.of(context)
          .pop(DateTimePickerResult(DateTimePickerResultType.noDate));
    }
  }

  void _selectNoDate() {
    Navigator.of(context)
        .pop(DateTimePickerResult(DateTimePickerResultType.noDate));
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final theme = Theme.of(context);
    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);
    final tomorrow = today.add(const Duration(days: 1));

    final nextMonday =
        today.add(Duration(days: (DateTime.monday - today.weekday + 7) % 7));

    String formattedTime = l10n.none;
    if (_selectedTime != null) {
      formattedTime = _selectedTime!.format(context);
    }

    String formattedSelectedDate =
        DateFormat.MMMEd().format(_selectedDay ?? _focusedDay);
    if (_selectedDay == null) {
      formattedSelectedDate = "Select a date";
    }

    return Padding(
      padding: EdgeInsets.only(
        bottom: MediaQuery.of(context).viewInsets.bottom +
            MediaQuery.of(context).padding.bottom,
        left: 10,
        right: 10,
        top: 10,
      ),
      child: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                TextButton(
                  onPressed: () => Navigator.of(context).pop(
                      DateTimePickerResult(DateTimePickerResultType.cancelled)),
                  child: Text(l10n.cancel),
                ),
                Text(l10n.date,
                    style: theme.textTheme.titleMedium
                        ?.copyWith(fontWeight: FontWeight.bold)),
                TextButton(
                  onPressed: _confirmSelection,
                  child: Text(l10n.done,
                      style: const TextStyle(fontWeight: FontWeight.bold)),
                ),
              ],
            ),
            const Divider(height: 1),
            ListTile(
              dense: true,
              title: Text(formattedSelectedDate,
                  style: theme.textTheme.titleSmall),
              visualDensity: VisualDensity.compact,
            ),
            ListTile(
              leading:
                  const Icon(Icons.wb_sunny_outlined, color: Colors.orange),
              title: Text(l10n.tomorrow),
              trailing: Text(DateFormat('E').format(tomorrow)),
              onTap: () => _selectQuickOption(tomorrow, null),
              dense: true,
              visualDensity: VisualDensity.compact,
            ),
            ListTile(
              leading:
                  const Icon(Icons.arrow_forward_outlined, color: Colors.blue),
              title: Text(l10n.nextWeek),
              trailing: Text(DateFormat('E').format(nextMonday)),
              onTap: () => _selectQuickOption(nextMonday, null),
              dense: true,
              visualDensity: VisualDensity.compact,
            ),
            ListTile(
              leading: const Icon(Icons.do_not_disturb_on_outlined,
                  color: Colors.grey),
              title: Text(l10n.noDate),
              onTap: _selectNoDate,
              dense: true,
              visualDensity: VisualDensity.compact,
            ),
            const Divider(height: 1),
            TableCalendar(
              locale: Localizations.localeOf(context).toLanguageTag(),
              firstDay: DateTime.utc(2020, 1, 1),
              lastDay: DateTime.utc(2100, 12, 31),
              focusedDay: _focusedDay,
              calendarFormat: _calendarFormat,
              selectedDayPredicate: (day) {
                return isSameDay(_selectedDay, day);
              },
              onDaySelected: (selectedDay, focusedDay) {
                if (!isSameDay(_selectedDay, selectedDay)) {
                  setState(() {
                    _selectedDay = selectedDay;
                    _focusedDay = focusedDay;
                  });
                }
              },
              onFormatChanged: (format) {
                if (_calendarFormat != format) {
                  setState(() {
                    _calendarFormat = format;
                  });
                }
              },
              onPageChanged: (focusedDay) {
                _focusedDay = focusedDay;
              },
              calendarStyle: CalendarStyle(
                selectedDecoration: BoxDecoration(
                  color: theme.colorScheme.primary,
                  shape: BoxShape.circle,
                ),
              ),
              headerStyle: HeaderStyle(
                formatButtonVisible: false,
                titleCentered: true,
                titleTextStyle: theme.textTheme.titleSmall ?? const TextStyle(),
              ),
              daysOfWeekStyle: const DaysOfWeekStyle(),
              availableGestures: AvailableGestures.horizontalSwipe,
              calendarBuilders: const CalendarBuilders(),
            ),
            const Divider(height: 1),
            ListTile(
              leading: const Icon(Icons.access_time_outlined),
              title: Text(l10n.time),
              trailing: Text(formattedTime),
              onTap: _pickTime,
            ),
            const SizedBox(height: 10),
          ],
        ),
      ),
    );
  }
}
