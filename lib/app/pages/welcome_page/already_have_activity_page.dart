import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:qr_mobile_vision/qr_camera.dart';
import 'package:tinh_tien/app/blocs/activity/bloc.dart';
import 'package:tinh_tien/app/route.dart';
import 'package:tinh_tien/app/widgets/app_button.dart';
import 'package:tinh_tien/common/colors.dart';
import 'package:tinh_tien/common/dimens.dart';

class AlreadyHaveActivityPage extends StatefulWidget {
  @override
  _AlreadyHaveActivityPageState createState() =>
      _AlreadyHaveActivityPageState();
}

class _AlreadyHaveActivityPageState extends State<AlreadyHaveActivityPage> {
  ActivityBloc _welcomeBloc;
  TextEditingController _idController;

  @override
  void initState() {
    _welcomeBloc = BlocProvider.of<ActivityBloc>(context);
    _idController = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    _idController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: QrCamera(
      qrCodeCallback: (code) {
        _welcomeBloc.add(GetActivityEvent(activityId: code));
      },
      child: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(Dimens.NORMAL_PADDING),
          child: BlocListener<ActivityBloc, ActivityState>(
            bloc: _welcomeBloc,
            listener: (_, state) {
              if (state is ActivityLoadedState) {
                Navigator.pushNamedAndRemoveUntil(
                    context, HOME_PAGE, (routes) => false);
              }
            },
            child: BlocBuilder<ActivityBloc, ActivityState>(
              bloc: _welcomeBloc,
              builder: (_, state) {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Container(
                      height: kToolbarHeight,
                      child: Row(
                        children: <Widget>[
                          FlatButton.icon(
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            icon: Icon(
                              Icons.arrow_back,
                              color: Colors.white,
                            ),
                            label: Container(),
                          ),
                          Text(
                            'Scan your QR code',
                            style: Theme.of(context)
                                .textTheme
                                .title
                                .apply(color: AppColors.WHITE_TEXT),
                          ),
                        ],
                      ),
                    ),
                    Placeholder(
                      fallbackWidth: 300,
                      fallbackHeight: 300,
                    ),
                    SizedBox(
                      height: Dimens.NORMAL_PADDING,
                    ),
                    TextField(
                      controller: _idController,
                      decoration: InputDecoration(
                          fillColor: AppColors.MAIN_COLOR,
                          border: OutlineInputBorder(),
                          hintText: 'Type your activity id',
                          hintStyle: TextStyle(
                            color: AppColors.WHITE_TEXT,
                          )),
                      onSubmitted: (value) {
                        _welcomeBloc.add(GetActivityEvent(activityId: value));
                      },
                    ),
                    if (state is ActivityErrorState) Center(child: Text(state.message)),
                    state is ActivityLoadingState
                        ? CircularProgressIndicator()
                        : Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              AppButton(
                                onPressed: () {
                                  _welcomeBloc.add(
                                      GetActivityEvent(activityId: _idController.text));
                                },
                                text: 'Enter',
                              ),
                            ],
                          )
                  ],
                );
              },
            ),
          ),
        ),
      ),
    ));
  }
}
