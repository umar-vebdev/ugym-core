/// Converts, formats, and estimates workout weights stored in integer grams.
abstract final class WeightFormatter {
  static double gramsToKg(int weightGrams) => weightGrams / 1000.0;

  static int kgToGrams(num kg) => (kg * 1000).round();

  static int? tryParseKgToGrams(String input) {
    final normalized = input
        .trim()
        .replaceAll(RegExp(r'[\s_]'), '')
        .replaceAll(',', '.');
    if (!RegExp(r'^\d+(?:\.\d{1,3})?$').hasMatch(normalized)) {
      return null;
    }

    final parts = normalized.split('.');
    final int? major = int.tryParse(parts[0]);
    if (major == null) {
      return null;
    }

    final int grams = parts.length == 2
        ? int.parse(parts[1].padRight(3, '0'))
        : 0;
    return major * 1000 + grams;
  }

  static String formatKg(
    int weightGrams, {
    String unit = 'кг',
    bool includeUnit = true,
    int maxDecimals = 2,
  }) {
    final String sign = weightGrams < 0 ? '-' : '';
    final double kg = weightGrams.abs() / 1000.0;
    final int clampedDecimals = maxDecimals.clamp(0, 3);

    var numberText = kg.toStringAsFixed(clampedDecimals);
    if (clampedDecimals > 0) {
      numberText = numberText.replaceFirst(RegExp(r'\.?0+$'), '');
    }

    final String trimmedUnit = unit.trim();
    final String suffix = includeUnit && trimmedUnit.isNotEmpty
        ? ' $trimmedUnit'
        : '';
    return '$sign$numberText$suffix';
  }

  /// Estimates 1RM in grams using the Epley formula.
  static int estimateOneRepMaxGrams({
    required int weightGrams,
    required int reps,
  }) {
    if (weightGrams <= 0 || reps <= 0) {
      return 0;
    }
    if (reps == 1) {
      return weightGrams;
    }
    return (weightGrams * (1 + reps / 30.0)).round();
  }
}
