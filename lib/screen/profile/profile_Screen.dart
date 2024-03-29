import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:lokapin_app/models/PetModels.dart';
import 'package:lokapin_app/screen/login/login_screen.dart';
import 'package:lokapin_app/screen/profile/add_profile_pet_screen.dart';
import 'package:lokapin_app/screen/profile/edit_profile_pet_screen.dart';
import 'package:lokapin_app/screen/profile/edit_profile_screen.dart';
import 'package:lokapin_app/utils/backends/auth-api.dart';
import 'package:lokapin_app/utils/colors.dart';
import 'package:lokapin_app/widgets/pet_card.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:lokapin_app/widgets/device_card.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import '../../utils/backends/pets-api.dart';
import '../../utils/backends/profile-api.dart';
import '../../utils/sharedpref/sp-handler.dart';
import '../../widgets/dialog.dart';

class ProfileScreen extends StatefulWidget {
  static String tag = '/ProfileScreen';

  const ProfileScreen({Key? key}) : super(key: key);

  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  var textFieldController = TextEditingController();
  FocusNode textFocusNode = FocusNode();
  var sp = SharedPreferenceHandler();
  String userFullName = "-";
  String userAge = "-";
  String userPhone = "-";
  String userAddress = "-";
  String userImage =
      "https://assets.stickpng.com/images/585e4bf3cb11b227491c339a.png";

  RefreshController _refreshController =
      RefreshController(initialRefresh: false);

  void _onRefresh() async {
    // monitor network fetch
    // await Future.delayed(Duration(milliseconds: 1000));
    loadUserInfo();
    loadPets();
    // if failed,use refreshFailed()
    _refreshController.refreshCompleted();
  }

  void _onLoading() async {
    // monitor network fetch
    // await Future.delayed(Duration(milliseconds: 1000));
    if (mounted) setState(() {});
    _refreshController.loadComplete();
  }

  var petList = [];
  void logout() {
    AuthenticationAPI.logoutApi().then((value) => {
          sp.revokeToken(),
          Navigator.pushReplacement(
              context, MaterialPageRoute(builder: (context) => LoginScreen()))
        });
  }

  void changeShowName(result) {
    setState(() {
      var name = result["first_name"];
      if (result['last_name'] != null) {
        name = name + " " + result['last_name'];
      }
      userFullName = name;
      if (result['age'] != null) {
        userAge = result['age'].toString();
      }
      if (result["phone_number"] != null) {
        userPhone = result["phone_number"];
      }
      if (result["address"] != null) {
        userAddress = result["address"];
      }

      if (result["photo"] != null) {
        userImage =
            "http://108.136.230.107/static/image/user/" + result["photo"];
      }
    });
  }

  void loadUserInfo() async {
    var spInstance = await SharedPreferences.getInstance();
    sp.setSharedPreference(spInstance);
    var session = sp.getToken();
    ProfileApi.getProfile(session).then((value) => {
          if (value.status == 200) {changeShowName(value.data["result"])}
        });
  }

  void loadPets() async {
    var response = await PetsApi.getMyPets();
    if (response.status == 200) {
      var resplist = response.data["result"] as List<dynamic>;
      var arr = [];
      for (var i = 0; i < resplist.length; i++) {
        var singleResp = resplist[i];
        String gambar =
            "https://img.freepik.com/free-photo/group-portrait-adorable-puppies_53876-64778.jpg?w=2000";
        if (singleResp["photo"] != null) {
          gambar =
              "http://108.136.230.107/static/image/pet/" + singleResp["photo"];
        }
        arr.add(PetCard(
            petData: PetModels(
              id: singleResp["id"].toString(),
              hardwareId: singleResp["hardware_id"],
              name: singleResp["name"],
              photo: gambar,
              species: singleResp["species"],
              breed: singleResp["breed"],
              gender: singleResp["gender"],
              weight: 3,
              age: singleResp["age"],
              lat: singleResp["lat"].toString(),
              long: singleResp["long"].toString(),
              lastUpdated: DateTime.tryParse(singleResp["last_updated"]),
              lastPing: DateTime.now(),
            ),
            editPet: (String id) => {
                  EditProfilePetScreen(
                    id: id,
                  ).launch(context),
                }));
      }

      setState(() {
        petList = arr;
      });
    }
  }

