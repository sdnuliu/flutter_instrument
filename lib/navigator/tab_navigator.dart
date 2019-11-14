import 'package:flutter/material.dart';
import 'package:flutter_instrument/pages/home_page.dart';
import 'package:flutter_instrument/pages/mine_page.dart';
import 'package:flutter_instrument/pages/pic_page.dart';
import 'package:flutter_instrument/pages/search_page.dart';

///底部导航
class TabNavigator extends StatefulWidget {
  @override
  _TabNavigatorState createState() => _TabNavigatorState();
}

class _TabNavigatorState extends State<TabNavigator> {
  final _controller = PageController(initialPage: 0);
  var _currentIndex = 0;
  final _defalutColor = Colors.grey;
  final _activeColor = Colors.blue;
  final double _homeBottomFontSize = 13;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        controller: _controller,
        children: <Widget>[
          HomePage(),
          SearchPage(),
          PicPage(),
          MinePage(),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
          currentIndex: _currentIndex,
          onTap: (tapPage) {
            _controller.jumpToPage(tapPage);
            setState(() {
              _currentIndex = tapPage;
            });
          },
          type: BottomNavigationBarType.fixed,
          items: [
            BottomNavigationBarItem(
                icon: Icon(Icons.home, color: _defalutColor),
                activeIcon: Icon(Icons.home, color: _activeColor),
                title: Text(
                  '首页',
                  style: TextStyle(
                      color: _currentIndex == 0 ? _activeColor : _defalutColor,
                      fontSize: _homeBottomFontSize),
                )),
            BottomNavigationBarItem(
                icon: Icon(Icons.search, color: _defalutColor),
                activeIcon: Icon(Icons.search, color: _activeColor),
                title: Text(
                  '搜索',
                  style: TextStyle(
                      color: _currentIndex == 1 ? _activeColor : _defalutColor,
                      fontSize: _homeBottomFontSize),
                )),
            BottomNavigationBarItem(
                icon: Icon(Icons.camera_alt, color: _defalutColor),
                activeIcon: Icon(Icons.camera_alt, color: _activeColor),
                title: Text(
                  '美图',
                  style: TextStyle(
                      color: _currentIndex == 2 ? _activeColor : _defalutColor,
                      fontSize: _homeBottomFontSize),
                )),
            BottomNavigationBarItem(
                icon: Icon(Icons.account_circle, color: _defalutColor),
                activeIcon: Icon(Icons.account_circle, color: _activeColor),
                title: Text(
                  '我的',
                  style: TextStyle(
                      color: _currentIndex == 3 ? _activeColor : _defalutColor,
                      fontSize: _homeBottomFontSize),
                )),
          ]),
    );
  }
}
