import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:tinh_tien/common/dimens.dart';

class PeopleTab extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(horizontal: Dimens.NORMAL_PADDING),
      child: Column(
        children: <Widget>[
          Padding(
            padding:
                const EdgeInsets.symmetric(vertical: Dimens.NORMAL_PADDING),
            child: TextField(
              minLines: 1,
              decoration: InputDecoration(
                hintText: 'Enter name...',
                suffixIcon: Icon(Icons.add),
                border: InputBorder.none,
              ),
            ),
          ),
          ...List.generate(
            10,
            (index) => _peopleItem(),
          ),
        ],
      ),
    );
  }

  Widget _peopleItem() {
    return Slidable(
      child: Container(
        color: Colors.white,
        child: ListTile(
          title: Text('1'),
        ),
      ),
      actionPane: SlidableBehindActionPane(),
      secondaryActions: <Widget>[
        _actionItem(
          icon: Icon(
            Icons.edit,
            color: Colors.white,
          ),
          text: Text(
            'Edit',
            style: TextStyle(color: Colors.white),
          ),
          backgroundColor: Colors.indigo,
        ),
        _actionItem(
          icon: Icon(
            Icons.remove,
            color: Colors.white,
          ),
          text: Text(
            'Remove',
            style: TextStyle(color: Colors.white),
          ),
          backgroundColor: Colors.red,
        ),
      ],
    );
  }

  Widget _actionItem({Icon icon, Text text, Color backgroundColor}) {
    return Container(
      color: backgroundColor,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          icon,
          text,
        ],
      ),
    );
  }
}
