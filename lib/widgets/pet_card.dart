import 'package:flutter/material.dart';
import 'package:lokapin_app/models/PetModels.dart';
import 'package:nb_utils/nb_utils.dart';

class PetCard extends StatelessWidget {
  final PetModels? petData;
  final Function? editPet;
  const PetCard({Key? key, this.petData, this.editPet}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.topCenter,
      children: <Widget>[
        Container(
          width: 180,
          height: 180,
          padding: EdgeInsets.only(left: 16, right: 16, bottom: 16),
          margin: EdgeInsets.only(top: 34.0),
          decoration: const BoxDecoration(
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
                    const SizedBox(
                      height: 50,
                    ),
                    Text(petData?.name ?? "-",
                        style:
                            boldTextStyle(size: 22, weight: FontWeight.w600)),
                    Text(petData?.breed ?? "-",
                        style:
                            boldTextStyle(size: 12, weight: FontWeight.normal)),
                    2.height,
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text("${petData?.age ?? 0} year old",
                            style: boldTextStyle(
                                size: 12, weight: FontWeight.normal)),
                        8.height,
                        Spacer(),
                        Text("${petData?.weight ?? "-"} kg",
                            style: boldTextStyle(
                                size: 12, weight: FontWeight.normal)),
                        8.height,
                      ],
                    ),
                    8.height,
                    Text("ID ${petData?.id ?? "-"}",
                        style:
                            boldTextStyle(size: 12, weight: FontWeight.normal)),
                  ],
                ),
              )
            ],
          ),
        ),
        Container(
          width: 70.0,
          height: 70.0,
          child: Stack(
            children: <Widget>[
              CircleAvatar(
                  radius: 35,
                  backgroundColor: Colors.white,
                  child: Padding(
                      padding: const EdgeInsets.all(8),
                      child: ClipOval(
                        child: Image.asset(
                            petData?.photo ?? 'assets/animal_profpic.png',
                            width: 70,
                            height: 70,
                            fit: BoxFit.fitWidth),
                      ))),
              Align(
                alignment: const Alignment(3.4, 3.4),
                child: FloatingActionButton(
                    elevation: 0,
                    backgroundColor: transparentColor,
                    child: Ink(
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(50.0)),
                      child: const Padding(
                        padding: EdgeInsets.all(5.0),
                        child: Icon(
                          Icons.edit,
                          size: 18.0,
                          color: Colors.black,
                        ),
                      ),
                    ),
                    onPressed: () {
                      editPet!(petData?.id);
                    }),
              )
            ],
          ),
        )
      ],
    );
  }
}
