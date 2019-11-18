import 'package:flutter/material.dart';
import 'package:flutter_instrument/model/home_model.dart';
import 'package:flutter_instrument/widget/custom_webview.dart';

class GridNavWidget extends StatelessWidget {
  List<LocalNavList> localNavList;

  GridNavWidget({Key key, @required this.localNavList}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 70,
      decoration: BoxDecoration(
          color: Colors.white, borderRadius: BorderRadius.circular(6)),
      padding: EdgeInsets.only(top: 7),
      child: _items(context),
    );
  }

  Widget _items(BuildContext context) {
    List<Widget> widgets = [];
    if (localNavList == null) {
      return null;
    }
    localNavList.forEach((item) {
      widgets.add(_buildItem(context, item));
    });
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: widgets,
    );
  }

  Widget _buildItem(BuildContext context, LocalNavList item) {
    return GestureDetector(
      onTap: () {
        Navigator.of(context).push(MaterialPageRoute(
            builder: (BuildContext context) => CustomWebview(
                  url: item.url,
                  statusBarColor: item.statusBarColor,
                  title: item.title,
                  hideAppBar: item.hideAppBar,
                )));
      },
      child: Column(
        children: <Widget>[
          Image.network(
            item.icon,
            width: 35,
            height: 35,
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
    );
  }
}
