import 'package:flutter_test/flutter_test.dart';
import 'package:demo01/main.dart';

void main() {
  test('computeTip gives 75 tip and 575 total for 500 at 15%', () {
    final result = computeTip(500, 15);
    expect(result.tip, 75.0);
    expect(result.total, 575.0);
  });

  test('parseBill returns null for invalid input', () {
    expect(parseBill('abc'), isNull);
    expect(parseBill(''), isNull);
  });

  test('parseBill trims and parses valid input', () {
    expect(parseBill(' 500 '), 500.0);
  });
}