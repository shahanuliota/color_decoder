import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get_connect/http/src/request/request.dart';
import 'package:get/get_connect/http/src/response/response.dart';

class RequestInterceptor {
  static Future<Response<T>> responseLogger<T>(Request request, response) async {
    debugPrint('request:=> ${request.url}');
    debugPrint('request:=> ${response.statusCode}');
    print(response.headers);
    print(request.method);

    if (!request.url.toString().contains('api/user/logout')) {
      try {
        var j = json.decode(response.bodyString ?? '');
        String res = const JsonEncoder.withIndent('  ').convert(j);
        debugPrint('response $res');
      } catch (e) {
        debugPrint('error GetConnect:=> ${e.toString()}');
      }
    }

    if (response.statusCode == 401) {
      return response;
    }
    return response;
  }
}
