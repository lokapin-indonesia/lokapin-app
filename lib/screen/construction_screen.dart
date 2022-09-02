import 'package:flutter/material.dart';

class ConstructionScreen extends StatefulWidget {
  static String tag = '/HomeScreen';

  const ConstructionScreen({Key? key}) : super(key: key);

  @override
  _ConstructionScreenState createState() => _ConstructionScreenState();
}

class _ConstructionScreenState extends State<ConstructionScreen> {
  
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
          body: Center(child: Image.asset("assets/bg_construction.png")),
        ));
  }
}
