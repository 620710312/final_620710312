import "dart:convert";
import 'package:final_620710312/model/api_result.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class api {
  static const URL = 'https://cpsu-test-api.herokuapp.com';

  Future<dynamic> fetch(String endPoint, {
    Map<String, dynamic>? queryParams
  }) async {
    var url = Uri.parse('$URL/$endPoint');
    final response = await http.get(url, headers: {'id': '620710312'});
    if (response.statusCode == 200) {
      Map<String, dynamic> jsonBody = json.decode(response.body);

      var apiResult = ApiResult.fromJson(jsonBody);
      print(apiResult.data);
      if (apiResult.status == 'ok') {
        return apiResult.data;
      }
      else {
        throw apiResult.message!;
      }
    }
    else {
      throw "Server connection failed";
    }
  }
}