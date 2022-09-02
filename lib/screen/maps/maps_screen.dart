import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:latlong2/latlong.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../utils/backends/pets-api.dart';

class MapScreen extends StatefulWidget {
  static String tag = '/MapScreen';

  const MapScreen({Key? key}) : super(key: key);

  @override
  _MapScreenState createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  String mapBoxAccessToken =
      "pk.eyJ1IjoiaGFmaWRhYmkiLCJhIjoiY2tuNXZ2N25uMDg1MjJyczlna3VndmFmNSJ9.VKoc34AfkqZ5uUUODIUBVA";
  String mapBoxStyleId = "cl7jeeyo2000114prif1sze3r";
  LatLng? myLoc = LatLng(-7.283760773479516, 112.79506478349177);
  final pageController = PageController();
  int selectedIndex = 0;

  var petMarker = [];

  void loadPet() async {
    var response = await PetsApi.getMyPets();
    if (response.status == 200) {
      var resplist = response.data["result"] as List<dynamic>;
      var arr = [];
      for (var i = 0; i < resplist.length; i++) {
        var singleResp = resplist[i];
        if (singleResp["lat"] != null &&
            singleResp["long"] != null &&
            singleResp["last_ping"] != null) {
          DateTime? lastPing = DateTime.tryParse(singleResp["last_ping"]);
          singleResp["connected"] = false;
          print(lastPing);
          if (lastPing != null && lastPing.isToday) {
            singleResp["connected"] = true;
          }
          var latlong = LatLng(double.parse(singleResp["lat"]),
              double.parse(singleResp["long"]));
          arr.add(Marker(
              point: latlong,
              height: 40,
              width: 40,
              builder: markerBuilder(
                  true, singleResp["id"], singleResp["connected"])));
        }
      }

      setState(() {
        petMarker = arr;
      });
    }
  }

  dynamic markerBuilder(bool isPet, int? currIdx, bool isConnected) {
    GestureDetector _markerBuilder(_) {
      return GestureDetector(
          onTap: () {},
          child: AnimatedScale(
            duration: const Duration(milliseconds: 500),
            scale: isPet ? (selectedIndex == currIdx ? 1 : 0.7) : 1,
            child: AnimatedOpacity(
              duration: const Duration(milliseconds: 500),
              opacity: isConnected
                  ? (isPet ? (selectedIndex == currIdx ? 1 : 0.5) : 1)
                  : 0.65,
              child: SvgPicture.asset(
                isPet ? 'assets/map_marker.svg' : 'assets/map_marker_user.svg',
              ),
            ),
          ));
    }

    return _markerBuilder;
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.white,
      body: Container(
        width: context.width(),
        height: context.height(),
        child: Stack(
          children: [
            FlutterMap(
              options:
                  MapOptions(minZoom: 10, maxZoom: 25, zoom: 18, center: myLoc),
              layers: [
                TileLayerOptions(
                  urlTemplate:
                      "https://api.mapbox.com/styles/v1/hafidabi/{mapStyleId}/tiles/256/{z}/{x}/{y}@2x?access_token={accessToken}",
                  additionalOptions: {
                    'mapStyleId': mapBoxStyleId,
                    'accessToken': mapBoxAccessToken,
                  },
                ),
                MarkerLayerOptions(markers: [
                  ...petMarker,
                  Marker(
                      point: myLoc!,
                      height: 40,
                      width: 40,
                      builder: markerBuilder(false, null, true)),
                ])
              ],
            ),
          ],
        ),
      ),
    );
  }

  @override
  void initState() {
    this.loadPet();
    super.initState();
  }
}
