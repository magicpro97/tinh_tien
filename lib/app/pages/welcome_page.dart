import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tinh_tien/app/blocs/welcome/bloc.dart';
import 'package:tinh_tien/app/route.dart';
import 'package:tinh_tien/app/widgets/app_logo.dart';
import 'package:tinh_tien/common/colors.dart';
import 'package:tinh_tien/common/dimens.dart';

class WelcomePage extends StatefulWidget {
  @override
  _WelcomePageState createState() => _WelcomePageState();
}

class _WelcomePageState extends State<WelcomePage>
    with SingleTickerProviderStateMixin {
  WelcomeBloc _welcomeBloc;
  TextEditingController _activityNameController;
  double size = 300;

  @override
  void initState() {
    super.initState();
    _welcomeBloc = BlocProvider.of<WelcomeBloc>(context);
    _activityNameController = TextEditingController();
    Future.delayed(Duration(seconds: 2), () {
      setState(() {
        size = 150;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          padding:
          const EdgeInsets.symmetric(horizontal: Dimens.NORMAL_PADDING),
          child: BlocListener(
            bloc: _welcomeBloc,
            listener: (_, state) {
              if (state is CreateActivitySuccess) {
                Navigator.pushNamed(context, HOME_PAGE);
              }
            },
            child: BlocBuilder<WelcomeBloc, WelcomeState>(
              bloc: _welcomeBloc,
              builder: (context, state) =>
                  Column(
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: Dimens.NORMAL_PADDING),
                        child: AnimatedSize(
                          child: AppLogo(
                            height: size,
                            width: size,
                          ),
                          vsync: this,
                          duration: Duration(seconds: 3),
                        ),
                      ),
                      Text(
                        'Tinh Tien',
                        style: Theme
                            .of(context)
                            .textTheme
                            .display1
                            .apply(
                          color: AppColors.MAIN_COLOR,
                        ),
                      ),
                      Text(
                        'Manage team expenses',
                        style: Theme
                            .of(context)
                            .textTheme
                            .headline,
                      ),
                      SizedBox(
                        height: Dimens.LARGE_PADDING,
                      ),
                      TextField(
                        controller: _activityNameController,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(),
                          hintText: "Your activity's name",
                          errorText:
                          state is CreateActivityFail ? state.message : null,
                        ),
                        onSubmitted: (value) {
                          submitActivity(state, value);
                        },
                      ),
                      SizedBox(
                        height: Dimens.LARGE_PADDING,
                      ),
                      state is CreateActivityLoading
                          ? CircularProgressIndicator()
                          : Container(),
                      MaterialButton(
                        onPressed: () {
                          if (!(state is CreateActivityLoading)) {
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
                      FlatButton(
                        onPressed: () {
                          if (!(state is CreateActivityLoading)) {
                            Navigator.pushNamed(
                                context, ALREADY_HAVE_ACTIVITY_PAGE);
                          }
                        },
                        child: Text(
                          'I HAVE ACTIVITY ALREADY',
                          style: TextStyle(color: AppColors.MAIN_COLOR),
                        ),
                      ),
                      Text('Linh đẹp trai'),
                    ],
                  ),
            ),
          ),
        ),
      ),
    );
  }

  void submitActivity(WelcomeState state, String value) {
    if (!(state is CreateActivityLoading)) {
      _welcomeBloc.add(CreateActivityEvent(value));
    }
  }
}
