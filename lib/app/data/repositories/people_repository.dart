import 'package:dartz/dartz.dart';
import 'package:data_connection_checker/data_connection_checker.dart';
import 'package:tinh_tien/app/data/datasources/people_datasouce.dart';
import 'package:tinh_tien/app/data/models/no_data.dart';
import 'package:tinh_tien/app/data/models/people/person.dart';
import 'package:tinh_tien/app/data/repositories/base_repository.dart';
import 'package:tinh_tien/app/network/no_network_connection_exception.dart';
import 'package:tinh_tien/core/errors/failures/people_failure.dart';
import 'package:meta/meta.dart';

class PeopleRepository extends BaseRepository {
  final PeopleDatasouce peopleDatasouce;
  PeopleRepository({
    @required DataConnectionChecker dataConnectionChecker,
    @required this.peopleDatasouce,
  }) : super(dataConnectionChecker);

  Future<Either<PeopleFailure, Person>> create({
    @required String activityId,
    @required String name,
  }) async {
    if (await hasNetworkConnection()) {
      final data = await peopleDatasouce.create(
        activityId: activityId,
        name: name,
      );
      return data.fold((error) => Left(PeopleFailure(error.message)),
          (person) => Right(person));
    } else {
      throw NoNetworkConnection();
    }
  }

  Future<Either<PeopleFailure, NoData>> update({
    @required String activityId,
    @required String name,
    @required String personId,
  }) async {
    if (await hasNetworkConnection()) {
      final data = await peopleDatasouce.update(
        activityId: activityId,
        name: name,
        personId: personId,
      );
      return data.fold((error) => Left(PeopleFailure(error.message)),
          (person) => Right(person));
    } else {
      throw NoNetworkConnection();
    }
  }

  Future<Either<PeopleFailure, NoData>> delete({
    @required String activityId,
    @required String personId,
  }) async {
    if (await hasNetworkConnection()) {
      final data = await peopleDatasouce.delete(
        activityId: activityId,
        personId: personId,
      );
      return data.fold((error) => Left(PeopleFailure(error.message)),
          (person) => Right(person));
    } else {
      throw NoNetworkConnection();
    }
  }
}
