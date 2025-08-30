import 'package:flutter_test/flutter_test.dart';
import 'package:kashly_app/utils/math_utils.dart';

void main() {
  group('math_utils more', () {
    test('add associativity', () {
      expect(add(add(1, 2), 3), add(1, add(2, 3)));
    });

    test('clamp edges', () {
      expect(clamp(0, min: 0, max: 10), 0);
      expect(clamp(10, min: 0, max: 10), 10);
    });
  });
}
