import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loading/indicator/ball_scale_indicator.dart';
import 'package:loading/loading.dart';
import 'package:tinh_tien/app/blocs/activity/bloc.dart';
import 'package:tinh_tien/common/colors.dart';

class AppTextField extends StatelessWidget {
  final bool editMode;
  final String hintText;
  final String addLabelText;
  final String editLabelText;
  final String helpText;
  final String errorText;
  final TextEditingController controller;
  final Function onDone;
  final FocusNode focusNode;

  const AppTextField(
      {Key key,
      this.editMode = false,
      this.hintText,
      @required this.addLabelText,
      @required this.editLabelText,
      this.errorText,
      @required this.controller,
      this.onDone,
      @required this.focusNode,
      this.helpText})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: TextField(
        focusNode: focusNode,
        controller: controller,
        minLines: 1,
        decoration: InputDecoration(
          labelText: editMode ? editLabelText : addLabelText,
          hintText: hintText,
          errorText: errorText,
          suffixIcon: editMode
              ? null
              : BlocBuilder<ActivityBloc, ActivityState>(
              bloc: BlocProvider.of<ActivityBloc>(context),
              builder: (context, state) {
                return state is ActivityLoadingState
                    ? Loading(
                  indicator: BallScaleIndicator(),
                  color: Theme
                      .of(context)
                      .primaryColor,
                  size: 10.0,
                )
                    : IconButton(
                  icon: Icon(Icons.add),
                  onPressed: () => _onPressed(context),
                );
              }),
          suffix: editMode
              ? OutlineButton.icon(
                  label: Text(
                    'Done',
                    style: Theme.of(context)
                        .textTheme
                        .button
                        .apply(color: AppColors.MAIN_COLOR),
                  ),
                  icon: Icon(
                    Icons.edit,
                    color: AppColors.MAIN_COLOR,
                  ),
                  borderSide: BorderSide(
                    color: AppColors.MAIN_COLOR,
                  ),
                  onPressed: () => _onPressed(context),
                )
              : null,
          helperText: helpText,
          border: InputBorder.none,
        ),
        onSubmitted: (value) {
          _onPressed(context);
        },
      ),
    );
  }

  void _onPressed(BuildContext context) {
    onDone();
    Future.delayed(Duration(milliseconds: 50)).then((_) {
      controller.clear();
      FocusScope.of(context).unfocus();
    });
  }
}
