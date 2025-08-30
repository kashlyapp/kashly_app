import 'package:flutter_test/flutter_test.dart';
import 'package:kashly_app/main.dart' as app;

void main() {
  test('smoke main() boots without throwing', () async {
    // We only ensure main() can be invoked; in CI this file helps include lib/main.dart in coverage.
    // Do not pump Widgets here to avoid requiring full Flutter bindings initialization in headless CI.
    await app.main();
    expect(true, isTrue);
  });
}
