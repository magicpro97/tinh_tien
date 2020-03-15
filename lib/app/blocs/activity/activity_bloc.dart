import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tinh_tien/app/data/repositories/activity_repository.dart';
import 'package:tinh_tien/app/network/no_network_connection_exception.dart';
import 'package:tinh_tien/common/constants.dart';
import 'package:tinh_tien/core/errors/exceptions/unknown_exception.dart';

import '../../inject_container.dart';
import './bloc.dart';

class ActivityBloc extends Bloc<ActivityEvent, ActivityState> {
  final ActivityRepository activityRepository;

  ActivityBloc({
    @required this.activityRepository,
  });

  @override
  ActivityState get initialState => InitialActivityState();

  @override
  Stream<ActivityState> mapEventToState(
    ActivityEvent event,
  ) async* {
    yield ActivityLoadingState();
    try {
      if (event is GetActivity) {
        yield* _getActivity(event);
      } else if (event is DeleteActivity) {
        yield* _deleteActivity(event);
      } else if (event is CreateActivity) {
        yield* _createActivity(event);
      }
    } catch (e) {
      if (e is NoNetworkConnection) {
        yield ActivityErrorState(e.message);
      } else {
        yield ActivityErrorState(UnknownException().message);
      }
    }
  }

  Stream<ActivityState> _createActivity(CreateActivity event) async* {
    if (event.name.isEmpty) {
      yield ActivityErrorState('Required');
    } else {
      final data = await activityRepository.createActivity(event.name);
      yield await data.fold((fail) async {
        return ActivityErrorState(fail.message);
      }, (activity) async {
        sl<SharedPreferences>().setString(ACTIVITY_ID, activity.id);
        return CreatedActivityState(activity);
      });
    }
  }

  Stream<ActivityState> _deleteActivity(DeleteActivity event) async* {
    final activityId = event.activityId;
    final data =
        await activityRepository.deleteActivity(activityId: activityId);
    yield await data.fold((error) async {
      return ActivityErrorState(error.message);
    }, (activity) async {
      sl<SharedPreferences>().setString(ACTIVITY_ID, '');
      return DeletedActivityState();
    });
  }

  Stream<ActivityState> _getActivity(GetActivity event) async* {
    sl<SharedPreferences>().setString(ACTIVITY_ID, event.activityId);
    final data = await Future.wait([
      activityRepository.getById(event.activityId),
      activityRepository.getSummary(event.activityId),
      activityRepository.getSharedExpenses(event.activityId),
    ]);
    final error = data.firstWhere((e) => e.isLeft(), orElse: () => null);
    if (error != null) {
      yield ActivityErrorState(error.fold((error) => error.message, null));
    } else {
      yield ActivityLoadedState(
          activity: data[0].fold(null, (data) => data),
          activitySummary: data[1].fold(null, (data) => data),
          activitySharedExpenses: data[2].fold(null, (data) => data));
    }
  }
}
