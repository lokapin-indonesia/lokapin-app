import 'dart:convert';
import 'dart:io';

import '../be-const.dart';
import '../custom-http-response.dart';
import '../sharedpref/sp-handler.dart';
import 'package:http/http.dart' as http;

class PetsApi{
  static Future<CustomHttpResponse<Map<String, dynamic>>> getMyPets() async{
    var token = await SharedPreferenceHandler.getHandler();
    var thisHeader = {
      HttpHeaders.cookieHeader : token.getToken()
    };

    var response = await http.get(Uri.parse(Constant.URL_BE + "pet/info/all"),
        headers: thisHeader);
    var blankResp = json.decode("{}")as Map<String, dynamic>;

    if(response.statusCode<500){
      var bodyresp = json.decode(response.body) as Map<String, dynamic>;
      if(response.statusCode == 200){
        return CustomHttpResponse(response.statusCode, bodyresp["message"], bodyresp);
      }
      return CustomHttpResponse(response.statusCode, bodyresp["message"], blankResp);
    }
    return CustomHttpResponse(response.statusCode, response.body, blankResp);
  }
}