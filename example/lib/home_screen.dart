import 'package:example/full_form_screen.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('FormBuilder Example'),
      ),
      body: ListView(
        children: <Widget>[
          ListTile(
            title: Text("Complete Form"),
            trailing: Icon(Icons.chevron_right),
            onTap: () => Navigator.of(context).push(
              MaterialPageRoute(
                builder: (_) => FullFormScreen(),
              ),
            ),
          ),
          Divider(),
        ],
      ),
    );
  }
}
