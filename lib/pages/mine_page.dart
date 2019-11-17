

import 'package:flutter/material.dart';
import 'package:flutter_instrument/test/test_expansiontile.dart';
import 'package:flutter_instrument/test/test_gridview.dart';
import 'package:flutter_instrument/test/test_http.dart';
import 'package:flutter_instrument/test/test_listview.dart';
import 'package:flutter_instrument/test/test_local_save.dart';
import 'package:flutter_instrument/test/test_refresh_loadmore.dart';

///我的页
class MinePage extends StatefulWidget {
  @override
  _MinePageState createState() => _MinePageState();
}

class _MinePageState extends State<MinePage> {
 Map<String,Widget>mDatas={'HttpTestDemo':TestHtpPage(),'LocalSaveTestDemo':TestLocalSavePage(),
   'ListViewDemo':TestListViewPage(),'ExpansionTileDemo':TestExpansionTilePage(),
   'GridViewDemo':TestGridViewPage(),'RefreshAndLoadMoreDemo':TestRefreshLoadMorePage()};
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
      child: ListView(
        children: _getItems(),
      ),
    ));
  }

  List<Widget> _getItems() {
    List<Widget> widgets=[];
    mDatas.keys.forEach((item){
      widgets.add(_buildWidget(item,mDatas[item]));
    });
    return widgets;
  }

  Widget _buildWidget(String item, Widget mData) {
    return
      RaisedButton(
        onPressed: () {
          Navigator.of(context).push(MaterialPageRoute(
            builder: (context) {
              //指定跳转的页面
              return mData;
            },
          ));
        },
        child: Text(item),
      );
  }
}
