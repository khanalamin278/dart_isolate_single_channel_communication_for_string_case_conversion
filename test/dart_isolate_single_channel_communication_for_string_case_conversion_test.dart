import 'package:dart_isolate_single_channel_communication_for_string_case_conversion/dart_isolate_single_channel_communication_for_string_case_conversion.dart';
import 'package:test/test.dart';

void main() {
  test('convertCaseInIsolate converts string case correctly', () async {
    expect(await convertCaseInIsolate({'command': 'upper', 'text': 'hello'}),
        equals('HELLO'));
    expect(await convertCaseInIsolate({'command': 'lower', 'text': 'WORLD'}),
        equals('world'));
  });
}
