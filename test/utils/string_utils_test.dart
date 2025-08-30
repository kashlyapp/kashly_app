import 'package:flutter_test/flutter_test.dart';
import 'package:kashly_app/utils/string_utils.dart';

void main() {
  group('StringUtils', () {
    test('capitalize', () {
      expect(StringUtils.capitalize('hello'), 'Hello');
      expect(StringUtils.capitalize(''), '');
      expect(StringUtils.capitalize('a'), 'A');
    });

    test('toTitleCase', () {
      expect(StringUtils.toTitleCase('hello world'), 'Hello World');
      expect(StringUtils.toTitleCase('  multiple   spaces '), 'Multiple Spaces');
      expect(StringUtils.toTitleCase(''), '');
    });

    test('snakeToCamel', () {
      expect(StringUtils.snakeToCamel('hello_world'), 'helloWorld');
      expect(StringUtils.snakeToCamel('already'), 'already');
      expect(StringUtils.snakeToCamel('UPPER_CASE'), 'upperCase');
      expect(StringUtils.snakeToCamel('edge__case_'), 'edgeCase');
    });

    test('camelToSnake', () {
      expect(StringUtils.camelToSnake('helloWorld'), 'hello_world');
      expect(StringUtils.camelToSnake('already'), 'already');
      expect(StringUtils.camelToSnake('URLParser'), 'url_parser');
    });

    test('isBlank', () {
      expect(StringUtils.isBlank(null), isTrue);
      expect(StringUtils.isBlank(''), isTrue);
      expect(StringUtils.isBlank('   '), isTrue);
      expect(StringUtils.isBlank('x'), isFalse);
    });

    test('reverse', () {
      expect(StringUtils.reverse('abc'), 'cba');
      expect(StringUtils.reverse(''), '');
    });
  });
}
