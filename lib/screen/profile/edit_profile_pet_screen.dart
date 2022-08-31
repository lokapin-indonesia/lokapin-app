import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:lokapin_app/utils/colors.dart';
import 'package:nb_utils/nb_utils.dart';

class EditProfilePetScreen extends StatefulWidget {
  static String tag = '/editprofilepetScreen';
  
  const EditProfilePetScreen({Key? key}) : super(key: key);

  @override
  _EditProfilePetScreenState createState() => _EditProfilePetScreenState();
}

class _EditProfilePetScreenState extends State<EditProfilePetScreen> {
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
            'Edit Profile',
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
                  Text("Pet Profile",
                    style: boldTextStyle(
                      size: 22, 
                      color: primaryColor
                    )
                  ),
                  16.height,
                  Text("ID Number",
                    style: boldTextStyle(
                      size: 14,
                      color: Colors.black38
                    )
                  ),
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
                    style: boldTextStyle(
                      size: 14,
                      color: Colors.black38
                    )
                  ),
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
                    style: boldTextStyle(
                      size: 14,
                      color: Colors.black38
                    )
                  ),
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
                    style: boldTextStyle(
                      size: 14,
                      color: Colors.black38
                    )
                  ),
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
                    style: boldTextStyle(
                      size: 14,
                      color: Colors.black38
                    )
                  ),
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
                    style: boldTextStyle(
                      size: 14,
                      color: Colors.black38
                    )
                  ),
                  AppTextField(
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      filled: true,
                      fillColor: Colors.black12,
                    ),
                    textFieldType: TextFieldType.OTHER,
                    keyboardType: TextInputType.number,
                    controller: breedsController,
                    focus: breedsFocusNode,
                    nextFocus: genderFocusNode,
                  ),
                  48.height,
                  Text("Vacctination Activity",
                    style: boldTextStyle(
                      size: 14,
                      color: Colors.black38
                    )
                  ),
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
                  Text("Medical Check Up Activity",
                    style: boldTextStyle(
                      size: 14,
                      color: Colors.black38
                    )
                  ),
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
                  64.height,
                  AppButton(
                    text: "Save",
                    textColor: Colors.white,
                    color: primaryColor,
                    shapeBorder: RoundedRectangleBorder(
                        borderRadius:
                            BorderRadius.circular(15)),
                    width: context.width(),
                    onTap: () async {
                      if (_formKey.currentState!.validate()) {
                        
                      }
                    }
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}