import 'package:dartz/dartz.dart';
import 'package:meta/meta.dart';
import 'package:tinh_tien/app/data/datasources/local/people_local_datasource.dart';
import 'package:tinh_tien/app/data/datasources/remote/people_remote_datasource.dart';
import 'package:tinh_tien/app/data/models/no_data.dart';
import 'package:tinh_tien/app/data/models/people/person.dart';
import 'package:tinh_tien/app/network/no_network_connection_exception.dart';
import 'package:tinh_tien/core/errors/failures/people_failure.dart';

class PeopleRepository {
  final PeopleRemoteDataSource peopleDataSource;
  final PeopleLocalDataSource peopleLocalDataSource;

  PeopleRepository({
    @required this.peopleDataSource,
    @required this.peopleLocalDataSource,
  });

  Future<Either<PeopleFailure, Person>> create({
    @required String activityId,
    @required String name,
  }) async {
    try {
      final data = await peopleDataSource.create(
        activityId: activityId,
        name: name,
      );
      return data.fold(
        (error) => Left(PeopleFailure(error.message)),
        (person) => Right(person),
      );
    } catch (e) {
      throw NoNetworkConnection();
    }
  }

  Future<Either<PeopleFailure, NoData>> update({
    @required String activityId,
    @required String name,
    @required String personId,
  }) async {
    try {
      final data = await peopleDataSource.update(
        activityId: activityId,
        name: name,
        personId: personId,
      );
      return data.fold(
        (error) => Left(PeopleFailure(error.message)),
        (person) => Right(person),
      );
    } catch (e) {
      throw NoNetworkConnection();
    }
  }

  Future<Either<PeopleFailure, NoData>> delete({
    @required String activityId,
    @required String personId,
  }) async {
    try {
      final data = await peopleDataSource.delete(
        activityId: activityId,
        personId: personId,
      );
      return data.fold(
        (error) => Left(PeopleFailure(error.message)),
        (person) => Right(person),
      );
    } catch (e) {
      throw NoNetworkConnection();
    }
  }

  Future<Either<PeopleFailure, List<Person>>> getPeople({
    @required String activityId,
  }) async {
    try {
      final data = await peopleDataSource.getPeople(
        activityId: activityId,
      );
      return data.fold(
        (error) => Left(PeopleFailure(error.message)),
        (people) => Right(people),
      );
    } catch (e) {
      throw NoNetworkConnection();
    }
  }
}
