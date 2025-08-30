/// Utilidades de cadenas puras y testeables.
class StringUtils {
  static String capitalize(String input) {
    if (input.isEmpty) return input;
    return input[0].toUpperCase() + input.substring(1);
  }

  static String toTitleCase(String input) {
    final trimmed = input.trim();
    if (trimmed.isEmpty) return input;
    return trimmed
        .split(RegExp(r"\s+"))
        .map((w) => w.isEmpty ? w : capitalize(w.toLowerCase()))
        .join(' ');
  }

  static String snakeToCamel(String input) {
    final parts = input.split('_');
    if (parts.isEmpty) return input;
    final head = parts.first.toLowerCase();
    final tail = parts
        .skip(1)
        .map((p) => p.isEmpty ? '' : p[0].toUpperCase() + p.substring(1).toLowerCase())
        .join();
    return head + tail;
  }

  static String camelToSnake(String input) {
    // Inserta guiones bajos entre límites de palabras y antes de secuencias de mayúsculas
    final step1 = input.replaceAllMapped(
        RegExp(r'([a-z0-9])([A-Z])'), (m) => '${m[1]}_${m[2]}');
    final step2 = step1.replaceAllMapped(
        RegExp(r'([A-Z]+)([A-Z][a-z])'), (m) => '${m[1]}_${m[2]}');
    return step2.toLowerCase();
  }

  static bool isBlank(String? input) => input == null || input.trim().isEmpty;

  static String reverse(String input) => input.split('').reversed.join();
}
