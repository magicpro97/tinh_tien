import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:tinh_tien/app/data/repositories/activity_repository.dart';
import 'package:tinh_tien/app/network/no_network_connection_exception.dart';

import './bloc.dart';

class WelcomeBloc extends Bloc<WelcomeEvent, WelcomeState> {
  final ActivityRepository activityRepository;

  WelcomeBloc({@required this.activityRepository});

  @override
  WelcomeState get initialState => InitialWelcomeState();

  @override
  Stream<WelcomeState> mapEventToState(
    WelcomeEvent event,
  ) async* {
    if (event is CreateActivityEvent) {
      try {
        yield CreateActivityLoading();
        final data = await activityRepository.createActivity(event.name);
        yield data.fold((fail) {
          return CreateActivityFail(fail.message);
        }, (activity) {
          return CreateActivitySuccess();
        });
      } catch (e) {
        if (e is NoNetworkConnection) {
          yield CreateActivityFail('Please connect to internet and try again.');
        } else {
          yield CreateActivityFail('Unknown error.');
        }
      }
    }
  }
}
