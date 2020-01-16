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

  WelcomeBloc({@required this.activityRepository, @required this.sharedPreferences});

  @override
  WelcomeState get initialState => InitialWelcomeState();

  @override
  Stream<WelcomeState> mapEventToState(
    WelcomeEvent event,
  ) async* {
    if (event is CreateActivityEvent) {
      try {
        if (event.name.isEmpty) {
          yield CreateActivityFail('Required');
        } else {
          yield CreateActivityLoading();
          final data = await activityRepository.createActivity(event.name);
          yield await data.fold((fail) async {
            return CreateActivityFail(fail.message);
          }, (activity) async {
            await sharedPreferences.setString(ACTIVITY_ID, activity.id);
            return CreateActivitySuccess(activity);
          });
        }
      } catch (e) {
        if (e is NoNetworkConnection) {
          yield CreateActivityFail(e.message);
        } else {
          yield CreateActivityFail((e as UnknownException).message);
        }
      }
    }
  }
}
