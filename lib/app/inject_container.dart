import 'package:data_connection_checker/data_connection_checker.dart';
import 'package:get_it/get_it.dart';
import 'package:tinh_tien/app/blocs/welcome/bloc.dart';
import 'package:tinh_tien/app/data/datasources/activity_datasource.dart';
import 'package:tinh_tien/app/data/repositories/activity_repository.dart';

final sl = GetIt.instance;

void init() {
  // external
  sl.registerLazySingleton(() => DataConnectionChecker());

  // data source
  sl.registerLazySingleton(() => ActivityDatasource());

  // repo
  sl.registerLazySingleton(() => ActivityRepository(
        activityDatasource: sl(),
        dataConnectionChecker: sl(),
      ));

  // bloc
  sl.registerFactory(() => WelcomeBloc(activityRepository: sl()));
}