  @override
  void initState() {
    loadUserInfo();
    loadPets();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: () {
          FocusScopeNode currentFocus = FocusScope.of(context);

          if (!currentFocus.hasPrimaryFocus) {
            currentFocus.unfocus();
          }
        },
        child: Scaffold(
          resizeToAvoidBottomInset: false,
          appBar: AppBar(
            backgroundColor: Colors.transparent,
            title: Text(
              'Profile',
              style: boldTextStyle(color: Colors.black38, size: 20),
            ),
            leading: Container(
              margin: const EdgeInsets.all(8),
              child: const Icon(
                Icons.arrow_back_ios,
                color: Colors.black38,
              ),
            ).onTap(() {
              // Navigator.pop(context);
              pop(context);
            }),
            centerTitle: true,
            elevation: 0.0,
            systemOverlayStyle: SystemUiOverlayStyle.light,
          ),
          backgroundColor: Colors.white,
          body: SmartRefresher(
              enablePullDown: true,
              enablePullUp: true,
              header: WaterDropHeader(),
              controller: _refreshController,
              onRefresh: _onRefresh,
              onLoading: _onLoading,
              child: ListView(
                children: <Widget>[
                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        margin: EdgeInsets.all(16),
                        child: Stack(
                          alignment: Alignment.topCenter,
                          children: <Widget>[
                            Container(
                              width: context.width(),
                              padding: EdgeInsets.all(16),
                              decoration: boxDecorationWithShadow(
                                  backgroundColor: primaryColor,
                                  borderRadius: BorderRadius.circular(10)),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Container(
                                    child: Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        Expanded(
                                          flex: 7,
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Row(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.end,
                                                children: [
                                                  Text(userFullName,
                                                      style: boldTextStyle(
                                                          size: 30,
                                                          weight:
                                                              FontWeight.w700)),
                                                  8.width
                                                ],
                                              ),
                                              Text(userAge + " years old",
                                                  style: boldTextStyle(
                                                      size: 17,
                                                      weight: FontWeight.w300)),
                                              Text(userPhone,
                                                  style: boldTextStyle(
                                                      size: 16,
                                                      weight:
                                                          FontWeight.normal)),
                                              20.height,
                                              Text("Address",
                                                  style: boldTextStyle(
                                                      size: 20,
                                                      weight:
                                                          FontWeight.normal)),
                                              Text(userAddress,
                                                  style: boldTextStyle(
                                                      size: 14,
                                                      weight: FontWeight.w300))
                                            ],
                                          ),
                                        ),
                                        Expanded(
                                          flex: 3,
                                          child: Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Container(
                                                  width: 150.0,
                                                  height: 150.0,
                                                  child: Stack(
                                                    children: <Widget>[
                                                      Container(
                                                        alignment:
                                                            Alignment.center,
                                                        child: CircleAvatar(
                                                            radius: 50,
                                                            backgroundColor:
                                                                Colors.white,
                                                            child: Padding(
                                                                padding:
                                                                    const EdgeInsets
                                                                        .all(5),
                                                                child: ClipOval(
                                                                  child: Image.network(
                                                                      userImage,
                                                                      width:
                                                                          200,
                                                                      height:
                                                                          200,
                                                                      fit: BoxFit
                                                                          .fitWidth),
                                                                ))),
                                                      ),
                                                      Align(
                                                        alignment: Alignment
                                                            .bottomRight,
                                                        child:
                                                            FloatingActionButton(
                                                                elevation: 0,
                                                                backgroundColor:
                                                                    transparentColor,
                                                                child: Ink(
                                                                  decoration: BoxDecoration(
                                                                      border: Border.all(
                                                                          color: Colors
                                                                              .black,
                                                                          width:
                                                                              1),
                                                                      color: Colors
                                                                          .white,
                                                                      borderRadius:
                                                                          BorderRadius.circular(
                                                                              50.0)),
                                                                  child:
                                                                      const Padding(
                                                                    padding:
                                                                        EdgeInsets.all(
                                                                            5.0),
                                                                    child: Icon(
                                                                      Icons
                                                                          .edit,
                                                                      size:
                                                                          20.0,
                                                                      color: Colors
                                                                          .black,
                                                                    ),
                                                                  ),
                                                                ),
                                                                onPressed: () {
                                                                  const EditProfileScreen()
                                                                      .launch(
                                                                          context);
                                                                }),
                                                      )
                                                    ],
                                                  ),
                                                ),
                                              ]),
                                        ),
                                      ],
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      GridView.count(
                        physics: const ScrollPhysics(),
                        shrinkWrap: true,
                        crossAxisCount: 2,
                        mainAxisSpacing: 20,
                        children: [...petList],
                      ),
                      64.height,
                      AppButton(
                          text: "Add New",
                          textColor: Colors.white,
                          color: primaryColor,
                          shapeBorder: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15)),
                          width: context.width(),
                          onTap: () async {
                            const AddProfilePetScreen().launch(context);
                          }).paddingSymmetric(vertical: 10, horizontal: 20),
                      AppButton(
                          text: "Log out",
                          textColor: Colors.red,
                          color: white,
                          shapeBorder: RoundedRectangleBorder(
                              side: BorderSide(color: Colors.red),
                              borderRadius: BorderRadius.circular(15)),
                          width: context.width(),
                          onTap: () async {
                            logout();
                          }).paddingSymmetric(vertical: 10, horizontal: 20)
                    ],
                  )
                ],
              )),
        ));
  }
}
