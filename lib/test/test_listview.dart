import 'package:flutter/material.dart';

class TestListViewPage extends StatefulWidget {
  @override
  _TestListViewPageState createState() => _TestListViewPageState();
}

class _TestListViewPageState extends State<TestListViewPage> {
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
        title: Text('ListViewDemo'),
        leading: BackButton(),
      ),
//      body: ListView(
//        children: _buildList(),
//      ),
    body: Container(
      height: 80, child:ListView(
          scrollDirection: Axis.horizontal,
          children: _buildList(),
        )
    ),
    );
  }

  List<Widget> _buildList() {
//    return mDatas.map((item) => _getItemView(item)).toList();
    return mDatas.map((item) => _getHorizontalItemView(item)).toList();
  }

  Widget _getItemView(String item) {
    return Container(
      height: 80,
      margin: EdgeInsets.only(bottom: 8),
      alignment: Alignment.center,
      decoration: BoxDecoration(color: Colors.amberAccent),
      child: Text(item),
    );
  }

  Widget _getHorizontalItemView(String item) {
    return Container(
      width: 120,
      margin: EdgeInsets.only(right: 8),
      alignment: Alignment.center,
      decoration: BoxDecoration(color: Colors.amber),
      child: Text(item),
    );
  }
}
