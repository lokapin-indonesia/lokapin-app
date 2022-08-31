import 'package:flutter/material.dart';
import 'package:lokapin_app/screen/login/login_screen.dart';
import 'package:lokapin_app/utils/colors.dart';
import 'package:nb_utils/nb_utils.dart';

class LandingScreen extends StatefulWidget {
  static String tag = '/landingScreen';

  const LandingScreen({Key? key}) : super(key: key);

  @override
  _LandingScreenState createState() => _LandingScreenState();
}

class _LandingScreenState extends State<LandingScreen> {
  @override
  void initState() {
    super.initState();
    init();
  }

  Future<void> init() async {}

  @override
  void dispose() {
    super.dispose();
  }

  @override
  void setState(fn) {
    if (mounted) super.setState(fn);
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Container(
          width: context.width(),
          height: context.height(),
          decoration: const BoxDecoration(
              image: DecorationImage(
                  image: AssetImage('assets/bg_landing.png'),
                  fit: BoxFit.cover)),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Text("Lokapin Is Here",
                  style: boldTextStyle(size: 32, color: Colors.white)),
              25.height,
              Text("Looking After Your Pets!",
                  style: boldTextStyle(size: 20, color: Colors.white)),
              50.height,
              AppButton(
                      text: "Let’s Get Started",
                      color: secondaryColor,
                      shapeBorder: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15)),
                      width: context.width(),
                      onTap: (() {
                        Navigator.pushReplacement(context, MaterialPageRoute(builder: (c)=>LoginScreen()));
                      }))
                  .paddingOnly(
                      left: context.width() * 0.05,
                      right: context.width() * 0.05,
                      bottom: context.width() * 0.1),
              30.height,
            ],
          ),
        ),
      ),
    );
  }
}
