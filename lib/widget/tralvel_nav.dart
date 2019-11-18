import 'package:flutter/material.dart';
import 'package:flutter_instrument/model/home_model.dart';
import 'package:flutter_instrument/widget/custom_webview.dart';

class TravelNavWidget extends StatelessWidget {
  GridNav gridNav;

  TravelNavWidget({Key key, this.gridNav}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return PhysicalModel(
      color: Colors.transparent,
      borderRadius: BorderRadius.circular(6),
      clipBehavior: Clip.antiAlias,
      child: Column(
        children: _getItems(context, gridNav),
      ),
    );
  }

  List<Widget> _getItems(BuildContext context, GridNav gridNav) {
    if (gridNav == null) return null;
    List<Widget> widgets = [];
    if (gridNav.hotel != null) {
      widgets.add(_getItem(gridNav.hotel, context, true));
    }
    if (gridNav.flight != null) {
      widgets.add(_getItem(gridNav.flight, context, false));
    }
    if (gridNav.travel != null) {
      widgets.add(_getItem(gridNav.travel, context, false));
    }
    return widgets;
  }

  Widget _getItem(Hotel hotel, BuildContext context, bool isFirst) {
    Color startColor = Color(int.parse('0xff${hotel.startColor}'));
    Color endColor = Color(int.parse('0xff${hotel.endColor}'));
    return Container(
      height: 88,
      margin: isFirst ? null : EdgeInsets.only(top: 3),
      decoration: BoxDecoration(
        gradient: LinearGradient(colors: [startColor, endColor]),
      ),
      child: Row(
        children: <Widget>[
          Expanded(
            child: _getMainItem(context, hotel.mainItem),
            flex: 1,
          ),
          Expanded(
            child: _getDoubleItem(context, hotel.item1, hotel.item2, true),
            flex: 1,
          ),
          Expanded(
            child: _getDoubleItem(context, hotel.item3, hotel.item4, false),
            flex: 1,
          ),
        ],
      ),
    );
  }

  Widget _getMainItem(BuildContext context, Item mainItem) {
    return _wrapGesture(
        context,
        Stack(
          alignment: Alignment.topCenter,
          children: <Widget>[
            Container(
              margin: EdgeInsets.only(top: 11),
              child: Text(
                mainItem.title,
                style: TextStyle(fontSize: 14, color: Colors.white),
              ),
            ),
            Image.network(
              mainItem.icon,
              width: 121,
              height: 88,
              alignment: AlignmentDirectional.bottomEnd,
              fit: BoxFit.contain,
            )
          ],
        ),
        mainItem);
  }

  Widget _getDoubleItem(
      BuildContext context, Item topItem, Item bottomItem, bool isMiddle) {
    return Column(
      children: <Widget>[
        Expanded(
          child: _getSingleItem(context, topItem, true),
          flex: 1,
        ),
        Expanded(
          child: _getSingleItem(context, bottomItem, false),
          flex: 1,
        )
      ],
    );
  }

  Widget _getSingleItem(BuildContext context, Item item, bool isFirst) {
    BorderSide borderSide = BorderSide(width: 0.8, color: Colors.white);
    return FractionallySizedBox(
      //撑满父布局的宽度
      widthFactor: 1,
      child: Container(
        decoration: BoxDecoration(
            border: Border(
          left: borderSide,
          bottom: isFirst ? borderSide : BorderSide.none,
        )),
        child: _wrapGesture(
            context,
            Center(
              child: Text(
                item.title,
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 14, color: Colors.white),
              ),
            ),
            item),
      ),
    );
  }

  Widget _wrapGesture(BuildContext context, Widget widget, Item item) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => CustomWebview(
                      url: item.url,
                      statusBarColor: item.statusBarColor,
                      title: item.title,
                      hideAppBar: item.hideAppBar,
                    )));
      },
      child: widget,
    );
  }
}
