import 'package:flutter_test/flutter_test.dart';
import 'package:kashly_app/utils/ci_gate_probe.dart';

void main() {
  test('ciAdd funciona', () {
    expect(ciAdd(2, 3), 5);
  });

  test('ciIsPositive', () {
    expect(ciIsPositive(1), isTrue);
    expect(ciIsPositive(0), isFalse);
  });
}
