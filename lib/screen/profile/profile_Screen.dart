import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:lokapin_app/screen/profile/edit_profile_screen.dart';
import 'package:lokapin_app/utils/colors.dart';
import 'package:lokapin_app/widgets/pet_card.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:lokapin_app/widgets/device_card.dart';

import '../../utils/backends/profile-api.dart';
import '../../utils/sharedpref/sp-handler.dart';

class ProfileScreen extends StatefulWidget {
  static String tag = '/ProfileScreen';

  const ProfileScreen({Key? key}) : super(key: key);

  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  var textFieldController = TextEditingController();
  FocusNode textFocusNode = FocusNode();
  var sp  = SharedPreferenceHandler();
  String userFullName = "-";
  String userAge  = "-";
  String userPhone = "-";
  String userAddress = "-";

  void changeShowName(result){
    setState(() {
      var name = result["first_name"];
      if(result['last_name']!=null){
        name = name + " " + result['last_name'];
      }
      userFullName = name;
      if(result['age']!=null){
        userAge = result['age'].toString();
      }
      if(result["phone_number"] != null){
        userPhone = result["phone_number"];
      }
      if(result["address"]!=null){
        userAddress = result["address"];
      }
    });
  }

  void loadUserInfo() async{
    var spInstance = await SharedPreferences.getInstance();
    sp.setSharedPreference(spInstance);
    var session = sp.getToken();
    ProfileApi.getProfile(session).then((value) => {
      if(value.status == 200){
        changeShowName(value.data["result"])
      }
    });
  }

  @override
  void initState() {
    loadUserInfo();
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
              style: boldTextStyle(color: Colors.black, size: 20),
            ),
            leading: Container(
            margin: const EdgeInsets.all(8),
            child: const Icon(
              Icons.arrow_back_ios,
              color: Colors.black38,
            ),
            ).onTap(() {
              finish(context);
            }),
            centerTitle: true,
            elevation: 0.0,
            systemOverlayStyle: SystemUiOverlayStyle.light,
          ),
          backgroundColor: Colors.white,
          body: Container(
            width: context.width(),
            height: context.height(),
            child: Column(
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
                                crossAxisAlignment: CrossAxisAlignment.center,
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
                                                    weight: FontWeight.w700)),
                                            8.width
                                          ],
                                        ),
                                        Text(userAge+" years old",
                                            style: boldTextStyle(
                                                size: 17,
                                                weight: FontWeight.w300)),

                                        Text(userPhone,
                                            style: boldTextStyle(
                                                size: 16,
                                                weight: FontWeight.normal)),
                                        20.height,
                                        Text("Address",
                                            style: boldTextStyle(
                                                size: 20,
                                                weight: FontWeight.normal)),
                                        Text(
                                            userAddress,
                                            style: boldTextStyle(
                                                size: 12,
                                                weight: FontWeight.w300))
                                      ],
                                    ),
                                  ),
                                  Expanded(
                                    flex: 3,
                                    child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Container(
                                            width: 150.0,
                                            height: 150.0,
                                            child: Stack(
                                              children: <Widget>[
                                                Container(
                                                  alignment: Alignment.center,
                                                  child: CircleAvatar(
                                                      radius: 50,
                                                      backgroundColor:
                                                          Colors.white,
                                                      child: Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                  .all(5),
                                                          child: ClipOval(
                                                            child: Image.asset(
                                                                'assets/animal_profpic.png',
                                                                width: 200,
                                                                height: 200,
                                                                fit: BoxFit
                                                                    .fitWidth),
                                                          ))),
                                                ),
                                                Align(
                                                  alignment:
                                                      Alignment.bottomRight,
                                                  child: FloatingActionButton(
                                                      elevation: 0,
                                                      backgroundColor:
                                                          transparentColor,
                                                      child: Ink(
                                                        decoration: BoxDecoration(
                                                            border: Border.all(
                                                                color: Colors
                                                                    .black,
                                                                width: 1),
                                                            color: Colors.white,
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        50.0)),
                                                        child: const Padding(
                                                          padding:
                                                              EdgeInsets.all(
                                                                  5.0),
                                                          child: Icon(
                                                            Icons.edit,
                                                            size: 30.0,
                                                            color: Colors.black,
                                                          ),
                                                        ),
                                                      ),
                                                      onPressed: () {
                                                        const EditProfileScreen().launch(context);
                                                      }),
                                                )
                                              ],
                                            ),
                                          ),

                                          // Stack(children: [
                                          // CircleAvatar(
                                          //     radius: 50,
                                          //     backgroundColor: Colors.white,
                                          //     child: Padding(
                                          //         padding:
                                          //             const EdgeInsets.all(5),
                                          //         child: ClipOval(
                                          //           child: Image.asset(
                                          //               'assets/animal_profpic.png',
                                          //               width: 200,
                                          //               height: 200,
                                          //               fit: BoxFit.fitWidth),
                                          //         ))),
                                          // ]),
                                          // const Positioned(
                                          //   top: 10,
                                          //   left: 10,
                                          //   child: Icon(
                                          //     Icons.chevron_right,
                                          //     size: 50.0,
                                          //     color: Colors.black,
                                          //   ),
                                          // ),
                                          // Positioned(
                                          //     top: 50,
                                          //     right: 50,
                                          //     child: MyWidget(color: Colors.red)
                                          // )
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
                  shrinkWrap: true,
                  crossAxisCount: 2,
                  childAspectRatio: 0.83,
                  padding: const EdgeInsets.all(0),
                  crossAxisSpacing: 10,
                  mainAxisSpacing: 0,
                  children: [
                    PetCart(),
                    PetCart(),
                    PetCart(),

                  ],
                ),
              ],
            ),
          ),
        ));
  }
}
