import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:lokapin_app/utils/backends/pet-api.dart';
import 'package:lokapin_app/utils/colors.dart';
import 'package:nb_utils/nb_utils.dart';

import '../../widgets/dialog.dart';

class AddProfilePetScreen extends StatefulWidget {
  static String tag = '/addprofilepetScreen';

  const AddProfilePetScreen({Key? key}) : super(key: key);

  @override
  _AddProfilePetScreenState createState() => _AddProfilePetScreenState();
}

class _AddProfilePetScreenState extends State<AddProfilePetScreen> {
  final _formKey = GlobalKey<FormState>();
  var idController = TextEditingController();
  FocusNode idFocusNode = FocusNode();
  var nameController = TextEditingController();
  FocusNode nameFocusNode = FocusNode();
  var birthController = TextEditingController();
  FocusNode birthFocusNode = FocusNode();
  var breedsController = TextEditingController();
  FocusNode breedsFocusNode = FocusNode();
  var genderController = TextEditingController();
  FocusNode genderFocusNode = FocusNode();
  var weightController = TextEditingController();
  FocusNode weightFocusNode = FocusNode();
  var vacController = TextEditingController();
  FocusNode vacFocusNode = FocusNode();
  var checkupController = TextEditingController();
  FocusNode checkupFocusNode = FocusNode();

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
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          title: Text(
            'Add Profile Pet',
            style: boldTextStyle(color: Colors.black38, size: 20),
          ),
          leading: Container(
            margin: const EdgeInsets.all(8),
            child: const Icon(
              Icons.arrow_back_ios,
              color: Colors.black38,
            ),
          ).onTap(() {
            finish(context);
          }),
          centerTitle: true,
          elevation: 0.0,
          systemOverlayStyle: SystemUiOverlayStyle.light,
        ),
        body: Container(
          padding: const EdgeInsets.all(10),
          width: context.width(),
          height: context.height(),
          child: SingleChildScrollView(
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Center(
                    child: Container(
                      width: 125.0,
                      height: 125.0,
                      alignment: Alignment.center,
                      child: Stack(
                        children: <Widget>[
                          Container(
                            alignment: Alignment.center,
                            child: CircleAvatar(
                                radius: 60,
                                backgroundColor: Colors.white,
                                child: Padding(
                                    padding: const EdgeInsets.all(5),
                                    child: ClipOval(
                                      child: Image.asset(
                                          'assets/animal_profpic.png',
                                          width: 125,
                                          height: 125,
                                          fit: BoxFit.fitWidth),
                                    ))),
                          ),
                          Align(
                            alignment: Alignment.bottomRight,
                            child: FloatingActionButton(
                                elevation: 0,
                                backgroundColor: transparentColor,
                                child: Ink(
                                  decoration: BoxDecoration(
                                      border: Border.all(
                                          color: Colors.black, width: 1),
                                      color: Colors.white,
                                      borderRadius:
                                          BorderRadius.circular(50.0)),
                                  child: const Padding(
                                    padding: EdgeInsets.all(5.0),
                                    child: Icon(
                                      Icons.edit,
                                      size: 20.0,
                                      color: Colors.black,
                                    ),
                                  ),
                                ),
                                onPressed: () {}),
                          )
                        ],
                      ),
                    ),
                  ),
                  Text("Pet Profile",
                      style: boldTextStyle(size: 22, color: primaryColor)),
                  16.height,
                  Text("ID Number",
                      style: boldTextStyle(size: 14, color: Colors.black38)),
                  AppTextField(
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      filled: true,
                      fillColor: Colors.black12,
                    ),
                    textFieldType: TextFieldType.OTHER,
                    keyboardType: TextInputType.number,
                    controller: idController,
                    focus: idFocusNode,
                    nextFocus: nameFocusNode,
                  ),
                  16.height,
                  Text("Pet Name",
                      style: boldTextStyle(size: 14, color: Colors.black38)),
                  AppTextField(
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      filled: true,
                      fillColor: Colors.black12,
                    ),
                    textFieldType: TextFieldType.NAME,
                    controller: nameController,
                    focus: nameFocusNode,
                    nextFocus: birthFocusNode,
                  ),
                  16.height,
                  Text("Pet Birth",
                      style: boldTextStyle(size: 14, color: Colors.black38)),
                  AppTextField(
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      filled: true,
                      fillColor: Colors.black12,
                    ),
                    textFieldType: TextFieldType.OTHER,
                    controller: birthController,
                    focus: birthFocusNode,
                    nextFocus: breedsFocusNode,
                  ),
                  16.height,
                  Text("Pet Breeds",
                      style: boldTextStyle(size: 14, color: Colors.black38)),
                  AppTextField(
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      filled: true,
                      fillColor: Colors.black12,
                    ),
                    textFieldType: TextFieldType.OTHER,
                    controller: breedsController,
                    focus: breedsFocusNode,
                    nextFocus: genderFocusNode,
                  ),
                  16.height,
                  Text("Gender",
                      style: boldTextStyle(size: 14, color: Colors.black38)),
                  AppTextField(
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      filled: true,
                      fillColor: Colors.black12,
                    ),
                    textFieldType: TextFieldType.OTHER,
                    controller: genderController,
                    focus: genderFocusNode,
                    nextFocus: weightFocusNode,
                  ),
                  16.height,
                  Text("Weight",
                      style: boldTextStyle(size: 14, color: Colors.black38)),
                  AppTextField(
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      filled: true,
                      fillColor: Colors.black12,
                    ),
                    textFieldType: TextFieldType.OTHER,
                    keyboardType: TextInputType.number,
                    controller: weightController,
                    focus: weightFocusNode,
                    nextFocus: vacFocusNode,
                  ),
                  48.height,
                  Text("Vacctination Activity",
                      style: boldTextStyle(size: 14, color: Colors.black38)),
                  AppTextField(
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      filled: true,
                      fillColor: Colors.black12,
                    ),
                    textFieldType: TextFieldType.OTHER,
                    controller: vacController,
                    focus: vacFocusNode,
                    nextFocus: checkupFocusNode,
                  ),
                  16.height,
                  Text("Medical Check Up Activity",
                      style: boldTextStyle(size: 14, color: Colors.black38)),
                  AppTextField(
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      filled: true,
                      fillColor: Colors.black12,
                    ),
                    textFieldType: TextFieldType.OTHER,
                    controller: checkupController,
                    focus: checkupFocusNode,
                  ),
                  64.height,
                  AppButton(
                      text: "Save",
                      textColor: Colors.white,
                      color: primaryColor,
                      shapeBorder: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15)),
                      width: context.width(),
                      onTap: () async {
                        if (_formKey.currentState!.validate()) {
                          String id = idController.text.toString();
                          String name = nameController.text.toString();
                          String breed = breedsController.text.toString();
                          String gender = genderController.text.toString();
                          print(id);
                          var resp = await PetApi.addPetRequest(
                              id, name, breed, gender);
                          if (resp.status == 200) {
                            showErrorAlertDialog(context, "Success Add PEt",
                                resp.message, () => Navigator.pop(context));
                          } else {
                            showErrorAlertDialog(
                                context,
                                "Something wrong happened",
                                resp.message,
                                () => Navigator.pop(context));
                          }
                        }
                      }),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
