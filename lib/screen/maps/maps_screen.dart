import 'dart:ffi';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:latlong2/latlong.dart';
import 'package:lokapin_app/models/PetModels.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../utils/backends/pets-api.dart';

class MapScreen extends StatefulWidget {
  static String tag = '/MapScreen';

  const MapScreen({Key? key}) : super(key: key);

  @override
  _MapScreenState createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> with TickerProviderStateMixin {
  String mapBoxAccessToken =
      "pk.eyJ1IjoiaGFmaWRhYmkiLCJhIjoiY2tuNXZ2N25uMDg1MjJyczlna3VndmFmNSJ9.VKoc34AfkqZ5uUUODIUBVA";
  String mapBoxStyleId = "cl7jeeyo2000114prif1sze3r";
  LatLng? myLoc = LatLng(-7.283760773479516, 112.79506478349177);
  var selectedLoc = LatLng(-7.283760773479516, 112.79506478349177);
  final pageController = PageController();
  late final MapController mapController;
  int selectedIndex = 0;

  var _isCardVisible = false;
  var petMarker = [];
  var petData = [];

  dynamic getPetData(id) {
    for (var i = 0; i < petData.length; i++) {
      if (petData[i]["id"] == id) {
        return petData[i];
      }
    }
    return null;
  }

  void loadPet() async {
    var response = await PetsApi.getMyPets();
    if (response.status == 200) {
      var resplist = response.data["result"] as List<dynamic>;
      var arr = [];
      var pdata = [];
      for (var i = 0; i < resplist.length; i++) {
        var singleResp = resplist[i];
        if (singleResp["lat"] != null &&
            singleResp["long"] != null &&
            singleResp["last_ping"] != null) {
          DateTime? lastPing = DateTime.tryParse(singleResp["last_ping"]);
          singleResp["connected"] = false;

          if (lastPing != null && lastPing.isToday) {
            singleResp["connected"] = true;
          }

          pdata.add(singleResp);
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
        petData = pdata;
      });
    }
  }

  dynamic markerBuilder(bool isPet, int? currIdx, bool isConnected) {
    GestureDetector _markerBuilder(_) {
      return GestureDetector(
          onTap: () {
            if (currIdx != null) {
              pageController.animateToPage(
                currIdx,
                duration: const Duration(milliseconds: 500),
                curve: Curves.easeInOut,
              );
              selectedIndex = currIdx;
              var petData = getPetData(currIdx);
              selectedLoc = LatLng(
                  double.parse(petData["lat"]), double.parse(petData["long"]));
              _isCardVisible = true;
              _animatedMapMove(selectedLoc, 16.5);
              setState(() {});
            }
          },
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
              mapController: mapController,
              options:
                  MapOptions(minZoom: 10, maxZoom: 25, zoom: 15, center: myLoc),
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
            Positioned(
                left: 0,
                right: 0,
                bottom: 2,
                height: MediaQuery.of(context).size.height *
                    (_isCardVisible ? 0.3 : 0),
                child: PageView.builder(
                    controller: pageController,
                    onPageChanged: (val) {
                      selectedIndex = val;
                      _animatedMapMove(selectedLoc, 16.5);
                      setState(() {});
                    },
                    itemBuilder: (_, index) {
                      final petData = getPetData(selectedIndex);
                      var photoToShow;
                      if (petData['photo'] != null) {
                        photoToShow =
                            "http://108.136.230.107/static/image/pet/" +
                                petData['photo'];
                      } else {
                        photoToShow = "assets/animal_profpic.png";
                      }
                      return Padding(
                          padding: const EdgeInsets.all(15.0),
                          child: Card(
                            elevation: 5,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                            color: Colors.white,
                            child: Row(
                              children: [
                                const SizedBox(width: 10),
                                Expanded(
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Expanded(
                                        flex: 2,
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Row(
                                              children: [
                                                CircleAvatar(
                                                    radius: 35,
                                                    backgroundColor:
                                                        Colors.white,
                                                    child: Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .all(8),
                                                        child: ClipOval(
                                                          child: Image.network(
                                                              photoToShow,
                                                              width: 70,
                                                              height: 70,
                                                              fit: BoxFit
                                                                  .fitWidth),
                                                        ))),
                                                Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    Text(
                                                      petData['name'] +
                                                          " is near from home",
                                                      style: boldTextStyle(
                                                          size: 17,
                                                          color: const Color
                                                                  .fromRGBO(
                                                              31, 30, 34, 0.7)),
                                                    ),
                                                    Row(
                                                      children: [
                                                        Text(
                                                          "Distance : 2.0 km / ",
                                                          style: TextStyle(
                                                              fontSize: 17,
                                                              color: const Color
                                                                      .fromRGBO(
                                                                  31,
                                                                  30,
                                                                  34,
                                                                  0.7)),
                                                        ),
                                                        Text("2 km",
                                                            style: boldTextStyle(
                                                                size: 15,
                                                                color: const Color
                                                                        .fromRGBO(
                                                                    31,
                                                                    30,
                                                                    34,
                                                                    0.7)))
                                                      ],
                                                    )
                                                  ],
                                                )
                                              ],
                                            ),
                                            10.height,
                                            Text(
                                                petData['name'] +
                                                    " is running at",
                                                style: boldTextStyle(
                                                    size: 18,
                                                    color: const Color.fromRGBO(
                                                        31, 30, 34, 0.7))),
                                            const Text(
                                              "Jl. Gubeng Kertajaya VI A No.46, Kertajaya, Kec. Gubeng, Kota SBY, Jawa Timur 60282",
                                              style: TextStyle(
                                                  color: const Color.fromRGBO(
                                                      31, 30, 34, 0.7),
                                                  fontSize: 12),
                                            ),
                                            30.height,
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                AppButton(
                                                    width: 140,
                                                    color: Color(0xFFFCE76C),
                                                    shapeBorder:
                                                        RoundedRectangleBorder(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        10)),
                                                    elevation: 0,
                                                    onTap: () {},
                                                    child: Text(
                                                        "Virtual Pet Zone")),
                                                AppButton(
                                                    width: 140,
                                                    color: Color(0xFF1F1E22),
                                                    shapeBorder:
                                                        RoundedRectangleBorder(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        10)),
                                                    elevation: 0,
                                                    onTap: () {},
                                                    child: Text(
                                                      "Find Your Pet",
                                                      style: TextStyle(
                                                          color: Colors.white),
                                                    ))
                                              ],
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                const SizedBox(width: 10),
                              ],
                            ),
                          ));
                    }))
          ],
        ),
      ),
    );
  }

  @override
  void initState() {
    this.loadPet();
    super.initState();
    mapController = MapController();
  }

  void _animatedMapMove(LatLng destLocation, double destZoom) {
    // Create some tweens. These serve to split up the transition from one location to another.
    // In our case, we want to split the transition be<tween> our current map center and the destination.
    final latTween = Tween<double>(
        begin: mapController.center.latitude, end: destLocation.latitude);
    final lngTween = Tween<double>(
        begin: mapController.center.longitude, end: destLocation.longitude);
    final zoomTween = Tween<double>(begin: mapController.zoom, end: destZoom);

    // Create a animation controller that has a duration and a TickerProvider.
    var controller = AnimationController(
        duration: const Duration(milliseconds: 1000), vsync: this);
    // The animation determines what path the animation will take. You can try different Curves values, although I found
    // fastOutSlowIn to be my favorite.
    Animation<double> animation =
        CurvedAnimation(parent: controller, curve: Curves.fastOutSlowIn);

    controller.addListener(() {
      mapController.move(
        LatLng(latTween.evaluate(animation), lngTween.evaluate(animation)),
        zoomTween.evaluate(animation),
      );
    });

    animation.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        controller.dispose();
      } else if (status == AnimationStatus.dismissed) {
        controller.dispose();
      }
    });

    controller.forward();
  }
}
