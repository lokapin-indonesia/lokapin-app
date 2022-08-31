import 'dart:async';

import 'package:flutter/material.dart';
import 'package:lokapin_app/screen/home/home_screen.dart';
import 'package:lokapin_app/screen/landing/landing_screen.dart';
import 'package:lokapin_app/utils/backends/profile-api.dart';
import 'package:lokapin_app/widgets/appbar.dart';
import 'package:nb_utils/nb_utils.dart';

import '../../utils/colors.dart';
import '../../utils/sharedpref/sp-handler.dart';

class SplashScreen extends StatefulWidget {
  static String tag = '/WASplashScreen';

  const SplashScreen({Key? key}) : super(key: key);

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    init();
  }

  init() async {
    setStatusBarColor(primaryColor, statusBarIconBrightness: Brightness.light);
    var durasi = const Duration(seconds: 3);
    print("object");
    return Timer(durasi, () async {
      var spInstance = await SharedPreferences.getInstance();
      var sp  = SharedPreferenceHandler();
      sp.setSharedPreference(spInstance);
      var sess = sp.getToken();
      print(sess);
      if(sess.length>1){
        var res = await ProfileApi.getProfile(sess);
        if(res.status==200){
          const NavBar().launch(context, isNewTask: true);
        }else{
          const LandingScreen().launch(context, isNewTask: true);
        }
      }else{
        const LandingScreen().launch(context, isNewTask: true);
      }
      //const LandingScreen().launch(context, isNewTask: true);
    });
  }

  @override
  void dispose() {
    setStatusBarColor(Colors.white, statusBarIconBrightness: Brightness.dark);
    super.dispose();
  }

  @override
  void setState(fn) {
    if (mounted) super.setState(fn);
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        decoration: const BoxDecoration(
            image: DecorationImage(
                image: AssetImage('assets/bg1.jpg'), fit: BoxFit.cover)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
                width: 200.00,
                height: 200.00,
                decoration: const BoxDecoration(
                  image: DecorationImage(
                    image: ExactAssetImage('assets/lokapin_logo.png'),
                    fit: BoxFit.contain,
                  ),
                )).center(),
          ],
        ),
      ),
    );
  }
}
