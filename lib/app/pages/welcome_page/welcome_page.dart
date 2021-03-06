import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tinh_tien/app/blocs/activity/bloc.dart';
import 'package:tinh_tien/app/route.dart';
import 'package:tinh_tien/app/widgets/app_logo.dart';
import 'package:tinh_tien/common/colors.dart';
import 'package:tinh_tien/common/dimens.dart';

class WelcomePage extends StatefulWidget {
  @override
  _WelcomePageState createState() => _WelcomePageState();
}

class _WelcomePageState extends State<WelcomePage>
    with TickerProviderStateMixin {
  ActivityBloc _activityBloc;
  TextEditingController _activityNameController;
  double _logoSize = 300;
  double _sloganFontSize = 0;
  double _createButtonOpacity = 0;
  double _alreadyHaveButtonOpacity = 0;
  Duration _opacityDuration;
  AnimationController _scaleController;
  Animation<double> _scaleAnimation;
  FocusNode _nameFieldFocus;

  @override
  void initState() {
    super.initState();
    _activityBloc = BlocProvider.of<ActivityBloc>(context);
    _activityNameController = TextEditingController();
    _scaleController =
        AnimationController(vsync: this, duration: Duration(seconds: 1));
    _nameFieldFocus = FocusNode();
    _scaleController.addListener(() {
      Future.delayed(Duration(milliseconds: 1600), () {
        _nameFieldFocus.requestFocus();
      });
    });
    _scaleAnimation =
        CurvedAnimation(curve: Curves.linear, parent: _scaleController);
    Future.delayed(Duration(seconds: 2), () {
      setState(() {
        _logoSize = 150;
      });
    });
    Future.delayed(Duration(seconds: 2), () {
      setState(() {
        _sloganFontSize = 24;
      });
    });
    _opacityDuration = Duration(milliseconds: 400);
    Future.delayed(Duration(milliseconds: 3000), () {
      _scaleController.forward();
    });
    Future.delayed(Duration(milliseconds: 3400), () {
      setState(() {
        _createButtonOpacity = 1;
      });
    });
    Future.delayed(Duration(milliseconds: 3600), () {
      setState(() {
        _alreadyHaveButtonOpacity = 1;
      });
      _activityBloc.add(GetLastActivityEvent());
    });
  }

  @override
  void dispose() {
    _activityNameController.dispose();
    _nameFieldFocus.dispose();
    _scaleController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          padding:
              const EdgeInsets.symmetric(horizontal: Dimens.NORMAL_PADDING),
          child: BlocListener(
            bloc: _activityBloc,
            listener: (_, state) {
              if (state is CreatedActivityState) {
                Navigator.pushReplacementNamed(context, HOME_PAGE,
                    arguments: state.activity);
              // } else if (state is HasLastActivityState) {
              //   _activityBloc.add(GetActivityEvent());
              } else if (state is ActivityLoadedState) {
                Navigator.pushReplacementNamed(context, HOME_PAGE);
              }
            },
            child: BlocBuilder<ActivityBloc, ActivityState>(
              bloc: _activityBloc,
              builder: (context, state) => Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: Dimens.NORMAL_PADDING),
                    child: AnimatedSize(
                      child: AppLogo(
                        height: _logoSize,
                        width: _logoSize,
                      ),
                      vsync: this,
                      duration: Duration(seconds: 1),
                    ),
                  ),
                  Text(
                    'Tinh Tien',
                    style: Theme.of(context).textTheme.display1.apply(
                          color: AppColors.MAIN_COLOR,
                        ),
                  ),
                  AnimatedSize(
                    child: Text(
                      'Manage team expenses',
                      style: Theme.of(context).textTheme.headline.copyWith(
                            fontSize: _sloganFontSize,
                            color: Color(0xffFFCA40),
                          ),
                    ),
                    duration: _opacityDuration,
                    vsync: this,
                  ),
                  SizedBox(
                    height: Dimens.LARGE_PADDING,
                  ),
                  ScaleTransition(
                    child: TextField(
                      focusNode: _nameFieldFocus,
                      controller: _activityNameController,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        hintText: "Your activity's name",
                        errorText:
                            state is ActivityErrorState ? state.message : null,
                      ),
                      onSubmitted: (value) {
                        submitActivity(state, value);
                      },
                    ),
                    scale: _scaleAnimation,
                  ),
                  SizedBox(
                    height: Dimens.LARGE_PADDING,
                  ),
                  state is ActivityLoadingState
                      ? CircularProgressIndicator()
                      : Container(),
                  AnimatedOpacity(
                    child: MaterialButton(
                      onPressed: () {
                        if (!(state is ActivityLoadingState)) {
                          submitActivity(state, _activityNameController.text);
                        }
                      },
                      child: Text(
                        'CREATE YOUR ACTIVITY',
                        style: TextStyle(
                          color: Colors.white,
                        ),
                      ),
                      color: Colors.blue,
                    ),
                    opacity: _createButtonOpacity,
                    duration: _opacityDuration,
                  ),
                  AnimatedOpacity(
                    child: FlatButton(
                      onPressed: () {
                        if (!(state is ActivityLoadingState)) {
                          Navigator.pushNamed(
                              context, ALREADY_HAVE_ACTIVITY_PAGE);
                        }
                      },
                      child: Text(
                        'I ALREADY HAVE ACTIVITY',
                        style: TextStyle(color: AppColors.MAIN_COLOR),
                      ),
                    ),
                    duration: _opacityDuration,
                    opacity: _alreadyHaveButtonOpacity,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  void submitActivity(ActivityState state, String value) {
    if (!(state is ActivityLoadingState)) {
      _activityBloc.add(CreateActivityEvent(value));
    }
  }
}
