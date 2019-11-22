import 'dart:async';
import 'dart:convert';

import 'package:flutter_instrument/model/search_model.dart';
import 'package:http/http.dart' as http;

class SearchDao {
  static const SEARCH_REQUEST_URL =
      'https://m.ctrip.com/restapi/h5api/searchapp/search?source=mobileweb&action=autocomplete&contentType=json&keyword=';

  static Future<SearchModel> fetch(String keyword) async {
    final response = await http.get(SEARCH_REQUEST_URL + keyword);
    if (response.statusCode == 200) {
      Utf8Decoder utf8decoder = Utf8Decoder();
      var result = json.decode(utf8decoder.convert(response.bodyBytes));
      SearchModel searchModel = SearchModel.fromJson(result);
      searchModel.keyword = keyword;
      return searchModel;
    } else {
      throw Exception('RESPONSE ERROR');
    }
  }
}
