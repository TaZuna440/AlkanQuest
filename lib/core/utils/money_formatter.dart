class MoneyFormatter {
  MoneyFormatter._();

  /// Max we accept in pesos. ₱100,000,000 = 10,000,000,000 cents.
  static const int maxCents = 10000000000;

  /// Parse "1,000" or "1000.50" or "₱1500" → cents (int).
  /// Returns null on parse failure or overflow.
  static int? parseToCents(String input) {
    final cleaned = input.replaceAll(RegExp(r'[₱,\s]'), '');
    if (cleaned.isEmpty) return null;
    final parts = cleaned.split('.');
    if (parts.length > 2) return null;

    final wholeStr = parts[0].isEmpty ? '0' : parts[0];
    if (wholeStr.length > 15) return null; // guard against int64 overflow

    final fractionStr =
        parts.length == 2 ? '${parts[1]}00'.substring(0, 2) : '00';
    final whole = int.tryParse(wholeStr);
    final fraction = int.tryParse(fractionStr);
    if (whole == null || fraction == null) return null;

    // Whole pesos must be <= 100,000,000 (10 billion cents ceiling)
    if (whole > 100000000) return null;

    return whole * 100 + fraction;
  }

  /// 10000 → "₱100"  |  10050 → "₱100.50"  |  1000000 → "₱10,000"
  static String format(int cents) {
    final negative = cents < 0;
    final abs = cents.abs();
    final pesos = abs ~/ 100;
    final rem = abs % 100;
    final buffer = StringBuffer();
    final pesoStr = pesos.toString();
    for (int i = 0; i < pesoStr.length; i++) {
      if (i > 0 && (pesoStr.length - i) % 3 == 0) buffer.write(',');
      buffer.write(pesoStr[i]);
    }
    final out = rem == 0
        ? '₱$buffer'
        : '₱$buffer.${rem.toString().padLeft(2, '0')}';
    return negative ? '-$out' : out;
  }
}
