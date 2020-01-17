import 'dart:async';

final notEmptyString =
    StreamTransformer<String, String>.fromHandlers(handleData: (data, sink) {
  if (data.length > 0) {
    sink.add(data);
  } else {
    sink.addError("Required");
  }
});

final notEmptyList =
StreamTransformer<int, String>.fromHandlers(handleData: (data, sink) {
  if (data > 0) {
    sink.add("");
  } else {
    sink.addError("Required");
  }
});
