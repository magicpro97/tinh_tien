import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

class ActionItem extends StatelessWidget {
  final Color backgroundColor;
  final Icon icon;
  final Text text;

  const ActionItem(
      {Key key,
      this.backgroundColor = Colors.white,
      @required this.icon,
      @required this.text})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
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
    ;
  }
}

final defaultActionItems = [
  ActionItem(
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
  ActionItem(
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
];

void defaultOnDismissed(BuildContext context, String message) {
  Scaffold.of(context).showSnackBar(SnackBar(
    content: Text(message),
  ));
}

Future<T> defaultOnWillDismiss<T>(BuildContext context, String message) {
  return showDialog<T>(
      context: context,
      builder: (_) {
        return AlertDialog(
          title: Text('Delete'),
          content: Text(message),
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
}

SlidableDismissal defaultDismissal(BuildContext context,
    String onWillDismissMessage, String onDismissedMessage) {
  return SlidableDismissal(
    child: SlidableDrawerDismissal(),
    onWillDismiss: (actionType) {
      return defaultOnWillDismiss<bool>(context, onWillDismissMessage);
    },
    onDismissed: (actionType) {
      defaultOnDismissed(context, onDismissedMessage);
    },
  );
}
