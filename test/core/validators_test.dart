import 'package:flutter_test/flutter_test.dart';
import 'package:ipon_system/core/utils/validators.dart';

void main() {
  group('validateTargetAmount', () {
    test('requires a minimum target of ₱100', () {
      expect(
        IponValidators.validateTargetAmount('99'),
        'TARGET MUST BE AT LEAST ₱100.',
      );
    });

    test('requires targets in multiples of ₱100', () {
      expect(
        IponValidators.validateTargetAmount('666'),
        'TARGET MUST BE IN MULTIPLES OF ₱100 (e.g., 500, 1000).',
      );
    });

    test('accepts a target of ₱100 and larger multiples', () {
      expect(IponValidators.validateTargetAmount('100'), isNull);
      expect(IponValidators.validateTargetAmount('1500'), isNull);
    });
  });
}
