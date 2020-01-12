import 'package:flutter/material.dart';

class EmptyList extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 10.0,
      child: Center(
              child: Text('Nothing to show'),
            ),
    );
  }
}
