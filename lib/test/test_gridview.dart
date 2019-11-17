import 'package:flutter/material.dart';

class TestGridViewPage extends StatefulWidget {
  @override
  _TestGridViewPageState createState() => _TestGridViewPageState();
}

class _TestGridViewPageState extends State<TestGridViewPage> {
  static const mDatas = [
    '北京1',
    '北京2',
    '北京3',
    '北京4',
    '北京5',
    '北京6',
    '北京7',
    '北京8',
    '北京9',
    '北京10',
    '北京11'
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('GridViewDemo'),
        leading: BackButton(),
      ),
      body: Container(
        child: GridView.count(crossAxisCount: 2,children: _getItems()),),
    );
  }

  List<Widget> _getItems() {
    return mDatas.map((item)=>_getItem(item)).toList();
  }

  Widget _getItem(String item) {
    return Container(
      height: 80,
      margin: EdgeInsets.only(bottom: 1,right: 1),
      alignment: Alignment.center,
      decoration: BoxDecoration(color: Colors.amberAccent),
      child: Text(item),
    );
  }
}
