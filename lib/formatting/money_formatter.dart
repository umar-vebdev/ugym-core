/// Formats and parses monetary values stored in integer minor units.
abstract final class MoneyFormatter {
  static String format(
    int minorUnits, {
    String currency = 'TJS',
    bool alwaysShowDecimals = false,
  }) {
    final String sign = minorUnits < 0 ? '-' : '';
    final int absMinor = minorUnits.abs();
    final int major = absMinor ~/ 100;
    final int remainder = absMinor % 100;

    final String majorText = _groupThousands(major);
    final String decimals = (remainder != 0 || alwaysShowDecimals)
        ? '.${remainder.toString().padLeft(2, '0')}'
        : '';
    final String trimmedCurrency = currency.trim();
    final String suffix = trimmedCurrency.isEmpty ? '' : ' $trimmedCurrency';

    return '$sign$majorText$decimals$suffix';
  }

  static int? tryParseToMinorUnits(String input) {
    final normalized = input
        .trim()
        .replaceAll(RegExp(r'[\s_]'), '')
        .replaceAll(',', '.');
    if (!RegExp(r'^-?\d+(?:\.\d{1,2})?$').hasMatch(normalized)) {
      return null;
    }

    final bool isNegative = normalized.startsWith('-');
    final String unsigned = isNegative ? normalized.substring(1) : normalized;
    final parts = unsigned.split('.');

    final int? major = int.tryParse(parts[0]);
    if (major == null) {
      return null;
    }

    final int minor = parts.length == 2
        ? int.parse(parts[1].padRight(2, '0'))
        : 0;
    final int total = major * 100 + minor;
    return isNegative ? -total : total;
  }

  static String _groupThousands(int value) {
    final digits = value.toString();
    if (digits.length <= 3) {
      return digits;
    }

    final buffer = StringBuffer();
    for (var i = 0; i < digits.length; i++) {
      if (i > 0 && (digits.length - i) % 3 == 0) {
        buffer.write(' ');
      }
      buffer.write(digits[i]);
    }
    return buffer.toString();
  }
}
