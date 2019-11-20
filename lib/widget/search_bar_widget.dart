import 'package:flutter/material.dart';
import 'package:flutter_color_plugin/flutter_color_plugin.dart';

class SearchBar extends StatefulWidget {
  bool hideLeft; //隐藏左边按钮
  bool enabled; //可输入状态
  String hint; //提示语
  String defaultText; //默认文字
  SearchBarType searchBarType; //样式
  void Function() leftButtonClick; //左边被点击
  void Function() rightButtonClick; //右边被点击
  void Function() speakClick; //语音被点击
  void Function() inputBoxClick; //输入框被点击
  ValueChanged<String> onChanged; //文字变化监听

  SearchBar(
      {Key key,
      this.hideLeft,
        this.enabled = true,
      this.hint,
      this.defaultText,
        this.searchBarType = SearchBarType.normal,
      this.leftButtonClick,
      this.rightButtonClick,
      this.speakClick,
      this.inputBoxClick,
      this.onChanged})
      : super(key: key);

  @override
  _SearchBarState createState() => _SearchBarState();
}

enum SearchBarType { home, normal, homeLight }

class _SearchBarState extends State<SearchBar> {
  bool showClear = false;
  final TextEditingController controller = TextEditingController();

  @override
  void initState() {
    if (widget.defaultText != null) {
      setState(() {
        controller.text = widget.defaultText;
      });
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    if (widget.searchBarType == SearchBarType.normal) {
      return _genNormalSearch();
    } else {
      return _genHomeSearch();
    }
  }

  Widget _genNormalSearch() {
    return Container(
      child: Row(
        children: <Widget>[
          _wrapTap(Container(
            padding: EdgeInsets.fromLTRB(6, 5, 10, 5),
            child: widget.hideLeft ?? false ? null : Icon(
              Icons.arrow_back_ios, color: Colors.grey, size: 26,),
          ), widget.leftButtonClick),
          Expanded(
            flex: 1,
            child: _inputBox(),
          ),
          _wrapTap(Container(
            padding: EdgeInsets.fromLTRB(10, 5, 10, 5),
            child: Text(
              '搜索', style: TextStyle(color: Colors.blue, fontSize: 17),),
          ), widget.rightButtonClick)
        ],
      ),
    );
  }

  Widget _genHomeSearch() {
    return Container(
      child: Row(
        children: <Widget>[
          _wrapTap(Container(
              padding: EdgeInsets.fromLTRB(6, 5, 5, 5),
              child: Row(
                children: <Widget>[
                  Text('北京',
                    style: TextStyle(color: _homeFontColor(), fontSize: 14),),
                  Icon(Icons.expand_more, color: _homeFontColor(), size: 22,)
                ],
              )
          ), widget.leftButtonClick),
          Expanded(
            flex: 1,
            child: _inputBox(),
          ),
          _wrapTap(Container(
            padding: EdgeInsets.fromLTRB(10, 5, 10, 5),
            child: Icon(Icons.comment, color: _homeFontColor(), size: 26,),
          ), widget.rightButtonClick)
        ],
      ),
    );
  }

  _wrapTap(Widget widget, Function callback) {
    return GestureDetector(
      child: widget,
      onTap: () {
        if (callback != null) {
          callback();
        }
      },
    );
  }

  Widget _inputBox() {
    Color inputBoxColor;
    if (widget.searchBarType == SearchBarType.home) {
      inputBoxColor = Colors.white;
    } else {
      inputBoxColor = ColorUtil.color("#ededed");
    }
    return Container(
      height: 30,
      padding: EdgeInsets.fromLTRB(10, 5, 10, 5),
      decoration: BoxDecoration(
        color: inputBoxColor,
        borderRadius: BorderRadius.circular(
            widget.searchBarType == SearchBarType.normal ? 5 : 18),
      ),
      child: Row(
        children: <Widget>[
          Icon(Icons.search, size: 20,
            color: widget.searchBarType == SearchBarType.normal ? ColorUtil
                .color(
                "#a9a9a9") : Colors.blue,),
          Expanded(flex: 1,
              child: widget.searchBarType == SearchBarType.normal ? TextField(
                controller: controller,
                onChanged: _onChanged,
                autofocus: true,
                style: TextStyle(fontSize: 18,
                    color: Colors.black,
                    fontWeight: FontWeight.w300),
                decoration: InputDecoration(
                  contentPadding: EdgeInsets.fromLTRB(5, 0, 5, 0),
                  border: InputBorder.none,
                  hintText: widget.hint ?? '',
                  hintStyle: TextStyle(fontSize: 15),
                ),) : _wrapTap(
                  Container(
                    padding: EdgeInsets.only(left: 5),
                    child: Text(
                      widget.defaultText,
                      style: TextStyle(fontSize: 13, color: Colors.grey),
                    ),), widget.inputBoxClick
              )),
          !showClear ? _wrapTap(Icon(Icons.mic, size: 22,
            color: widget.searchBarType == SearchBarType.normal
                ? Colors.blue
                : Colors.grey,), widget.speakClick) : _wrapTap(
              Icon(Icons.clear, size: 22, color: Colors.grey,), () {
            setState(() {
              controller.clear();
            });
            _onChanged("");
          }),
        ],
      ),);
  }

  void _onChanged(String value) {
    if (value.length > 0) {
      setState(() {
        showClear = true;
      });
    } else {
      setState(() {
        showClear = false;
      });
    }
    if (widget.onChanged != null) {
      widget.onChanged(value);
    }
  }

  _homeFontColor() {
    return widget.searchBarType == SearchBarType.homeLight
        ? Colors.black54
        : Colors.white;
  }
}
