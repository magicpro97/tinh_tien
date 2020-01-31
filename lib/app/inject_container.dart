import 'package:data_connection_checker/data_connection_checker.dart';
import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tinh_tien/app/data/datasources/local/local_database.dart';

import 'blocs/activity/activity_bloc.dart';
import 'blocs/expense/expense_bloc.dart';
import 'blocs/people/people_bloc.dart';
import 'data/datasources/remote/activity_remote_datasource.dart';
import 'data/datasources/remote/expense_remote_datasource.dart';
import 'data/datasources/remote/people_remote_datasource.dart';
import 'data/repositories/activity_repository.dart';
import 'data/repositories/expense_repository.dart';
import 'data/repositories/people_repository.dart';

final sl = GetIt.instance;

Future<void> init() async {
  // external
  sl.registerLazySingleton(() => DataConnectionChecker());
  final prefs = await SharedPreferences.getInstance();
  sl.registerLazySingleton(() => prefs);

  // data source
  sl.registerLazySingleton(() => LocalDatabase());
  sl.registerLazySingleton(() => ActivityRemoteDataSource());
  sl.registerLazySingleton(() => PeopleRemoteDataSource());
  sl.registerLazySingleton(() => ExpenseRemoteDataSource());

  // repo
  sl.registerLazySingleton(() => ActivityRepository(
        activityDatasource: sl(),
      ));
  sl.registerLazySingleton(() => PeopleRepository(
        peopleDatasouce: sl(),
      ));
  sl.registerLazySingleton(() => ExpenseRepository(
        expenseDatasource: sl(),
      ));

  // bloc
  sl.registerFactory(() => ActivityBloc(
        activityRepository: sl(),
        sharedPreferences: sl(),
      ));
  sl.registerFactory(() => PeopleBloc(peopleRepository: sl()));
  sl.registerFactory(() => ExpenseBloc(expenseRepository: sl()));
}
