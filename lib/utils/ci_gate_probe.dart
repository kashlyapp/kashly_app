// lib/utils/ci_gate_probe.dart
/// Retorna la suma segura de [a] i [b].
int safeAdd(int a, int b) => a + b;

/// Retorna `true` si [n] és parell.
bool isEven(int n) => (n % 2) == 0;

/// Retorna [value] limitat entre [min] i [max] (ambdós inclosos).
T clamp<T extends num>(T value, T min, T max) {
	if (min > max) {
		throw ArgumentError('min ($min) must be <= max ($max)');
	}
	if (value < min) return min;
	if (value > max) return max;
	return value;
}

/// Factorial iteratiu per a [n] >= 0.
int factorial(int n) {
	if (n < 0) throw ArgumentError('n must be >= 0');
	var acc = 1;
	for (var i = 2; i <= n; i++) {
		acc *= i;
	}
	return acc;
}
