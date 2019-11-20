import 'package:flutter/material.dart';
import 'package:flutter_instrument/dao/search_dao.dart';
import 'package:flutter_instrument/widget/search_bar_widget.dart';

///搜索页
class SearchPage extends StatefulWidget {
  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  String _searchResult;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Search'),
      ),
      body: Column(
        children: <Widget>[
          Container(
            padding: EdgeInsets.only(top: 8),
            child: SearchBar(
              hideLeft: true,
              hint: '网红打卡地 景点 美食 酒店',
              leftButtonClick: () {
                Navigator.of(context).pop();
              },
              onChanged: _onTextChange,
            ),
          ),
          Text(_searchResult ?? '')
        ],
      ),
    );
  }

  void _onTextChange(String value) {
    SearchDao.fetch(value).then((res) {
      setState(() {
        _searchResult = res.data[1].word;
      });
    }).catchError((e) {
      print(e);
    });
  }
}
