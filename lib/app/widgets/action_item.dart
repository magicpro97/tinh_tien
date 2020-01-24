import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

class ActionItem extends StatelessWidget {
  final Color backgroundColor;
  final Icon icon;
  final Function onPressed;

  const ActionItem(
      {Key key,
      this.backgroundColor = Colors.white,
      @required this.icon,
      this.onPressed})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: backgroundColor,
      child: MaterialButton(
        onPressed: onPressed,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            icon,
          ],
        ),
      ),
    );
  }
}

class EditActionItem extends StatelessWidget {
  final Function onPressed;

  const EditActionItem({Key key, this.onPressed}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ActionItem(
      onPressed: onPressed,
      icon: Icon(
        Icons.edit,
        color: Colors.white,
      ),
      backgroundColor: Colors.indigo,
    );
  }
}

class DeleteActionItem extends StatelessWidget {
  final Function onPressed;

  const DeleteActionItem({Key key, this.onPressed}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ActionItem(
      onPressed: onPressed,
      icon: Icon(
        Icons.delete,
        color: Colors.white,
      ),
      backgroundColor: Colors.red,
    );
  }
}

List<Widget> defaultActionItems(
        Function editPressed, Function deletePressed) =>
    [
      EditActionItem(
        onPressed: editPressed,
      ),
      DeleteActionItem(
        onPressed: deletePressed,
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
