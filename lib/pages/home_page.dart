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
    'https://img1.17img.cn/otherfile/images/201911/ykt/0f812ae8-5b09-4784-94b6-d042cfef3d55.jpg',
    'https://img1.17img.cn/otherfile/images/201909/ykt/dd54fd65-bfc5-4a49-909a-6f75f87440c7.jpg',
    'https://img1.17img.cn/otherfile/images/201911/ykt/f5530e71-c293-44dd-91d2-ac8b6d19517a.jpg',
    'https://img1.17img.cn/otherfile/images/201910/ykt/d7895f47-5a10-41af-9db3-1d6928346480.jpg',
    'https://img1.17img.cn/otherfile/images/201910/ykt/26664a53-56e7-441b-8d08-2f084a2d1bda.jpg'
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
                        height: 160,
                        child: Swiper(
                          itemCount: _image_urls.length,
                          autoplay: true,
                          itemBuilder: (BuildContext context, int index) {
                            return Image.network(
                              _image_urls[index],
                              fit: BoxFit.cover,
                            );
                          },
                          pagination: SwiperPagination(),
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
