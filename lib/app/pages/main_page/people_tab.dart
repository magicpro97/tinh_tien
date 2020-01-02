import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:tinh_tien/common/dimens.dart';

class PeopleTab extends StatelessWidget {
  final SlidableController slidableController = SlidableController();

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
            (index) => _peopleItem(context, index),
          ),
        ],
      ),
    );
  }

  Widget _peopleItem(BuildContext context, int index) {
    return Slidable(
      key: Key('$index'),
      controller: slidableController,
      dismissal: SlidableDismissal(
        child: SlidableDrawerDismissal(),
        onWillDismiss: (actionType) {
          return showDialog<bool>(
              context: context,
              builder: (_) {
                return AlertDialog(
                  title: Text('Delete'),
                  content: Text('People will be delete'),
                  actions: <Widget>[
                    FlatButton(
                      child: Text('Cancel'),
                      onPressed: () => Navigator.of(context).pop(false),
                    ),
                    FlatButton(
                      child: Text('Ok'),
                      onPressed: () => Navigator.of(context).pop(true),
                    ),
                  ],
                );
              });
        },
        onDismissed: (actionType) {
          Scaffold.of(context).showSnackBar(SnackBar(
            content: Text('People is deleted.'),
          ));
        },
      ),
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
