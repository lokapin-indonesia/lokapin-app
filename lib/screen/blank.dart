import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class BlankScreen extends StatefulWidget{
  @override
  _BlankScreenState createState() => _BlankScreenState();

}

class _BlankScreenState extends State<BlankScreen>{
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return SafeArea(child: Scaffold(
      body: Container(

      ),
    ));
  }

}