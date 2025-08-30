class NumUtils {
  static num sum(Iterable<num> values) => values.fold(0, (a, b) => a + b);
  static num average(Iterable<num> values) => values.isEmpty ? 0 : sum(values) / values.length;
  static bool isBetween(num x, num min, num max, {bool inclusive = true}) {
    return inclusive ? (x >= min && x <= max) : (x > min && x < max);
  }
  static int gcd(int a, int b) {
    a = a.abs();
    b = b.abs();
    while (b != 0) {
      final t = b;
      b = a % b;
      a = t;
    }
    return a;
  }
}
