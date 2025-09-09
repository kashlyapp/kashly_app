// test/utils/ci_gate_probe_test.dart
import 'package:flutter_test/flutter_test.dart';
import 'package:kashly_app/utils/ci_gate_probe.dart';

void main() {
  group('ci_gate_probe utils', () {
    test('safeAdd suma correcta', () {
      expect(safeAdd(2, 3), 5);
      expect(safeAdd(-2, 1), -1);
    });

    test('isEven detecta parells i imparells', () {
      expect(isEven(0), isTrue);
      expect(isEven(1), isFalse);
      expect(isEven(2), isTrue);
    });

    test('clamp limita valors', () {
      expect(clamp(5, 0, 10), 5);
      expect(clamp(-1, 0, 10), 0);
      expect(clamp(11, 0, 10), 10);
    });

    test('clamp llança si min > max', () {
      expect(() => clamp(1, 10, 0), throwsArgumentError);
    });

    test('factorial funciona i valida errors', () {
      expect(factorial(0), 1);
      expect(factorial(1), 1);
      expect(factorial(5), 120);
      expect(() => factorial(-1), throwsArgumentError);
    });
  });
}
