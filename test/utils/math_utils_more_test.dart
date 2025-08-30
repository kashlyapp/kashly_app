import 'package:flutter_test/flutter_test.dart';
import 'package:kashly_app/utils/math_utils.dart';

void main() {
  group('add', () {
    test('associativity', () {
      expect(add(add(1, 2), 3), add(1, add(2, 3)));
    });
    test('negatives', () {
      expect(add(-2, -3), -5);
      expect(add(-2, 3), 1);
    });
  });
  group('clamp', () {
    test('edges', () {
      expect(clamp(0, min: 0, max: 10), 0);
      expect(clamp(5, min: 0, max: 10), 5);
      expect(clamp(10, min: 0, max: 10), 10);
    });
    test('below/above', () {
      expect(clamp(-1, min: 0, max: 10), 0);
      expect(clamp(11, min: 0, max: 10), 10);
    });
  });
}
