/// Support for doing something awesome.
///
/// More dartdocs go here.
library;

export 'src/dart_isolate_single_channel_communication_for_string_case_conversion_base.dart';

/*
Practice Question 2: Single-Channel Communication 
for String Case Conversion
Task:
Implement a function convertCaseInIsolate that converts a 
string to upper or lower case in a separate isolate using 
single-channel communication. The main isolate sends the 
string along with the command (‘upper’ or ‘lower’).
 */

import 'dart:async';
import 'dart:isolate';

Future<dynamic> convertCaseInIsolate(Map<String, dynamic> input) async {
  final receivePort = ReceivePort();
  await Isolate.spawn(
      caseConverterIsolate, {'input': input, 'sendPort': receivePort.sendPort});

  final completer = Completer<dynamic>();
  receivePort.listen((data) {
    completer.complete(data);
    receivePort.close();
  });

  return completer.future;
}

void caseConverterIsolate(Map<String, dynamic> args) {
  final input = args['input'];
  final sendPort = args['sendPort'];

  final command = input['command'];
  final text = input['text'];
  String result;

  if (command == 'upper') {
    result = text.toUpperCase();
  } else if (command == 'lower') {
    result = text.toLowerCase();
  } else {
    result = 'Invalid command';
  }

  sendPort.send(result);
}
