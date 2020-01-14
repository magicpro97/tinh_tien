import 'package:data_connection_checker/data_connection_checker.dart';
import 'package:get_it/get_it.dart';
import 'package:tinh_tien/app/blocs/welcome/bloc.dart';
import 'package:tinh_tien/app/data/datasources/activity_datasource.dart';
import 'package:tinh_tien/app/data/repositories/activity_repository.dart';
import 'package:tinh_tien/app/data/repositories/people_repository.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'blocs/home/home_bloc.dart';
import 'data/datasources/people_datasouce.dart';

final sl = GetIt.instance;

Future<void> init() async {
  // external
  sl.registerLazySingleton(() => DataConnectionChecker());
  final prefs = await SharedPreferences.getInstance();
  sl.registerLazySingleton(() => prefs);

  // data source
  sl.registerLazySingleton(() => ActivityDatasource());
  sl.registerLazySingleton(() => PeopleDatasouce());

  // repo
  sl.registerLazySingleton(() => ActivityRepository(
        activityDatasource: sl(),
        dataConnectionChecker: sl(),
      ));
  sl.registerLazySingleton(() => PeopleRepository(
        dataConnectionChecker: sl(),
        peopleDatasouce: sl(),
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
      ));
}
