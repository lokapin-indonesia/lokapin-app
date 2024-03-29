import 'dart:convert';
import 'dart:io';
import 'package:lokapin_app/utils/be-const.dart';
import 'package:http_parser/http_parser.dart';
import '../custom-http-response.dart';
import 'package:http/http.dart' as http;

import '../sharedpref/sp-handler.dart';

class ProfileApi {
  static final Map<String, String> _headers = {
    HttpHeaders.contentTypeHeader: 'application/json',
    HttpHeaders.setCookieHeader: ""
  };

  static Future<CustomHttpResponse<Map<String, dynamic>>> getProfile(
      session) async {
    var header = _headers;
    header[HttpHeaders.cookieHeader] = session;
    var token = await SharedPreferenceHandler.getHandler();
    print(token.getToken());
    var response = await http.get(Uri.parse(Constant.URL_BE + "user/profile"),
        headers: header);
    var blankResp = json.decode("{}") as Map<String, dynamic>;

    if (response.statusCode < 500) {
      var bodyresp = json.decode(response.body) as Map<String, dynamic>;

      if (response.statusCode == 200) {
        var sp = await SharedPreferenceHandler.getHandler();
        // var cookiesData = response.headers["set-cookie"];
        // sp.setToken(cookiesData);
      }

      return CustomHttpResponse(
          response.statusCode, bodyresp["message"], bodyresp);
    }
    return CustomHttpResponse(response.statusCode, response.body, blankResp);
  }

  static Future<CustomHttpResponse<Map<String, dynamic>>> replaceUserImage(
      image) async {
    var token = await SharedPreferenceHandler.getHandler();
    var thisHeader = {HttpHeaders.cookieHeader: token.getToken()};
    var request = await http.MultipartRequest(
        'PATCH', Uri.parse(Constant.URL_BE + "user/profile"));
    var blankResp = json.decode("{}") as Map<String, dynamic>;
    print(image);
    request.headers.addAll(thisHeader);
    request.files.add(http.MultipartFile("photo",
        File(image).readAsBytes().asStream(), File(image).lengthSync()));
    var sent = await request.send();
    var response = await http.Response.fromStream(sent);
    if (sent.statusCode < 500) {
      var bodyresp = json.decode(response.body) as Map<String, dynamic>;
      if (sent.statusCode == 200) {
        return CustomHttpResponse(
            response.statusCode, bodyresp["message"], bodyresp);
      }
      return CustomHttpResponse(
          response.statusCode, bodyresp["message"], blankResp);
    }
    return CustomHttpResponse(response.statusCode, response.body, blankResp);
  }

  static Future<CustomHttpResponse> editUserRequest(
      {username, phone, address, age, photo}) async {
    var token = await SharedPreferenceHandler.getHandler();
    var thisHeader = {HttpHeaders.cookieHeader: token.getToken()};

    Map<String, String> data = {};
    if (username != null) {
      data["username"] = username.toString();
    }
    if (phone != null) {
      data["phone_number"] = phone.toString();
    }

    if (address != null) {
      data["address"] = address.toString();
    }
    var request = http.MultipartRequest(
        'PATCH', Uri.parse(Constant.URL_BE + "user/profile"));
    request.headers.addAll(thisHeader);
    request.fields.addAll({...data});
    request.fields['age'] = age.toString();

    // if (photo != null) {
    //   var multiPart = new http.MultipartFile(
    //       'photo',
    //       File(photo.path).readAsBytes().asStream(),
    //       File(photo.path).lengthSync());
    //   request.files.add(multiPart);
    // }

    var blankResp = json.decode("{}") as Map<String, dynamic>;
    var sent = await request.send();
    var response = await http.Response.fromStream(sent);
    print(response.body);
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
