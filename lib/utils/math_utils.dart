// Utilitats matemàtiques simples per a proves i ús general.
// Aquest fitxer és pur Dart i no depèn de Flutter ni Firebase,
// de manera que és segur d'importar en tests sense mocks.

// Suma dos enters i retorna el resultat.
int add(int a, int b) => a + b;

// Retorna `value` limitat a l'interval [min, max].
num clamp(num value, {required num min, required num max}) {
  assert(min <= max, 'min no pot ser més gran que max');
  if (value < min) return min;
  if (value > max) return max;
  return value;
}
