import 'package:dio/dio.dart';

const BASE_URL = 'https://api.ngrow.dev/api/v1';
const ACTIVITIES = '/activities';
const SUMMARY = '/summary';

final baseOption = BaseOptions(
  baseUrl: BASE_URL,
);

final dio = Dio(baseOption);
