import 'dart:convert';

import 'package:latlong2/latlong.dart';
import 'package:lokapin_app/utils/custom-http-response.dart';
import 'package:http/http.dart' as http;

class DirectionApi{
  static String baseUrl = 'https://api.mapbox.com/directions/v5/mapbox';
  static String accessToken = "pk.eyJ1IjoiaGFmaWRhYmkiLCJhIjoiY2tuNXZ2N25uMDg1MjJyczlna3VndmFmNSJ9.VKoc34AfkqZ5uUUODIUBVA";
  static String navType = "cycling";
  static Future<CustomHttpResponse<dynamic>> getDirection(LatLng source, LatLng destination) async{
    String url =
        '$baseUrl/$navType/${source.longitude},${source.latitude};${destination.longitude},${destination.latitude}?alternatives=true&continue_straight=true&geometries=geojson&language=en&overview=full&steps=true&access_token=$accessToken';
    var response = await http.get(Uri.parse(url));
    var bodyresp = json.decode(response.body) as Map<String, dynamic>;
    return CustomHttpResponse(response.statusCode, response.statusCode==200?"oke":"not oke", bodyresp);
  }
}