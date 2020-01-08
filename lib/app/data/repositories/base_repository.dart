import 'package:data_connection_checker/data_connection_checker.dart';

abstract class BaseRepository {
  final DataConnectionChecker dataConnectionChecker;

  BaseRepository(this.dataConnectionChecker);

  Future<bool> hasNetworkConnection() => DataConnectionChecker().hasConnection;
}