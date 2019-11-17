import 'dart:ffi';

import 'package:flutter/material.dart';

class TestRefreshLoadMorePage extends StatefulWidget {
  @override
  _TestRefreshLoadMorePageState createState() => _TestRefreshLoadMorePageState();
}

class _TestRefreshLoadMorePageState extends State<TestRefreshLoadMorePage> {
  ScrollController _myController=ScrollController();
  List<String> mDatas = [
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
  void initState() {
    _myController.addListener((){
//      print(_myController.position.pixels.toString());
//      print('最大${_myController.position.maxScrollExtent.toString()}');
      if(_myController.position.pixels==_myController.position.maxScrollExtent){
        _loadMore();
      }
    });
    super.initState();
  }
  @override
  void dispose() {
    _myController.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('RefreshAndLoadMoreDemo'),
        leading: BackButton(),
      ),
      body:RefreshIndicator(child:  ListView(
        controller: _myController,
        children: _buildList(),
      ), onRefresh: _doWithRefresh)
    );
  }
  List<Widget> _buildList() {
    List<Widget> widgets=mDatas.map((item) => _getItemView(item)).toList();
      widgets.add( Container(
        padding: const EdgeInsets.all(16.0),
        alignment: Alignment.center,
        child: SizedBox(
            width: 24.0,
            height: 24.0,
            child: CircularProgressIndicator(strokeWidth: 2.0)
        ),
      ));
    return widgets;
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

  Future<void> _doWithRefresh() async{
    await Future.delayed(Duration(seconds: 1));
    setState(() {
      mDatas=mDatas.reversed.toList();
    });
    return null;
  }

  void _loadMore() async{
    await Future.delayed(Duration(milliseconds: 1000));
    setState(() {
      mDatas.addAll(List<String>.from(mDatas));
    });
  }
}
