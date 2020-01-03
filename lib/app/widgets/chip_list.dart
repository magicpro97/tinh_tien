import 'package:flutter/material.dart';
import 'package:tinh_tien/app/widgets/app_chip.dart';

import '../../common/dimens.dart';

class ChipList extends StatelessWidget {
  final List<AppChip> chips;

  const ChipList({Key key, @required this.chips}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      color: Colors.grey[200],
      padding: const EdgeInsets.all(Dimens.SMALL_PADDING),
      child: Wrap(
        children: chips,
      ),
    );
  }
}
