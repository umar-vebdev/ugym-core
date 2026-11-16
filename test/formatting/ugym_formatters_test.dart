import 'package:flutter_test/flutter_test.dart';
import 'package:ugym_core/ugym_core.dart';

void main() {
  group('MoneyFormatter', () {
    test('formats minor units into readable currency strings', () {
      expect(MoneyFormatter.format(25000), '250 TJS');
      expect(MoneyFormatter.format(25050), '250.50 TJS');
      expect(MoneyFormatter.format(1250000), '12 500 TJS');
      expect(
        MoneyFormatter.format(25000, alwaysShowDecimals: true),
        '250.00 TJS',
      );
      expect(MoneyFormatter.format(-550, currency: 'USD'), '-5.50 USD');
    });

    test('parses user strings into exact minor units without float drift', () {
      expect(MoneyFormatter.tryParseToMinorUnits('250'), 25000);
      expect(MoneyFormatter.tryParseToMinorUnits('250.5'), 25050);
      expect(MoneyFormatter.tryParseToMinorUnits('1 250,50'), 125050);
      expect(MoneyFormatter.tryParseToMinorUnits('-0.50'), -50);
      expect(MoneyFormatter.tryParseToMinorUnits('12.345'), isNull);
      expect(MoneyFormatter.tryParseToMinorUnits('abc'), isNull);
    });
  });

  group('WeightFormatter', () {
    test('converts and formats grams and kilograms', () {
      expect(WeightFormatter.gramsToKg(80000), 80.0);
      expect(WeightFormatter.kgToGrams(82.5), 82500);
      expect(WeightFormatter.formatKg(80000), '80 кг');
      expect(WeightFormatter.formatKg(82500), '82.5 кг');
      expect(WeightFormatter.formatKg(82500, includeUnit: false), '82.5');
      expect(WeightFormatter.tryParseKgToGrams('80'), 80000);
      expect(WeightFormatter.tryParseKgToGrams('82,5'), 82500);
      expect(WeightFormatter.tryParseKgToGrams('1.255'), 1255);
      expect(WeightFormatter.tryParseKgToGrams('-5'), isNull);
    });

    test('estimates 1RM using Epley formula', () {
      expect(
        WeightFormatter.estimateOneRepMaxGrams(weightGrams: 80000, reps: 1),
        80000,
      );
      final estimated = WeightFormatter.estimateOneRepMaxGrams(
        weightGrams: 80000,
        reps: 8,
      );
      expect(estimated, 101333);
      expect(WeightFormatter.formatKg(estimated, maxDecimals: 1), '101.3 кг');
      expect(
        WeightFormatter.estimateOneRepMaxGrams(weightGrams: 0, reps: 5),
        0,
      );
    });
  });

  group('DateFormatter', () {
    test('converts UTC ISO-8601 timestamps to Asia/Dushanbe (+05:00)', () {
      final converted = DateFormatter.parseUtcToTargetZone(
        '2026-11-16T19:30:00Z',
      );
      expect(converted.year, 2026);
      expect(converted.month, 11);
      expect(converted.day, 17);
      expect(converted.hour, 0);
      expect(converted.minute, 30);

      final utcDate = DateTime.utc(2026, 11, 16, 19, 30);
      expect(
        DateFormatter.formatDate(utcDate, offset: DateFormatter.dushanbeOffset),
        '17.11.2026',
      );
      expect(
        DateFormatter.formatTime(utcDate, offset: DateFormatter.dushanbeOffset),
        '00:30',
      );
      expect(
        DateFormatter.formatDateTime(
          utcDate,
          offset: DateFormatter.dushanbeOffset,
        ),
        '17.11.2026 00:30',
      );
    });

    test('formats minute-of-day windows and rejects out-of-range values', () {
      expect(DateFormatter.formatMinuteOfDay(0), '00:00');
      expect(DateFormatter.formatMinuteOfDay(420), '07:00');
      expect(DateFormatter.formatMinuteOfDay(1020), '17:00');
      expect(DateFormatter.formatMinuteOfDay(1439), '23:59');
      expect(DateFormatter.formatTimeWindow(420, 1020), '07:00–17:00');
      expect(() => DateFormatter.formatMinuteOfDay(-1), throwsRangeError);
      expect(() => DateFormatter.formatMinuteOfDay(1440), throwsRangeError);
    });
  });
}
