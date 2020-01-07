import 'package:data_connection_checker/data_connection_checker.dart';

abstract class BaseRepository {
  Future<bool> hasNetworkConnection() => DataConnectionChecker().hasConnection;
}