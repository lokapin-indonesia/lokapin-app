import 'package:flutter/material.dart';
import 'package:lokapin_app/utils/colors.dart';
import 'package:lokapin_app/utils/widgets.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:lokapin_app/widgets/device_card.dart';

import '../../widgets/appbar.dart';

class HomeScreen extends StatefulWidget {
  static String tag = '/HomeScreen';

  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  var textFieldController = TextEditingController();
  FocusNode textFocusNode = FocusNode();

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
          bottomNavigationBar: const NavBar(),
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
                // 50.height,
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    IconButton(onPressed: () {}, icon: Icon(Icons.person))
                  ],
                ).paddingRight(16),
                Container(
                  margin: EdgeInsets.all(16),
                  child: Stack(
                    alignment: Alignment.topCenter,
                    children: <Widget>[
                      Container(
                        width: context.width(),
                        padding:
                            EdgeInsets.only(left: 16, right: 16, bottom: 16),
                        margin: EdgeInsets.only(top: 34.0),
                        decoration: boxDecorationWithShadow(
                            borderRadius: BorderRadius.circular(30)),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Container(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  SizedBox(
                                    height: 50,
                                  ),
                                  Text("Hi, Jessica",
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
                                child: Image.asset('assets/animal_profpic.png',
                                    width: 140,
                                    height: 140,
                                    fit: BoxFit.fitWidth),
                              )))
                    ],
                  ),
                ),
                Text("Your Devices",
                        style: boldTextStyle(size: 20, weight: FontWeight.w600))
                    .paddingAll(16),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    DeviceCard(),
                    DeviceCard(),
                    DeviceCard(),
                  ],
                ),
              ],
            ),
          ),
        ));
  }
}
