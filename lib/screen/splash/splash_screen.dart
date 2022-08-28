import 'package:flutter/material.dart';
import 'package:lokapin_app/screen/landing/landing_screen.dart';
import 'package:nb_utils/nb_utils.dart';

import '../../utils/colors.dart';

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

  Future<void> init() async {
    setStatusBarColor(primaryColor, statusBarIconBrightness: Brightness.light);
    await Future.delayed(const Duration(seconds: 3));
    if (mounted) finish(context);
    const LandingScreen().launch(context, isNewTask: true);
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
