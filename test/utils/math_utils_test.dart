import 'package:flutter_test/flutter_test.dart';
import 'package:kashly_app/utils/math_utils.dart';

void main() {
  group('math_utils', () {
    test('add suma correctament', () {
      expect(add(2, 2), 4);
      expect(add(-1, 1), 0);
      expect(add(0, 0), 0);
  expect(add(1000, -999), 1);
    });

    test('clamp limita dins d\'un interval', () {
      expect(clamp(5, min: 0, max: 10), 5);
      expect(clamp(-5, min: 0, max: 10), 0);
      expect(clamp(15, min: 0, max: 10), 10);
  expect(clamp(10, min: 10, max: 10), 10);
    });
  });
}
