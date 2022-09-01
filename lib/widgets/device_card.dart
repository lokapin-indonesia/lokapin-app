import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';

class DeviceCard extends StatefulWidget {
  static String tag = '/DeviceCard';

  DeviceCard({Key? key}) : super(key: key);

  @override
  _DeviceCardState createState() => _DeviceCardState();

}

class _DeviceCardState extends State<DeviceCard> {
  Color bgColor = Colors.white;
  Color borderColor = Colors.black;

  void _changeBgColor(PointerEvent details){
        setState(() {
          if(bgColor == Colors.white){
            bgColor = const Color.fromRGBO(252, 231, 108, 1);
          }else{
            bgColor = Colors.white;
          }

          if(borderColor == Colors.black){
            setState(() {
              borderColor = const Color.fromRGBO(252, 231, 108, 1);
            });
          }else{
            borderColor = Colors.black;
          }
        });
      }

  @override 
  Widget build(BuildContext context){
    return MouseRegion(
      onEnter: _changeBgColor,
      onExit: _changeBgColor,
      child: Card(
        color: bgColor,
          shape: RoundedRectangleBorder(
              side: BorderSide(
                color: borderColor,
                width: 2.5,
              ),
              borderRadius: const BorderRadius.all(
                Radius.circular(10),
              )),
          child:
              Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
            Container(
              margin: const EdgeInsets.only(right: 20),
              child: CircleAvatar(
                  radius: 35,
                  backgroundColor: Colors.black,
                  child: Padding(
                      padding: const EdgeInsets.all(2.5),
                      child: ClipOval(
                        child: Image.asset('assets/animal_profpic.png',
                            width: 130, height: 130, fit: BoxFit.fitWidth),
                      ))),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Text(
                      "Choky",
                      style: boldTextStyle(size: 20),
                    )
                  ],
                ),
                const Text("Buldog, 2 years old",
                    style: TextStyle(color: Colors.grey)),
                const Text("1.2 km around here",
                    style: TextStyle(color: Colors.grey))
              ],
            ),
            Material(
              type: MaterialType.transparency,
              child: Ink(
                decoration: BoxDecoration(
                    border: Border.all(color: Colors.black, width: 2),
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(50.0)),
                child: InkWell(
                  borderRadius: BorderRadius.circular(100.0),
                  onTap: () {},
                  child: const Padding(
                    padding: EdgeInsets.all(10.0),
                    child: Icon(
                      Icons.chevron_right,
                      size: 20.0,
                      color: Colors.black,
                    ),
                  ),
                ),
              ),
            ),
          ]).paddingOnly(left: 10, right: 10, top: 12, bottom: 12)),
    );
  }
}

// Widget deviceCard() {
//   return 
// }
