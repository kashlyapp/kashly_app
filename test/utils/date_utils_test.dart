import 'package:flutter_test/flutter_test.dart';
import 'package:kashly_app/utils/date_utils.dart';

void main() {
  test('isLeapYear', () {
    expect(isLeapYear(2000), true);
    expect(isLeapYear(1900), false);
    expect(isLeapYear(2024), true);
    expect(isLeapYear(2025), false);
  });
  test('parseYMD', () {
    final d = parseYMD('2025-08-30');
    expect(d.year, 2025);
    expect(d.month, 8);
    expect(d.day, 30);
  });
}
