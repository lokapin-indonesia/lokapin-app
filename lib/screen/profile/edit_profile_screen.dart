import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:lokapin_app/utils/colors.dart';
import 'package:nb_utils/nb_utils.dart';

import '../../utils/backends/profile-api.dart';
import '../../utils/sharedpref/sp-handler.dart';
import '../../widgets/dialog.dart';

class EditProfileScreen extends StatefulWidget {
  const EditProfileScreen({Key? key}) : super(key: key);

  @override
  _EditProfileScreenState createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  final _formKey = GlobalKey<FormState>();
  var fullnameController = TextEditingController();
  FocusNode fullnameFocusNode = FocusNode();
  var phoneController = TextEditingController();
  FocusNode phoneFocusNode = FocusNode();
  var addressController = TextEditingController();
  FocusNode addressFocusNode = FocusNode();
  var ageController = TextEditingController();
  FocusNode ageFocusNode = FocusNode();

  var sp = SharedPreferenceHandler();

  String userFullName = "-";
  String userAge = "-";
  String userPhone = "-";
  String userAddress = "-";
  String userImage =
      "https://assets.stickpng.com/images/585e4bf3cb11b227491c339a.png";
  File? newImage = null;

  void changeShowName(result) {
    setState(() {
      var name = result["first_name"];
      if (result['last_name'] != null) {
        name = name + " " + result['last_name'];
      }
      fullnameController.text = name;
      if (result['age'] != null) {
        ageController.text = result['age'].toString();
      }
      if (result["phone_number"] != null) {
        phoneController.text = result["phone_number"];
      }
      if (result["address"] != null) {
        addressController.text = result["address"];
      }
      if (result["photo"] != null) {
        userImage =
            "http://108.136.230.107/static/image/user/" + result["photo"];
      }
    });
  }

  void loadUserInfo() async {
    var spInstance = await SharedPreferences.getInstance();
    sp.setSharedPreference(spInstance);
    var session = sp.getToken();
    ProfileApi.getProfile(session).then((value) => {
          if (value.status == 200) {changeShowName(value.data["result"])}
        });
  }

  @override
  void initState() {
    loadUserInfo();
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
            // Navigator.pop(context);
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
                  children: <Widget>[
                    Column(
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
                                            child: Image.network(userImage,
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
                        Text("Owner Profile",
                            style:
                                boldTextStyle(size: 22, color: primaryColor)),
                        16.height,
                        Text("Full Name",
                            style:
                                boldTextStyle(size: 14, color: Colors.black38)),
                        AppTextField(
                          decoration: const InputDecoration(
                            border: OutlineInputBorder(),
                            filled: true,
                            fillColor: Colors.black12,
                          ),
                          textFieldType: TextFieldType.NAME,
                          controller: fullnameController,
                          focus: fullnameFocusNode,
                          nextFocus: phoneFocusNode,
                        ),
                        16.height,
                        Text("Phone Number",
                            style:
                                boldTextStyle(size: 14, color: Colors.black38)),
                        AppTextField(
                          decoration: const InputDecoration(
                            border: OutlineInputBorder(),
                            filled: true,
                            fillColor: Colors.black12,
                          ),
                          textFieldType: TextFieldType.PHONE,
                          controller: phoneController,
                          focus: phoneFocusNode,
                          nextFocus: addressFocusNode,
                        ),
                        16.height,
                        Text("Address",
                            style:
                                boldTextStyle(size: 14, color: Colors.black38)),
                        AppTextField(
                          decoration: const InputDecoration(
                            border: OutlineInputBorder(),
                            filled: true,
                            fillColor: Colors.black12,
                          ),
                          textFieldType: TextFieldType.ADDRESS,
                          controller: addressController,
                          focus: addressFocusNode,
                          nextFocus: ageFocusNode,
                        ),
                        16.height,
                        Text("Age",
                            style:
                                boldTextStyle(size: 14, color: Colors.black38)),
                        AppTextField(
                          decoration: const InputDecoration(
                            border: OutlineInputBorder(),
                            filled: true,
                            fillColor: Colors.black12,
                          ),
                          textFieldType: TextFieldType.OTHER,
                          keyboardType: TextInputType.number,
                          controller: ageController,
                          focus: ageFocusNode,
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
                                ProfileApi.editUserRequest(
                                        username:
                                            fullnameController.text.toString(),
                                        phone: phoneController.text.toString(),
                                        age: ageController.text.toInt(),
                                        address:
                                            addressController.text.toString(),
                                        photo: newImage)
                                    .then((value) => {
                                          if (value.status == 200)
                                            {
                                              showSuccessfulAlertDialog(
                                                  context,
                                                  "Berhasil Save Data Baru",
                                                  "",
                                                  () => Navigator.pop(context))
                                            }
                                          else
                                            {
                                              showErrorAlertDialog(
                                                  context,
                                                  "Gagal save data baru",
                                                  value.message,
                                                  () => Navigator.pop(context))
                                            }
                                        });
                              }
                            }),
                      ],
                    ),
                  ],
                )),
          ),
        ),
      ),
    );
  }
}
