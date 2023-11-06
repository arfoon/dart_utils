import 'utils.dart';

extension DateTimeExtensions on DateTime {
  String get dayMonthYearString => '$day/$month/$year';
  String get dayMonthYearTimeString => '$day/$month/$year $timeString';
  String get timeString => DateFormat('h:m a').format(this);

  DateTime get withCurrentTime {
    final now = DateTime.now();
    return copyWith(hour: now.hour, minute: now.minute, second: now.second);
  }

  DateTime applyDate(DateTime date) {
    return copyWith(
      day: date.day,
      month: date.month,
      year: date.year,
    );
  }

  DateTime get startOfDay {
    return copyWith(
      hour: 0,
      minute: 0,
      second: 0,
      microsecond: 0,
      millisecond: 0,
    );
  }

  DateTime get endOfDay {
    return copyWith(
      hour: 23,
      minute: 59,
      second: 59,
      microsecond: 0,
      millisecond: 0,
    );
  }

  bool isSameDay(DateTime date) {
    return day == date.day && month == date.month && year == date.year;
  }

  bool isSameTime(DateTime date) {
    return hour == date.hour && minute == date.minute && second == date.second;
  }

  DateTime copyWith({
    int? year,
    int? month,
    int? day,
    int? hour,
    int? minute,
    int? second,
    int? millisecond,
    int? microsecond,
  }) {
    return DateTime(
      year ?? this.year,
      month ?? this.month,
      day ?? this.day,
      hour ?? this.hour,
      minute ?? this.minute,
      second ?? this.second,
      millisecond ?? this.millisecond,
      microsecond ?? this.microsecond,
    );
  }
}
