enum DateTimePickerResultType { cancelled, noDate, dateTime }

class DateTimePickerResult {
  final DateTimePickerResultType type;
  final DateTime? dateTime;

  DateTimePickerResult(this.type, [this.dateTime]);
}
