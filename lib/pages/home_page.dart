import 'package:flutter/material.dart';
import 'package:flutter_instrument/dao/home_dao.dart';
import 'package:flutter_instrument/model/home_model.dart';
import 'package:flutter_instrument/widget/grid_nav.dart';
import 'package:flutter_instrument/widget/load_container.dart';
import 'package:flutter_instrument/widget/salex_box_botttom.dart';
import 'package:flutter_instrument/widget/search_bar_widget.dart';
import 'package:flutter_instrument/widget/sub_nav.dart';
import 'package:flutter_instrument/widget/tralvel_nav.dart';
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
  HomeModel _homeModel;
  bool isLoading=true;

  @override
  void initState() {
    _loadData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xfff2f2f2),
      body: LoadingContainer(
        isLoading: isLoading,
        child: Stack(
          children: <Widget>[
            MediaQuery.removePadding(
                context: context,
                removeTop: true,
                child: RefreshIndicator(
                  onRefresh: _loadData,
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
                          Padding(
                            padding: EdgeInsets.all(7),
                            child: GridNavWidget(
                              localNavList: _homeModel?.localNavList,
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.fromLTRB(7, 4, 7, 4),
                            child: TravelNavWidget(
                              gridNav: _homeModel?.gridNav,
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.fromLTRB(7, 4, 7, 4),
                            child: SubNavWidget(
                              subNavList: _homeModel?.subNavList,
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.fromLTRB(7, 4, 7, 4),
                            child: SalesBoxWidget(
                              salesBox: _homeModel?.salesBox,
                            ),
                          ),
                        ],
                      )),
                )),
            Column(
              children: <Widget>[
                Container(
                  decoration: BoxDecoration(
                      gradient: LinearGradient(
                          colors: [Color(0x66000000), Colors.transparent],
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter)
                  ),
                  child: Container(
                    padding: EdgeInsets.fromLTRB(0, 30, 0, 0),
                    height: 80,
                    decoration: BoxDecoration(
                      color: Color.fromARGB(
                          (_appbarAlpha * 255).toInt(), 255, 255, 255),
                    ),
                    child: SearchBar(
                      searchBarType: _appbarAlpha > 0.2 ? SearchBarType
                          .homeLight : SearchBarType.home,
                      inputBoxClick: _jumpToSearch,
                      speakClick: _jumpToSpeak,
                      defaultText: '网红打卡地 景点 美食 酒店',
                      leftButtonClick: () {},
                    ),
                  ),
                ),
                Container(
                  height: _appbarAlpha > 0.2 ? 0.5 : 0,
                  decoration: BoxDecoration(
                      boxShadow: [
                        BoxShadow(color: Colors.black12, blurRadius: 0.5)
                      ]
                  ),
                )
              ],
            )
          ],
        ),
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

  Future<Null> _loadData() async {
    HomeDao.fetch().then((res) {
      setState(() {
        _homeModel = res;
        isLoading=false;
      });
    }).catchError((e) {
      print(e);
    });
    return null;
  }

  void _jumpToSearch() {

  }

  void _jumpToSpeak() {

  }
}
