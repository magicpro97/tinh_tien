import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tinh_tien/app/data/models/activity/activity.dart';
import 'package:tinh_tien/app/data/repositories/activity_repository.dart';
import 'package:tinh_tien/app/network/no_network_connection_exception.dart';
import 'package:tinh_tien/common/constants.dart';
import 'package:tinh_tien/core/errors/exceptions/unknown_exception.dart';

import './bloc.dart';

class ActivityBloc extends Bloc<ActivityEvent, ActivityState> {
  final SharedPreferences sharedPreferences;
  final ActivityRepository activityRepository;
  Activity activity;

  ActivityBloc({
    @required this.sharedPreferences,
    @required this.activityRepository,
  });

  String get activityId => sharedPreferences.getString(ACTIVITY_ID);

  @override
  ActivityState get initialState => InitialActivityState();

  @override
  Stream<ActivityState> mapEventToState(
    ActivityEvent event,
  ) async* {
    if (event is GetActivityEvent) {
      yield ActivityLoadingState();
      try {
        final activityId =
            event.activityId ?? sharedPreferences.getString(ACTIVITY_ID);
        final data = await Future.wait([
          activityRepository.getById(activityId),
          activityRepository.getSummary(activityId),
          activityRepository.getSharedExpenses(activityId),
        ]);
        final error = data.firstWhere((e) => e.isLeft(), orElse: () => null);
        if (error != null) {
          yield ActivityErrorState(error.fold((error) => error.message, null));
        } else {
          yield ActivityLoadedState(
              activity: data[0].fold(null, (data) {
                activity = data;
                return data;
              }),
              activitySummary: data[1].fold(null, (data) => data),
              activitySharedExpenses: data[2].fold(null, (data) => data));
        }
      } catch (e) {
        if (e is NoNetworkConnection) {
          yield ActivityErrorState(e.message);
        } else {
          yield ActivityErrorState(UnknownException().message);
        }
      }
    } else if (event is DeleteActivityEvent) {
      try {
        final activityId = event.activityId;
        final data =
            await activityRepository.deleteActivity(activityId: activityId);
        yield await data.fold((error) async {
          return ActivityErrorState(error.message);
        }, (activity) async {
          await sharedPreferences.setString(ACTIVITY_ID, "");
          return DeletedActivityState(activity);
        });
      } catch (e) {
        if (e is NoNetworkConnection) {
          yield ActivityErrorState(e.message);
        } else {
          yield ActivityErrorState(UnknownException().message);
        }
      }
    } else if (event is CreateActivityEvent) {
      try {
        if (event.name.isEmpty) {
          yield ActivityErrorState('Required');
        } else {
          yield ActivityLoadingState();
          final data = await activityRepository.createActivity(event.name);
          yield await data.fold((fail) async {
            return ActivityErrorState(fail.message);
          }, (activity) async {
            await sharedPreferences.setString(ACTIVITY_ID, activity.id);
            return CreatedActivityState(activity);
          });
        }
      } catch (e) {
        if (e is NoNetworkConnection) {
          yield ActivityErrorState(e.message);
        } else {
          yield ActivityErrorState(UnknownException().message);
        }
      }
    }
  }
}
