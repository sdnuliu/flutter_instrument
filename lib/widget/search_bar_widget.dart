import 'package:flutter/material.dart';

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
  ValueChanged<String> onChanged; //文字变化

  SearchBar(
      {Key key,
      this.hideLeft,
      this.enabled,
      this.hint,
      this.defaultText,
      this.searchBarType,
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

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
