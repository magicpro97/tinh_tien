import 'package:dio/dio.dart';

const baseUrl = 'http://35.194.102.189/api/v1';

final baseOption = BaseOptions(
  baseUrl: baseUrl,
);

final dio = Dio(baseOption);
