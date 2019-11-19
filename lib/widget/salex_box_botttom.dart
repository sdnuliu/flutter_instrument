import 'package:flutter/material.dart';
import 'package:flutter_instrument/model/home_model.dart';
import 'package:flutter_instrument/widget/custom_webview.dart';

class SalesBoxWidget extends StatelessWidget {
  SalesBox salesBox;

  SalesBoxWidget({Key key, this.salesBox}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: Colors.white, borderRadius: BorderRadius.circular(6)),
      padding: EdgeInsets.fromLTRB(0, 0, 0, 7),
      child: _items(context),
    );
  }

  Widget _items(BuildContext context) {
    if (salesBox == null) return null;
    return Column(
      children: <Widget>[
        _getTopItem(context),
        _doubleItem(context, salesBox.bigCard1, salesBox.bigCard2, true,false),
        _doubleItem(context, salesBox.smallCard1, salesBox.smallCard2, false,false),
        _doubleItem(context, salesBox.smallCard3, salesBox.smallCard4, false,true),
      ],
    );
  }

  Widget _getTopItem(BuildContext context) {
    return Container(
      height: 44,
      decoration: BoxDecoration(
          border:
              Border(bottom: BorderSide(width: 1, color: Color(0xfff2f2f2)))),
      child: Container(
        margin: EdgeInsets.only(left: 10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Image.network(
              salesBox.icon,
              fit: BoxFit.contain,
              height: 15,
            ),
            Container(
              padding: EdgeInsets.fromLTRB(10, 1, 8, 1),
              margin: EdgeInsets.only(right: 7),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  gradient: LinearGradient(colors: [
                    Color(0xffff4e63),
                    Color(0xffff6cc9),
                  ], begin: Alignment.centerLeft, end: Alignment.centerRight)),
              child: GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) =>
                          CustomWebview(url: salesBox.moreUrl, title: '更多活动'),
                    ),
                  );
                },
                child: Text(
                  '获取更多福利 >',
                  style: TextStyle(color: Colors.white, fontSize: 12),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget _doubleItem(
      BuildContext context, Item leftcard, Item rightcard, bool isBig,bool isBottom) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        _item(context, leftcard, true, isBig,isBottom),
        _item(context, rightcard, false, isBig,isBottom),
      ],
    );
  }

  Widget _item(BuildContext context, Item item, bool isLeft, bool isBig,bool isBottom) {
    BorderSide borderSide = BorderSide(width: 1, color: Color(0xfff2f2f2));
    return GestureDetector(
        onTap: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => CustomWebview(
                        url: item.url,
                        statusBarColor: item.statusBarColor,
                        hideAppBar: item.hideAppBar,
                      )));
        },
        child: Container(
          decoration: BoxDecoration(
              border: Border(
                  right: isLeft ? borderSide : BorderSide.none,
                  bottom: isBottom?BorderSide.none:borderSide)),
          child: Image.network(
            item.icon,
            fit: BoxFit.fill,
            width: MediaQuery.of(context).size.width / 2 - 8,
            height: isBig ? 119 : 75,
          ),
        ));
  }
}
