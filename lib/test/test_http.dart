import 'package:flutter/material.dart';
import 'package:flutter_instrument/model/test_model.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

///我的页
class TestHtpPage extends StatefulWidget {
  @override
  _TestHtpPageState createState() => _TestHtpPageState();
}

class _TestHtpPageState extends State<TestHtpPage> {
  String _result = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder(future:fetchPost(),builder: (BuildContext context, AsyncSnapshot<CommonModel> snapshot){
        switch(snapshot.connectionState){
          case ConnectionState.none:
            return Text('ConnectionState.none');
          case ConnectionState.active:
            return Text('ConnectionState.active');
          case ConnectionState.done:
            if(snapshot.hasError){
              return Text(snapshot.error);
            }
            return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    InkWell(
                      onTap: () {
                        fetchPost().then((CommonModel value) {
                          setState(() {
                            _result =
                            '请求结果：\nhideAppBar：${value.hideAppBar}\nicon：${value.icon}';
                          });
                        });
                      },
                      child: Text('点我发起一次请求'),
                    ),
                    Text(_result)
                  ],
                ));

          case ConnectionState.waiting:
            return Center(
              child: CircularProgressIndicator(),
            );
        }
      }),
    );
  }
  ///发起一次请求
  Future<CommonModel> fetchPost() async {
    final response = await http
        .get('http://www.devio.org/io/flutter_app/json/test_common_model.json');
    final result = json.decode(response.body);
    return CommonModel.fromJson(result);
  }
}
