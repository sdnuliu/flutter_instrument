import 'package:flutter/material.dart';

class TestExpansionTilePage extends StatefulWidget {
  @override
  _State createState() => _State();
}

class _State extends State<TestExpansionTilePage> {
  static const mDatas={'北京':['朝阳区','海淀区','西城区'],'北京1':['朝阳区1','海淀区1','西城1区'],'北京2':['朝阳区2','海淀区2','西城区2'],'北京3':['朝阳区3','海淀区3','西城区3'],};
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('ExpansionTileDemo'),
        leading: BackButton(),
      ),
      body: Container(
        child: ListView(
          children:  _getWidgets(),
        ),
      ),
    );
  }

  List<Widget> _getWidgets() {
    List<Widget> widgets=[];
   mDatas.keys.forEach((item){
            widgets.add(_buildItem(item,mDatas[item]));
    });
   return widgets;
  }

  Widget _buildItem(String item, List<String> mData) {
    return Container(
      child: ExpansionTile(title: Text(item),
      children: mData.map((item)=>_buildSubItem(item)).toList()),
    );
  }

  Widget _buildSubItem(String item) {
    return FractionallySizedBox(
      widthFactor: 1,
      child: Container(
        height: 50,
        margin: EdgeInsets.only(bottom: 5),
        padding: EdgeInsets.only(left: 8),
        alignment: Alignment.centerLeft,
        decoration: BoxDecoration(color: Colors.blue),
        child: Text(item),
      ),
    );
  }
}
