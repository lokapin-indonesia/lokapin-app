import 'dart:convert';
import 'dart:io';

import 'package:lokapin_app/utils/be-const.dart';

import '../custom-http-response.dart';
import 'package:http/http.dart' as http;

import '../sharedpref/sp-handler.dart';

class ProfileApi{
  static final Map<String, String> _headers = {
    HttpHeaders.contentTypeHeader: 'application/json',
    HttpHeaders.setCookieHeader: ""
  };

  static Future<CustomHttpResponse<Map<String, dynamic>>> getProfile(session) async{
    var header = _headers;
    header[HttpHeaders.cookieHeader] = session;
    var response = await http.get(
        Uri.parse(Constant.URL_BE + "user/profile"),
        headers: header
    );
    var blankResp = json.decode("{}")as Map<String, dynamic>;

    if(response.statusCode<500){
      var bodyresp = json.decode(response.body) as Map<String, dynamic>;

      if(response.statusCode==200){
        var sp = await SharedPreferenceHandler.getHandler();
        var cookiesData = response.headers["set-cookie"];
        sp.setToken(cookiesData);
      }

      return CustomHttpResponse(response.statusCode, bodyresp["message"], bodyresp);
    }
    return CustomHttpResponse(response.statusCode, response.body, blankResp);
  }
}