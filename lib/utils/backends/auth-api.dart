import 'dart:io';

import 'package:http/http.dart' as http;
import 'dart:convert';
import '../custom-http-response.dart';
import '../be-const.dart';
import '../sharedpref/sp-handler.dart';

class AuthenticationAPI{
  static final Map<String, String> _headers = {
    HttpHeaders.contentTypeHeader: 'application/json'
  };

  static Future<CustomHttpResponse<Map<String, dynamic>>> loginRequest(email, password) async{
    var data = {
      "email": email,
      "password" : password,
    };
    var sp = await SharedPreferenceHandler.getHandler();
    var response = await http.post(
        Uri.parse(Constant.URL_BE +"user/login"),
        body: json.encode(data),
        headers: _headers
    );
    var blankResp = json.decode("{}")as Map<String, dynamic>;
    if(response.statusCode<500){
      var bodyresp = json.decode(response.body) as Map<String, dynamic>;
      if(response.statusCode == 200){
        //add shared preference schema to save cookies
        var cookiesData = response.headers["set-cookie"];
        print(cookiesData);
        sp.setToken(cookiesData);
        return CustomHttpResponse(response.statusCode, bodyresp["message"], bodyresp);
      }

      return CustomHttpResponse(response.statusCode, bodyresp["message"], blankResp);
    }
    return CustomHttpResponse(response.statusCode, response.body, blankResp);
  }
}