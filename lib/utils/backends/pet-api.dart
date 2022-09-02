import 'dart:convert';
import 'dart:io';

import 'package:lokapin_app/utils/be-const.dart';

import '../custom-http-response.dart';
import 'package:http/http.dart' as http;

import '../sharedpref/sp-handler.dart';

class PetApi {
  static final Map<String, String> _headers = {
    HttpHeaders.contentTypeHeader: 'application/json',
    HttpHeaders.setCookieHeader: ""
  };

  static Future<CustomHttpResponse<Map<String, dynamic>>> addPetRequest(
      id, name, breed, gender) async {
    var token = await SharedPreferenceHandler.getHandler();
    var thisHeader = {HttpHeaders.cookieHeader: token.getToken()};

    var data = {
      "hardware_id": "lokapin-CgVu-6lu3-gElC-MDEf",
      "name": name,
      "breed": breed,
      "gender": gender
    };

    var response = await http.post(Uri.parse(Constant.URL_BE + "/pet"),
        body: data, headers: thisHeader);
    var blankResp = json.decode("{}") as Map<String, dynamic>;

    if (response.statusCode < 500) {
      var bodyresp = json.decode(response.body) as Map<String, dynamic>;
      if (response.statusCode == 201) {
        return CustomHttpResponse(
            response.statusCode, bodyresp["message"], bodyresp);
      }
      return CustomHttpResponse(
          response.statusCode, bodyresp["message"], blankResp);
    }
    return CustomHttpResponse(response.statusCode, response.body, blankResp);
  }
}
