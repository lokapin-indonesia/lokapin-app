import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:lokapin_app/utils/colors.dart';
import 'package:lokapin_app/utils/widgets.dart';
import 'package:nb_utils/nb_utils.dart';

class EditProfileScreen extends StatefulWidget {
  static String tag = '/editprofileScreen';
  
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
                                  backgroundColor:
                                      Colors.white,
                                  child: Padding(
                                      padding:
                                          const EdgeInsets
                                              .all(5),
                                      child: ClipOval(
                                        child: Image.asset(
                                            'assets/animal_profpic.png',
                                            width: 125,
                                            height: 125,
                                            fit: BoxFit
                                                .fitWidth),
                                      ))),
                            ),
                          Align(
                            alignment:
                                Alignment.bottomRight,
                            child: FloatingActionButton(
                                elevation: 0,
                                backgroundColor:
                                    transparentColor,
                                child: Ink(
                                  decoration: BoxDecoration(
                                      border: Border.all(
                                          color: Colors
                                              .black,
                                          width: 1),
                                      color: Colors.white,
                                      borderRadius:
                                          BorderRadius
                                              .circular(
                                                  50.0)),
                                  child: const Padding(
                                    padding:
                                        EdgeInsets.all(
                                            5.0),
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
                    Text("Owner Profile",
                      style: boldTextStyle(
                        size: 22, 
                        color: primaryColor
                      )
                    ),
                    16.height,
                    Text("Full Name",
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
                      controller: fullnameController,
                      focus: fullnameFocusNode,
                      nextFocus: phoneFocusNode,
                    ),
                    16.height,
                    Text("Phone Number",
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
                      textFieldType: TextFieldType.PHONE,
                      controller: phoneController,
                      focus: phoneFocusNode,
                      nextFocus: addressFocusNode,
                    ),
                    16.height,
                    Text("Address",
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
                      textFieldType: TextFieldType.ADDRESS,
                      controller: addressController,
                      focus: addressFocusNode,
                      nextFocus: ageFocusNode,
                    ),
                    16.height,
                    Text("Age",
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
                      controller: ageController,
                      focus: ageFocusNode,
                    ),
                  ],
                ),
                const Spacer(),
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
            )
          ),
        ),
      ),
    );
  }
}