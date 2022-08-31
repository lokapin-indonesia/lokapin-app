import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';

Widget PetCart() {
  return   Container(
    margin: EdgeInsets.all(16),
    child: Stack(
      alignment: Alignment.topCenter,
      children: <Widget>[
      Container(
      width: 180,
      padding:
      EdgeInsets.only(left: 16, right: 16, bottom: 16),
      margin: EdgeInsets.only(top: 34.0),
      decoration:const BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(12)),
        color: Color(0xfffce76c),

      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: 35,
                ),
                Text("Chock",
                    style: boldTextStyle(
                        size: 22,
                        weight: FontWeight.w600))
                ,
                Text("Britanny",
                    style: boldTextStyle(
                        size: 12,
                        weight: FontWeight.normal))
                ,
                2.height,
                Row (
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text("1 year old",
                        style: boldTextStyle(
                            size: 12,
                            weight: FontWeight.normal))
                    ,
                    8.height,
                    Spacer(),
                    Text("3 kg",
                        style: boldTextStyle(
                            size: 12,
                            weight: FontWeight.normal))
                    ,
                    8.height,
                  ],
                ),
                8.height,
                Text("ID 1234567890",
                    style: boldTextStyle(
                        size: 12,
                        weight: FontWeight.normal))
                ,
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
  );
   Container(
    width: 180,
    padding:
    EdgeInsets.only(left: 16, right: 16, bottom: 16),
    margin: EdgeInsets.only(top: 34.0),
    decoration:const BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(12)),
        color: Color(0xfffce76c),

    ),
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
              Text("Chock",
                  style: boldTextStyle(
                      size: 22,
                      weight: FontWeight.w600))
                  ,
              8.height,
              Text("Britanny",
                  style: boldTextStyle(
                      size: 12,
                      weight: FontWeight.normal))
                  ,
              8.height,
              Row (
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text("1 year old",
                      style: boldTextStyle(
                          size: 12,
                          weight: FontWeight.normal))
                  ,
                  8.height,
                  Spacer(),
                  Text("3 kg",
                      style: boldTextStyle(
                          size: 12,
                          weight: FontWeight.normal))
                  ,
                  8.height,
                ],
              ),
              8.height,
              Text("ID 1234567890",
                  style: boldTextStyle(
                      size: 12,
                      weight: FontWeight.normal))
              ,
              8.height,
            ],
          ),
        )
      ],
    ),
  );
}
