
import 'dart:convert';

import 'package:flutter_instrument/model/home_model.dart';
import 'dart:async';
import 'package:http/http.dart' as http;

class HomeDao{
  static const HOME_REQUEST_URL='https://www.devio.org/io/flutter_app/json/home_page.json';
  static Future<HomeModel> fetch() async{
    final response=await http.get(HOME_REQUEST_URL);
    if(response.statusCode==200){
      Utf8Decoder utf8decoder=Utf8Decoder();
      var result=json.decode(utf8decoder.convert(response.bodyBytes));
      return HomeModel.fromJson(result);
    }else{
      throw Exception('RESPONSE ERROR');
    }
  }
}