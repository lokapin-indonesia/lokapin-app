import 'dart:convert';
import 'dart:io';

import '../be-const.dart';
import '../custom-http-response.dart';
import '../sharedpref/sp-handler.dart';
import 'package:http/http.dart' as http;

class PetsApi {
  static final Map<String, String> _headers = {
    HttpHeaders.contentTypeHeader: 'application/json',
    HttpHeaders.setCookieHeader: ""
  };

  static Future<CustomHttpResponse<Map<String, dynamic>>> getAllPet(
      session) async {
    var header = _headers;
    header[HttpHeaders.cookieHeader] = session;
    var response = await http.get(Uri.parse(Constant.URL_BE + "pet/info/all"),
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

  static Future<CustomHttpResponse<Map<String, dynamic>>> getMyPets() async {
    var token = await SharedPreferenceHandler.getHandler();
    var thisHeader = {HttpHeaders.cookieHeader: token.getToken()};

    var response = await http.get(Uri.parse(Constant.URL_BE + "pet/info/all"),
        headers: thisHeader);
    var blankResp = json.decode("{}") as Map<String, dynamic>;

    if (response.statusCode < 500) {
      var bodyresp = json.decode(response.body) as Map<String, dynamic>;
      if (response.statusCode == 200) {
        return CustomHttpResponse(
            response.statusCode, bodyresp["message"], bodyresp);
      }
      return CustomHttpResponse(
          response.statusCode, bodyresp["message"], blankResp);
    }
    return CustomHttpResponse(response.statusCode, response.body, blankResp);
  }

  static Future<CustomHttpResponse<Map<String, dynamic>>> getPetProfile(
      id) async {
    var token = await SharedPreferenceHandler.getHandler();
    var thisHeader = {HttpHeaders.cookieHeader: token.getToken()};

    var response = await http.get(Uri.parse(Constant.URL_BE + "pet/info/" + id),
        headers: thisHeader);
    var blankResp = json.decode("{}") as Map<String, dynamic>;

    if (response.statusCode < 500) {
      var bodyresp = json.decode(response.body) as Map<String, dynamic>;
      if (response.statusCode == 200) {
        return CustomHttpResponse(
            response.statusCode, bodyresp["message"], bodyresp);
      }
      return CustomHttpResponse(
          response.statusCode, bodyresp["message"], blankResp);
    }
    return CustomHttpResponse(response.statusCode, response.body, blankResp);
  }

  static Future<CustomHttpResponse<Map<dynamic, dynamic>>> addPetProfile(
      {id, name, breed, species, gender, age, weight, photo}) async {
    var token = await SharedPreferenceHandler.getHandler();
    var thisHeader = {HttpHeaders.cookieHeader: token.getToken()};

    Map<String, String> data = {
      "hardware_id": id,
    };

    if (name != null) {
      data["name"] = name.toString();
    }

    if (breed != null) {
      data["breed"] = breed.toString();
    }

    if (species != null) {
      data["species"] = species;
    }

    if (age != null) {
      data["age"] = age.toString();
    }
    if (gender != null) {
      data["gender"] = gender.toString();
    }
    if (weight != null) {
      data["weight"] = weight.toString();
    }

    var request =
        await http.MultipartRequest('POST', Uri.parse(Constant.URL_BE + "pet"));
    request.headers.addAll(thisHeader);
    print(data);
    request.fields.addAll(data);

    var blankResp = json.decode("{}") as Map<String, dynamic>;
    if (photo != null) {
      var multiPart = await http.MultipartFile.fromPath("photo",photo.path);
      request.files.add(multiPart);
    }
    var sent = await request.send();
    var response = await http.Response.fromStream(sent);
    print(response.statusCode);
    if (response.statusCode < 500) {
      var bodyresp = json.decode(response.body) as Map<String, dynamic>;

      if (response.statusCode == 201 || response.statusCode == 200) {
        return CustomHttpResponse(
            response.statusCode, bodyresp["message"], bodyresp);
      }
      return CustomHttpResponse(
          response.statusCode, bodyresp["message"], blankResp);
    }
    return CustomHttpResponse(response.statusCode, response.body, blankResp);
  }

  static Future<CustomHttpResponse<Map<String, dynamic>>> editPetProfile({
    pet_id,
    name,
    breed,
    species,
    age,
    gender,
    weight,
    photo,
  }) async {
    var token = await SharedPreferenceHandler.getHandler();
    var thisHeader = {HttpHeaders.cookieHeader: token.getToken()};

    Map<String, String> data = {
      "pet_id": pet_id,
    };

    if (name != null) {
      data["name"] = name.toString();
    }

    if (breed != null) {
      data["breed"] = breed.toString();
    }

    if (species != null) {
      data["species"] = species;
    }

    if (age != null) {
      data["age"] = age.toString();
    }
    if (gender != null) {
      data["gender"] = gender.toString();
    }
    if (weight != null) {
      data["weight"] = weight.toString();
    }

    var request = await http.MultipartRequest(
        'PATCH', Uri.parse(Constant.URL_BE + "pet/" + pet_id));
    request.headers.addAll(thisHeader);
    request.fields.addAll(data);

    var blankResp = json.decode("{}") as Map<String, dynamic>;
    if (photo != null) {
      var multiPart = await http.MultipartFile.fromPath("photo",photo.path);
      request.files.add(multiPart);
    }
    var sent = await request.send();
    var response = await http.Response.fromStream(sent);
    print(response.body.toString());
    if (response.statusCode < 500) {
      var bodyresp = json.decode(response.body) as Map<String, dynamic>;

      if (response.statusCode == 201 || response.statusCode == 200) {
        return CustomHttpResponse(
            response.statusCode, bodyresp["message"], bodyresp);
      }
      return CustomHttpResponse(
          response.statusCode, bodyresp["message"], blankResp);
    }
    return CustomHttpResponse(response.statusCode, response.body, blankResp);
  }
}
