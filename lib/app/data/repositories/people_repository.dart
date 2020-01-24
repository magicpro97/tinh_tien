import 'package:dartz/dartz.dart';
import 'package:data_connection_checker/data_connection_checker.dart';
import 'package:tinh_tien/app/data/datasources/people_datasouce.dart';
import 'package:tinh_tien/app/data/models/people/person.dart';
import 'package:tinh_tien/app/data/repositories/base_repository.dart';
import 'package:tinh_tien/app/network/no_network_connection_exception.dart';
import 'package:tinh_tien/core/errors/failures/people_failure.dart';

class PeopleRepository extends BaseRepository {
  final PeopleDatasouce peopleDatasouce;
  PeopleRepository({
    DataConnectionChecker dataConnectionChecker,
    this.peopleDatasouce,
  }) : super(dataConnectionChecker);

  Future<Either<PeopleFailure, Person>> create(
      {String activityId, String name}) async {
    if (await hasNetworkConnection()) {
      final data = await peopleDatasouce.createPerson(activityId, name);
      return data.fold((error) => Left(PeopleFailure(error.message)),
          (person) => Right(person));
    } else {
      throw NoNetworkConnection();
    }
  }

  Future<Either<PeopleFailure, Person>> update(
      {String activityId, String personId, String name}) async {
    if (await hasNetworkConnection()) {
      final data = await peopleDatasouce.editPerson(activityId, personId, name);
      return data.fold((error) => Left(PeopleFailure(error.message)),
          (person) => Right(person));
    } else {
      throw NoNetworkConnection();
    }
  }

  Future<Either<PeopleFailure, Person>> delete(
      {String activityId, String personId}) async {
    if (await hasNetworkConnection()) {
      final data = await peopleDatasouce.deletePerson(activityId, personId);
      return data.fold((error) => Left(PeopleFailure(error.message)),
          (person) => Right(person));
    } else {
      throw NoNetworkConnection();
    }
  }
}
