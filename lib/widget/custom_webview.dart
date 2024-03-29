import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_webview_plugin/flutter_webview_plugin.dart';

class CustomWebview extends StatefulWidget {
  final String url;
  final String statusBarColor;
  final String title;
  final bool hideAppBar;
  final bool backForbid;

  CustomWebview(
      {this.url,
      this.statusBarColor,
      this.title,
      this.hideAppBar,
      this.backForbid = false});

  @override
  _CustomWebviewState createState() => _CustomWebviewState();
}

class _CustomWebviewState extends State<CustomWebview> {
  final webviewReference = FlutterWebviewPlugin();
  StreamSubscription<WebViewStateChanged> _onStateChanged;
  StreamSubscription<String> _onUrlChanged;
  StreamSubscription<WebViewHttpError> _onHttpError;
  static const CATCH_URLS = [
    'm.ctrip.com/',
    'm.ctrip.com/html5/',
    'm.ctrip.com/html5'
  ];
  bool exiting = false;

  @override
  Widget build(BuildContext context) {
    String statusBarColorStr = widget.statusBarColor ?? 'ffffff';
    Color backButtonColor;
    if (statusBarColorStr == 'ffffff') {
      backButtonColor = Colors.black;
    } else {
      backButtonColor = Colors.white;
    }
    return Scaffold(
      body: Column(
        children: <Widget>[
          _appBar(
              Color(int.parse('0xff' + statusBarColorStr)), backButtonColor),
          Expanded(
              child: WebviewScaffold(
            url: widget.url,
            withZoom: true,
            withLocalStorage: true,
            hidden: true,
            initialChild: Container(
              color: Colors.white,
              child: Center(
                child: Text('Waiting...'),
              ),
            ),
          ))
        ],
      ),
    );
  }

  @override
  void initState() {
    webviewReference.close();
    _onUrlChanged = webviewReference.onUrlChanged.listen((String url) {
      print('url::$url');
    });
    _onStateChanged =
        webviewReference.onStateChanged.listen((WebViewStateChanged state) {
      switch (state.type) {
        case WebViewState.startLoad:
          if (_isToMain(state.url) && !exiting) {
            if (widget.backForbid) {
              webviewReference.launch(widget.url);
            } else {
              Navigator.pop(context);
              exiting = true;
            }
          }
          break;
        default:
          break;
      }
    });
    _onHttpError =
        webviewReference.onHttpError.listen((WebViewHttpError error) {
      print(error);
    });
    super.initState();
  }

  _isToMain(String url) {
    bool contain = false;
    for (final value in CATCH_URLS) {
      if (url?.endsWith(value) ?? false) {
        contain = true;
        break;
      }
    }
    return contain;
  }

  @override
  void dispose() {
    super.dispose();
    _onStateChanged.cancel();
    _onUrlChanged.cancel();
    _onHttpError.cancel();
    webviewReference.dispose();
  }

  _appBar(Color backgroundColor, Color backButtonColor) {
    if (widget.hideAppBar ?? false) {
      return Container(
        color: backgroundColor,
        height: 30,
      );
    }
    return Container(
      color: backgroundColor,
      child: FractionallySizedBox(
        widthFactor: 1,
        child: Padding(
          padding: EdgeInsets.fromLTRB(0, 40, 0, 10),
          child: Stack(
            children: <Widget>[
              GestureDetector(
                onTap: () {
                  Navigator.pop(context);
                },
                child: Container(
                  margin: EdgeInsets.only(left: 10),
                  child: Icon(
                    Icons.close,
                    color: backButtonColor,
                    size: 26,
                  ),
                ),
              ),
              Positioned(
                left: 0,
                right: 0,
                child: Center(
                  child: Text(
                    widget.title ?? '',
                    style: TextStyle(color: backButtonColor, fontSize: 20),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
