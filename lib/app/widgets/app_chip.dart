import 'package:flutter/material.dart';
import 'package:tinh_tien/common/colors.dart';

class AppChip<T> extends StatefulWidget {
  final String label;
  final Function(bool, T) onChanged;
  final Color selectedColor;
  final Color unselectedColor;
  final T value;

  const AppChip({
    Key key,
    @required this.label,
    @required this.onChanged,
    this.selectedColor = AppColors.MAIN_COLOR,
    this.unselectedColor = AppColors.WHITE_TEXT, this.value,
  }) : super(key: key);

  @override
  _AppChipState createState() => _AppChipState();
}

class _AppChipState extends State<AppChip> {
  bool _selected = false;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: GestureDetector(
        child: Chip(
          label: Text(
            widget.label,
            style: TextStyle(
                color:
                    _selected ? widget.unselectedColor : widget.selectedColor),
          ),
          backgroundColor:
              _selected ? widget.selectedColor : widget.unselectedColor,
        ),
        onTap: () {
          setState(() {
            _selected = !_selected;
          });
          widget.onChanged(_selected, widget.value);
        },
      ),
    );
  }
}
