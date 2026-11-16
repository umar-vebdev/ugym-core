/// Formats UTC API timestamps and schedule minute-of-day windows.
abstract final class DateFormatter {
  static const Duration dushanbeOffset = Duration(hours: 5);

  /// Converts [dateTime] to UTC and shifts it by [offset] for wall-clock display.
  static DateTime toTargetZone(
    DateTime dateTime, {
    Duration offset = dushanbeOffset,
  }) {
    return dateTime.toUtc().add(offset);
  }

  /// Parses an ISO-8601 API timestamp and converts it to the target offset.
  static DateTime parseUtcToTargetZone(
    String iso8601, {
    Duration offset = dushanbeOffset,
  }) {
    return toTargetZone(DateTime.parse(iso8601), offset: offset);
  }

  static String formatDate(DateTime dateTime, {Duration? offset}) {
    final dt = _resolveDisplayDateTime(dateTime, offset: offset);
    return '${_twoDigits(dt.day)}.${_twoDigits(dt.month)}.${_fourDigits(dt.year)}';
  }

  static String formatTime(DateTime dateTime, {Duration? offset}) {
    final dt = _resolveDisplayDateTime(dateTime, offset: offset);
    return '${_twoDigits(dt.hour)}:${_twoDigits(dt.minute)}';
  }

  static String formatDateTime(DateTime dateTime, {Duration? offset}) {
    return '${formatDate(dateTime, offset: offset)} ${formatTime(dateTime, offset: offset)}';
  }

  /// Formats minutes from midnight (`0..1439`) as `HH:MM`.
  static String formatMinuteOfDay(int minutesFromMidnight) {
    RangeError.checkValueInInterval(
      minutesFromMidnight,
      0,
      1439,
      'minutesFromMidnight',
    );
    final int hours = minutesFromMidnight ~/ 60;
    final int minutes = minutesFromMidnight % 60;
    return '${_twoDigits(hours)}:${_twoDigits(minutes)}';
  }

  static String formatTimeWindow(int fromMinute, int toMinute) {
    return '${formatMinuteOfDay(fromMinute)}–${formatMinuteOfDay(toMinute)}';
  }

  static DateTime _resolveDisplayDateTime(
    DateTime dateTime, {
    Duration? offset,
  }) {
    if (offset != null) {
      return toTargetZone(dateTime, offset: offset);
    }
    return dateTime.toLocal();
  }

  static String _twoDigits(int value) => value.toString().padLeft(2, '0');

  static String _fourDigits(int value) => value.toString().padLeft(4, '0');
}
