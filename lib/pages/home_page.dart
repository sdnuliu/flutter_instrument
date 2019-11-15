import 'package:flutter/material.dart';
import 'package:flutter_swiper/flutter_swiper.dart';

const APPBAR_SCROLL_OFFSET = 100;

///首页
class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List _image_urls = [
    'https://img1.17img.cn/ui/bimg/SH100000/APP/112548020191028.png',
    'https://img1.17img.cn/ui/simg/instrument/SH100000/20190527/20190527.gif',
    'https://img1.17img.cn/ui/bimg/1125_480yzlx.jpg',
    'https://img1.17img.cn/ui/bimg/SH100000/APP/banner/112548020191114.jpg',
    'https://img1.17img.cn/ui/simg/instrument/child/app/kc1125480.jpg'
  ];
  double _appbarAlpha = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: <Widget>[
          MediaQuery.removePadding(
              context: context,
              removeTop: true,
              child: NotificationListener(
                  onNotification: (scrollNotification) {
                    //只监听listview的滚动
                    if (scrollNotification is ScrollUpdateNotification &&
                        scrollNotification.depth == 0) {
                      _onScroll(scrollNotification.metrics.pixels);
                    }
                    return false;
                  },
                  child: ListView(
                    children: <Widget>[
                      Container(
                        height: 180,
                        child: Swiper(
                          itemCount: _image_urls.length,
                          autoplay: true,
                          itemBuilder: (BuildContext context, int index) {
                            return Image.network(
                              _image_urls[index],
                              fit: BoxFit.cover,
                            );
                          },
                          pagination: SwiperPagination(
                              builder: DotSwiperPaginationBuilder(
                                  size: 6, activeSize: 8)),
                        ),
                      ),
                      Container(
                        height: 800,
                        child: ListTile(
                          title: Text('内容待开发，待完善'),
                        ),
                      )
                    ],
                  ))),
          Opacity(
            opacity: _appbarAlpha,
            child: Container(
              height: 70,
              decoration: BoxDecoration(color: Colors.white),
              child: Center(
                child: Padding(
                  padding: EdgeInsets.only(top: 20),
                  child: Text('首页'),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }

  void _onScroll(double offset) {
    double alpha = offset / APPBAR_SCROLL_OFFSET;
    if (alpha < 0) {
      alpha = 0;
    } else if (alpha > 1) {
      alpha = 1;
    }
   setState(() {
     _appbarAlpha = alpha;
   });
  }
}
