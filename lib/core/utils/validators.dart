import 'money_formatter.dart';

class IponValidators {
  IponValidators._();

  static const Set<String> reservedNames = {
    'SYSTEM',
    'HUNTER',
    'ADMIN',
    'GUEST',
    'NULL',
    'UNDEFINED',
    'IPON',
  };

  static const int maxTargetPesos = 100000000;

  static final RegExp _nameRegex = RegExp(r"^[a-zA-Z0-9 _\-']+$");
  static final RegExp _questNameRegex = RegExp(r"^[a-zA-Z0-9 _\-',.]+$");

  static String? validateDisplayName(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'NAME IS REQUIRED.';
    }
    final trimmed = value.trim();
    if (trimmed.length > 24) {
      return 'NAME MUST BE 24 CHARACTERS OR LESS.';
    }
    if (!_nameRegex.hasMatch(trimmed)) {
      return "NAME CAN ONLY CONTAIN LETTERS, NUMBERS, SPACES, - _ AND '.";
    }
    if (reservedNames.contains(trimmed.toUpperCase())) {
      return 'THAT NAME IS RESERVED. CHOOSE ANOTHER.';
    }
    return null;
  }

  static String? validateChallengeName(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'QUEST NAME IS REQUIRED.';
    }
    final trimmed = value.trim();
    if (trimmed.length > 40) {
      return 'QUEST NAME MUST BE 40 CHARACTERS OR LESS.';
    }
    if (!_questNameRegex.hasMatch(trimmed)) {
      return 'USE LETTERS, NUMBERS, SPACES AND BASIC PUNCTUATION ONLY.';
    }
    return null;
  }

  /// Validates target amount. Order of checks matters:
  /// 1. empty
  /// 2. not a number
  /// 3. zero or negative
  /// 4. too large (> max)
  /// 5. falls back to cents-parse for final check
  static String? validateTargetAmount(String? value) {
    final cleaned = (value ?? '').replaceAll(RegExp(r'[₱,\s]'), '');
    if (cleaned.isEmpty) return 'TARGET AMOUNT IS REQUIRED.';

    // Use double.tryParse to check magnitude without int64 overflow
    final numeric = double.tryParse(cleaned);
    if (numeric == null) return 'ENTER A VALID AMOUNT.';
    if (numeric <= 0) return 'TARGET MUST BE GREATER THAN ₱0.';
    if (numeric > maxTargetPesos) {
      return 'MAXIMUM TARGET IS ₱100,000,000.';
    }

    final cents = MoneyFormatter.parseToCents(value!);
    if (cents == null || cents <= 0) return 'ENTER A VALID AMOUNT.';
    return null;
  }

  static String? validateStartingAmount(String? value, int targetCents) {
    if (value == null || value.trim().isEmpty) return null;
    final cleaned = value.replaceAll(RegExp(r'[₱,\s]'), '');

    final numeric = double.tryParse(cleaned);
    if (numeric == null) return 'ENTER A VALID AMOUNT.';
    if (numeric < 0) return 'AMOUNT CANNOT BE NEGATIVE.';
    if (numeric > maxTargetPesos) {
      return 'MAXIMUM AMOUNT IS ₱100,000,000.';
    }

    final cents = MoneyFormatter.parseToCents(value);
    if (cents == null) return 'ENTER A VALID AMOUNT.';
    if (cents >= targetCents) {
      return 'STARTING AMOUNT MUST BE LESS THAN THE TARGET.';
    }
    return null;
  }

  static String? validateTargetDate(DateTime? date) {
    if (date == null) return 'TARGET DATE IS REQUIRED.';
    return null;
  }
}
