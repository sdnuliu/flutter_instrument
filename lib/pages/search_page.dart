import 'package:flutter/material.dart';
import 'package:flutter_instrument/dao/search_dao.dart';
import 'package:flutter_instrument/model/search_model.dart';
import 'package:flutter_instrument/widget/search_bar_widget.dart';

///搜索页
class SearchPage extends StatefulWidget {
  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  SearchModel _searchModel;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        _appBar(),
        MediaQuery.removePadding(
            context: context,
            removeTop: true,
            child: Expanded(child: ListView.builder(
                itemCount: _searchModel?.data?.length ?? 0,
                itemBuilder: (BuildContext context, int position) {
                  return _item(position);
                }), flex: 1,))
      ],
    );
  }

  void _onTextChange(String value) {
    if (value.length == 0) {
      _searchModel = null;
    } else {
      SearchDao.fetch(value).then((res) {
        if (value == res.keyword) {
          setState(() {
            _searchModel = res;
          });
        }
      }).catchError((e) {
        print(e);
      });
    }
  }

  Widget _appBar() {
    return Column(
      children: <Widget>[
        Container(
          decoration: BoxDecoration(
              gradient: LinearGradient(
                  colors: [Color(0x66000000), Colors.transparent],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter)
          ),
          child: Container(
            padding: EdgeInsets.only(top: 30),
            height: 70,
            decoration: BoxDecoration(color: Colors.white),
            child: SearchBar(
              hideLeft: true,
              hint: '网红打卡地 景点 美食 酒店',
              leftButtonClick: () {
                Navigator.of(context).pop();
              },
              onChanged: _onTextChange,
            ),
          ),
        )
      ],
    );
  }

  Widget _item(int position) {
    if (_searchModel == null || _searchModel.data == null) return null;
    Data data = _searchModel.data[position];
    return Text(data.word);
  }
}
