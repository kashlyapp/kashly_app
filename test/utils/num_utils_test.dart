import 'package:flutter_test/flutter_test.dart';
import 'package:kashly_app/utils/num_utils.dart';

void main() {
  test('sum and average', () {
    expect(NumUtils.sum([1, 2, 3, 4]), 10);
    expect(NumUtils.average([1, 2, 3, 4]), 2.5);
    expect(NumUtils.average([]), 0);
  });

  test('isBetween', () {
    expect(NumUtils.isBetween(5, 1, 5), isTrue);
    expect(NumUtils.isBetween(5, 1, 5, inclusive: false), isFalse);
    expect(NumUtils.isBetween(3, 1, 5, inclusive: false), isTrue);
  });

  test('gcd', () {
    expect(NumUtils.gcd(54, 24), 6);
    expect(NumUtils.gcd(-54, 24), 6);
    expect(NumUtils.gcd(0, 5), 5);
  });
}
