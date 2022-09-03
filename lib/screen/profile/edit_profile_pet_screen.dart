import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:lokapin_app/screen/profile/profile_Screen.dart';
import 'package:lokapin_app/utils/backends/pets-api.dart';
import 'package:image_picker/image_picker.dart';
import 'package:lokapin_app/utils/colors.dart';
import 'package:lokapin_app/widgets/dialog.dart';
import 'package:nb_utils/nb_utils.dart';

class EditProfilePetScreen extends StatefulWidget {
  final String id;

  const EditProfilePetScreen({required this.id, Key? key}) : super(key: key);

  @override
  _EditProfilePetScreenState createState() => _EditProfilePetScreenState();
}

class _EditProfilePetScreenState extends State<EditProfilePetScreen> {
  final _formKey = GlobalKey<FormState>();
  var idController = TextEditingController();
  FocusNode idFocusNode = FocusNode();
  var nameController = TextEditingController();
  FocusNode nameFocusNode = FocusNode();
  var breedsController = TextEditingController();
  FocusNode breedsFocusNode = FocusNode();
  var speciesController = TextEditingController();
  FocusNode speciesFocusNode = FocusNode();
  var ageController = TextEditingController();
  FocusNode ageFocusNode = FocusNode();
  var genderController = TextEditingController();
  FocusNode genderFocusNode = FocusNode();
  var weightController = TextEditingController();
  FocusNode weightFocusNode = FocusNode();

  String petImage =
      "https://assets.stickpng.com/images/585e4bf3cb11b227491c339a.png";
  File? newImage = null;

  Future<void> init() async {
    PetsApi.getPetProfile(widget.id).then((value) => {
          setState(() {
            var petData = value.data["result"];
            print(petData);
            if (petData["id"] != null) {
              idController.text = petData["id"].toString();
            }
            if (petData["name"] != null) {
              nameController.text = petData["name"];
            }
            if (petData["breed"] != null) {
              breedsController.text = petData["breed"];
            }
            if (petData["species"] != null) {
              speciesController.text = petData["species"];
            }
            if (petData["age"] != null) {
              ageController.text = petData["age"].toString();
            }
            if (petData["gender"] != null) {
              genderController.text = petData["gender"];
            }
            if (petData["weight"] != null) {
              weightController.text = petData["weight"].toString();
            }
            if (petData["photo"] != null) {
              petImage = "http://108.136.230.107/static/image/user/" +
                  petData["photo"];
            }
          }),
        });
  }

  @override
  void initState() {
    super.initState();
    init();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  void setState(fn) {
    if (mounted) super.setState(fn);
  }

  void imagePicker() async {
    try {
      final image = await ImagePicker().pickImage(source: ImageSource.gallery);
      if (image == null) {
        showErrorAlertDialog(context, "Fail select image", 'No image selected',
            () {
          Navigator.pop(context);
        });
        return;
      }
      setState(() {
        newImage = File(image.path);
      });
      // ProfileApi.replaceUserImage(image.path)
      //     .then((value) => {if (value.status == 200) {}});
    } on PlatformException catch (e) {
      showErrorAlertDialog(context, "Fail select image", '', () {
        Navigator.pop(context);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          title: Text(
            'Edit Pet Profile',
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
                                      child: Image.network(petImage,
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
                                onPressed: () {
                                  imagePicker();
                                }),
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
                    enabled: false,
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
                    nextFocus: speciesFocusNode,
                  ),
                  16.height,
                  Text("Pet Species",
                      style: boldTextStyle(size: 14, color: Colors.black38)),
                  AppTextField(
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      filled: true,
                      fillColor: Colors.black12,
                    ),
                    textFieldType: TextFieldType.OTHER,
                    controller: speciesController,
                    focus: speciesFocusNode,
                    nextFocus: ageFocusNode,
                  ),
                  16.height,
                  Text("Pet Age",
                      style: boldTextStyle(size: 14, color: Colors.black38)),
                  AppTextField(
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      filled: true,
                      fillColor: Colors.black12,
                    ),
                    textFieldType: TextFieldType.OTHER,
                    controller: ageController,
                    focus: ageFocusNode,
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
                          int id = int.parse(idController.text);
                          String name = nameController.text.toString();
                          String breed = breedsController.text.toString();
                          String species = speciesController.text.toString();
                          String gender = genderController.text.toString();
                          String age = ageController.text.toString();
                          String weight = weightController.text.toString();

                          print(id);
                          print(name);
                          print(breed);
                          print(species);
                          print(gender);
                          print(age);
                          print(weight);
                          PetsApi.editPetProfile(
                                  pet_id: idController.text.toString(),
                                  name: nameController.text.toString(),
                                  breed: breedsController.text.toString(),
                                  species: speciesController.text.toString(),
                                  age: ageController.text.toString(),
                                  gender: genderController.text.toString(),
                                  weight: weightController.text,
                                  photo: newImage)
                              .then((value) => {
                                    print("response" + value.data.toString()),
                                    if (value.status == 200)
                                      {
                                        showSuccessfulAlertDialog(
                                            context,
                                            "Berhasil edit Pet profile!",
                                            "",
                                            () => {
                                                  Navigator.pop(context),
                                                })
                                      }
                                    else
                                      {
                                        showErrorAlertDialog(
                                            context,
                                            "Gagal edit pet profile!",
                                            json.decode(
                                                    value.message)["message"] +
                                                ',' +
                                                json.decode(value.message)[
                                                        "details"]["body"][0]
                                                    ["message"],
                                            () => {
                                                  Navigator.pop(context),
                                                })
                                      }
                                  });
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
