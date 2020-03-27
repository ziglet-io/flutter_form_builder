import 'package:flutter/material.dart';

class FieldScreen extends StatelessWidget {
  final String fieldName;
  final Widget field;
  final String code;

  const FieldScreen(
      {Key key, @required this.fieldName, @required this.field, this.code})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(fieldName),),
      body: ListView(
          children: [
            field,
            Divider(),
            Text('${code ?? ''}'),
          ],
      ),
    );
  }
}
