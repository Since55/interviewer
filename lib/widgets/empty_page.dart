import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class EmptyPage extends StatelessWidget {
  final String text;

  const EmptyPage({Key key, this.text}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        this.text,
        style: Theme.of(context).textTheme.headline6,
      ),
    );
  }
}
