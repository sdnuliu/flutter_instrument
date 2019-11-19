import 'package:flutter/material.dart';
import 'package:flutter_instrument/model/home_model.dart';
import 'package:flutter_instrument/widget/custom_webview.dart';

class SubNavWidget extends StatelessWidget {
  List<SubNavList> subNavList;

  SubNavWidget({Key key, @required this.subNavList}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: Colors.white, borderRadius: BorderRadius.circular(6)),
      padding: EdgeInsets.fromLTRB(0, 7, 0, 7),
      child: _items(context),
    );
  }

  Widget _items(BuildContext context) {
    List<Widget> widgets = [];
    if (subNavList == null) {
      return null;
    }
    subNavList.forEach((item) {
      widgets.add(_buildItem(context, item));
    });
    //一行显示的个数
    var countOneRow = (subNavList.length / 2 + 0.5).toInt();
    return Column(
      children: <Widget>[
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: widgets.sublist(0, countOneRow),
        ),
        Padding(
          padding: EdgeInsets.only(top: 7),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: widgets.sublist(countOneRow, subNavList.length),
          ),
        )
      ],
    );
  }

  Widget _buildItem(BuildContext context, SubNavList item) {
    return Expanded(
      child: GestureDetector(
        onTap: () {
          Navigator.of(context).push(MaterialPageRoute(
              builder: (BuildContext context) => CustomWebview(
                    url: item.url,
                    title: item.title,
                    hideAppBar: item.hideAppBar,
                  )));
        },
        child: Column(
          children: <Widget>[
            Image.network(
              item.icon,
              width: 20,
              height: 20,
            ),
            Padding(
              padding: EdgeInsets.fromLTRB(0, 4, 0, 4),
              child: Text(
                item.title,
                style: TextStyle(fontSize: 12),
              ),
            )
          ],
        ),
      ),
      flex: 1,
    );
  }
}
