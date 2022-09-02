import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';

void showPetTooFar(context) {
  showDialog(
    context: context,
    barrierDismissible: false,
    builder: (BuildContext context) {
      return AlertDialog(
        content: Container(
          width: 300.0,
          height: 370.0,
          alignment: AlignmentDirectional.center,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  FloatingActionButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: Image.asset('assets/close.png'),
                    backgroundColor: Colors.white,
                    elevation: 0,
                    hoverElevation: 0,
                    focusElevation: 0,
                  ),
                ],
              ),
              Container(
                child: Center(
                  child: Column(
                    children: [
                      Image.asset(
                        "assets/vector_dog.png",
                        height: 158,
                        width: 180,
                      ),
                      const Text("Choky is too far from home",
                          style: TextStyle(
                              color: Color.fromRGBO(31, 30, 34, 0.5),
                              fontSize: 20,
                              fontWeight: FontWeight.bold)),
                      const Text("your pet is outside the radius",
                          style: TextStyle(
                              color: Color.fromRGBO(31, 30, 34, 0.5),
                              fontSize: 15)),
                      50.height,
                      AppButton(
                          child: Text(
                            "Track Your Pet",
                            style: TextStyle(color: Colors.white),
                          ),
                          color: Color(0xFF8BD0FC),
                          shapeBorder: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15)),
                          width: context.width(),
                          onTap: (() {})).paddingOnly(right: 70, left: 70),
                      10.height
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
        contentPadding: EdgeInsets.zero,
        backgroundColor: Colors.white,
      );
    },
  );
}
