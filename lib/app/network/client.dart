import 'package:dio/dio.dart';

const BASE_URL = 'https://api.ngrow.dev/api/v1';
const ACTIVITIES = '/activities';
const EXPENSES = 'expenses';
const SUMMARY = 'summary';
const SHARED_EXPENSES = 'shared-expenses';

final baseOption = BaseOptions(
  baseUrl: BASE_URL,
);

final dio = Dio(baseOption);
