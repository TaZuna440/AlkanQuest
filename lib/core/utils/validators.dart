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

  static final RegExp _nameRegex = RegExp(r"^[a-zA-Z0-9 _\-']+$");

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
}
