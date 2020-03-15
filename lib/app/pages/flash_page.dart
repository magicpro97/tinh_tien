import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tinh_tien/app/blocs/activity/activity_bloc.dart';
import 'package:tinh_tien/app/blocs/activity/activity_state.dart';
import 'package:tinh_tien/app/blocs/activity/bloc.dart';
import 'package:tinh_tien/app/pages/home_page/home_page.dart';
import 'package:tinh_tien/app/pages/welcome_page/welcome_page.dart';

class FlashPage extends StatefulWidget {
  final String lastActivityId;

  const FlashPage(this.lastActivityId);

  @override
  _FlashPageState createState() => _FlashPageState();
}

class _FlashPageState extends State<FlashPage> {
  @override
  void initState() {
    SchedulerBinding.instance.addPostFrameCallback((_) {
      if (widget.lastActivityId != null && widget.lastActivityId.isNotEmpty) {
        BlocProvider.of<ActivityBloc>(context)
            .add(GetActivity(activityId: widget.lastActivityId));
        BlocProvider.of<ActivityBloc>(context).listen((state) {
          if (state is ActivityLoadedState) {
            Navigator.pushReplacementNamed(context, HomePage.route,
                arguments: state.activity.toJson());
          }
        });
      } else {
        Navigator.pushReplacementNamed(context, WelcomePage.route);
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold();
  }
}
