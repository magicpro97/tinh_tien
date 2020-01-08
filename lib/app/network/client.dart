import 'package:dio/dio.dart';

const BASE_URL = 'http://35.194.102.189/api/v1';
const ACTIVITIES = '/activities';

final baseOption = BaseOptions(
  baseUrl: BASE_URL,
);

final dio = Dio(baseOption);
