import 'package:data_connection_checker/data_connection_checker.dart';
import 'package:get_it/get_it.dart';
import 'package:tinh_tien/app/blocs/welcome/bloc.dart';
import 'package:tinh_tien/app/data/datasources/activity_datasource.dart';
import 'package:tinh_tien/app/data/repositories/activity_repository.dart';
import 'package:tinh_tien/app/data/repositories/people_repository.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'blocs/home/home_bloc.dart';
import 'data/datasources/expense_datasource.dart';
import 'data/datasources/people_datasouce.dart';
import 'data/repositories/expense_repository.dart';

final sl = GetIt.instance;

Future<void> init() async {
  // external
  sl.registerLazySingleton(() => DataConnectionChecker());
  final prefs = await SharedPreferences.getInstance();
  sl.registerLazySingleton(() => prefs);

  // data source
  sl.registerLazySingleton(() => ActivityDatasource());
  sl.registerLazySingleton(() => PeopleDatasouce());
  sl.registerLazySingleton(() => ExpenseDatasource());

  // repo
  sl.registerLazySingleton(() => ActivityRepository(
        activityDatasource: sl(),
        dataConnectionChecker: sl(),
      ));
  sl.registerLazySingleton(() => PeopleRepository(
        dataConnectionChecker: sl(),
        peopleDatasouce: sl(),
      ));
  sl.registerLazySingleton(() => ExpenseRepository(
        dataConnectionChecker: sl(),
        expenseDatasource: sl(),
      ));

  // bloc
  sl.registerFactory(() => WelcomeBloc(
        activityRepository: sl(),
        sharedPreferences: sl(),
      ));
  sl.registerFactory(() => HomeBloc(
        activityRepository: sl(),
        peopleRepository: sl(),
        sharedPreferences: sl(),
        connectionChecker: sl(),
        expenseRepository: sl(),
      ));
}
