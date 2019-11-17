import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class TestLocalSavePage extends StatefulWidget {
  @override
  _TestLocalSavePageState createState() => _TestLocalSavePageState();
}

class _TestLocalSavePageState extends State<TestLocalSavePage> {
  int _count = 0;
  @override
  Widget build(BuildContext context) {
    _getCount();
    return Scaffold(
      appBar: AppBar(
        title: Text('测试本地存储'),
        leading: BackButton(),
      ),
      body: Container(
        child: Column(
          children: <Widget>[
            RaisedButton(
              onPressed: _autoAddOne,
              child: Text('AddOne'),
            ),
            Text('local saved count:$_count'),
          ],
        ),
      ),
    );
  }

  _autoAddOne() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      _count = (prefs.getInt('counter') ?? 0) + 1;
    });
    await prefs.setInt('counter', _count);
  }

  _getCount() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      _count = (prefs.getInt('counter') ?? 0);
    });
  }
}
