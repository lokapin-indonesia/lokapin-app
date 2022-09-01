import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:lokapin_app/screen/profile/profile_Screen.dart';
import 'package:lokapin_app/utils/backends/pets-api.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:lokapin_app/widgets/device_card.dart';

import '../../utils/backends/profile-api.dart';
import '../../utils/sharedpref/sp-handler.dart';

class HomeScreen extends StatefulWidget {
  static String tag = '/HomeScreen';

  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  var textFieldController = TextEditingController();
  FocusNode textFocusNode = FocusNode();
  var sp = SharedPreferenceHandler();

  String userFullName = "-";
  String userImage =
      "https://assets.stickpng.com/images/585e4bf3cb11b227491c339a.png";

  var petCards = [];

  void changeShowName(result) {
    setState(() {
      var name = result["first_name"];
      if (result['last_name'] != null) {
        name = name + " " + result['last_name'];
      }
      userFullName = name;
    });
  }

  void loadImage(imgurl) {
    if (imgurl != null) {
      setState(() {
        userImage = "http://108.136.230.107/static/image/user/" + imgurl;
      });
    }
  }

  void loadPets() async {
    var response = await PetsApi.getMyPets();
    if(response.status == 200){
      var resplist = response.data["result"] as List<dynamic>;
      var arr = [];
      for(var i=0;i<resplist.length;i++){
        var singleResp = resplist[i];
        String gambar = "https://img.freepik.com/free-photo/group-portrait-adorable-puppies_53876-64778.jpg?w=2000";
        String name = singleResp["name"];
        String age = singleResp["age"].toString();
        String breed = singleResp["breed"];
        if(singleResp["photo"] != null){
          gambar = "http://108.136.230.107/static/image/pet/" + singleResp["photo"];
        }
        arr.add(
            DeviceCard(petName: name,breed: breed,petAge: age,imageUrl: gambar)
        );
      }

      setState(() {
        petCards = arr;
      });
    }
  }

  void loadUserInfo() async {
    var spInstance = await SharedPreferences.getInstance();
    sp.setSharedPreference(spInstance);
    var session = sp.getToken();
    ProfileApi.getProfile(session).then((value) => {
          if (value.status == 200)
            {
              changeShowName(value.data["result"]),
              loadImage(value.data["result"]["photo"])
            }
        });
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
          backgroundColor: Colors.white,
          // bottomNavigationBar: const NavBar(),
          body: Container(
            width: context.width(),
            height: context.height(),
            decoration: const BoxDecoration(
                image: DecorationImage(
                    image: AssetImage('assets/bg_home.png'),
                    fit: BoxFit.contain,
                    alignment: Alignment.topCenter)),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                    child: ListView(
                  children: [
                    25.height,
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        IconButton(
                            onPressed: () {
                              const ProfileScreen().launch(context);
                            },
                            icon: const Icon(Icons.person))
                      ],
                    ).paddingRight(16),
                    Container(
                      margin: EdgeInsets.all(16),
                      child: Stack(
                        alignment: Alignment.topCenter,
                        children: <Widget>[
                          Container(
                            width: context.width(),
                            padding: EdgeInsets.only(
                                left: 16, right: 16, bottom: 16),
                            margin: EdgeInsets.only(top: 34.0),
                            decoration: boxDecorationWithShadow(
                                borderRadius: BorderRadius.circular(30)),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Container(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      SizedBox(
                                        height: 50,
                                      ),
                                      Text("Hi, " + userFullName,
                                              style: boldTextStyle(
                                                  size: 30,
                                                  weight: FontWeight.w600))
                                          .center(),
                                      8.height,
                                      Text("Your connected device",
                                              style: boldTextStyle(
                                                  size: 20,
                                                  weight: FontWeight.normal))
                                          .center(),
                                      8.height,
                                    ],
                                  ),
                                )
                              ],
                            ),
                          ),
                          CircleAvatar(
                              radius: 35,
                              backgroundColor: Colors.white,
                              child: Padding(
                                  padding: const EdgeInsets.all(5),
                                  child: ClipOval(
                                    child: Image.network(userImage,
                                        width: 140,
                                        height: 140,
                                        fit: BoxFit.fitWidth),
                                  )))
                        ],
                      ),
                    ),
                    Text("Your Devices",
                            style: boldTextStyle(
                                size: 20, weight: FontWeight.w600))
                        .paddingAll(16),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [...petCards,
                        AppButton(
                            width: context.width() - 30,
                            height: 90,
                            shapeBorder: RoundedRectangleBorder(
                                side: const BorderSide(
                                    color: Colors.black, width: 2.5),
                                borderRadius: BorderRadius.circular(10)),
                            elevation: 0,
                            onTap: () {},
                            child: Text(
                              "+ Add New Pet",
                              style: boldTextStyle(
                                  size: 20, weight: FontWeight.bold),
                            ))
                      ],
                    ).paddingAll(16)
                  ],
                ))
              ],
            ),
          ),
        ));
  }
}
