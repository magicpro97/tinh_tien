import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tinh_tien/app/data/repositories/activity_repository.dart';
import 'package:tinh_tien/app/network/no_network_connection_exception.dart';
import 'package:tinh_tien/common/constants.dart';
import 'package:tinh_tien/core/errors/exceptions/unknown_exception.dart';

import './bloc.dart';

class WelcomeBloc extends Bloc<WelcomeEvent, WelcomeState> {
  final SharedPreferences sharedPreferences;
  final ActivityRepository activityRepository;

  WelcomeBloc(
      {@required this.activityRepository, @required this.sharedPreferences});

  @override
  WelcomeState get initialState => InitialWelcomeState();

  @override
  Stream<WelcomeState> mapEventToState(
    WelcomeEvent event,
  ) async* {
    if (event is CreateActivityEvent) {
      try {
        if (event.name.isEmpty) {
          yield ErrorState('Required');
        } else {
          yield ActivityLoading();
          final data = await activityRepository.createActivity(event.name);
          yield await data.fold((fail) async {
            return ErrorState(fail.message);
          }, (activity) async {
            await sharedPreferences.setString(ACTIVITY_ID, activity.id);
            return ActivityLoaded(activity);
          });
        }
      } catch (e) {
        if (e is NoNetworkConnection) {
          yield ErrorState(e.message);
        } else {
          yield ErrorState((e as UnknownException).message);
        }
      }
    } else if (event is GetActivityEvent) {
      yield ActivityLoading();
      try {
        final data = await activityRepository.getById(event.id);
        yield await data.fold((error) async {
          return ErrorState(error.message);
        }, (activity) async {
          await sharedPreferences.setString(ACTIVITY_ID, activity.id);
          return ActivityLoaded(activity);
        });
      } catch (e) {
        if (e is NoNetworkConnection) {
          yield ErrorState(e.message);
        } else {
          yield ErrorState((e as UnknownException).message);
        }
      }
    }
  }
}
