import 'dart:async';

final notEmpty =
    StreamTransformer<String, String>.fromHandlers(handleData: (data, sink) {
  if (data.length > 0) {
    sink.add(data);
  } else {
    sink.addError("Required");
  }
});
