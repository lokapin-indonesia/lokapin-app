import 'dart:convert';
// import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:lokapin_app/constant.dart';
import 'package:lokapin_app/screen/home/home_Screen.dart';
import 'package:lokapin_app/screen/register/register_screen.dart';
import 'package:lokapin_app/utils/colors.dart';
import 'package:lokapin_app/utils/widgets.dart';
import 'package:lokapin_app/widgets/dialog.dart';
// import 'package:mosaic/utils/jwt_helper.dart';
import 'package:nb_utils/nb_utils.dart';

class LoginScreen extends StatefulWidget {
  static String tag = '/loginScreen';

  const LoginScreen({Key? key}) : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();

  var emailController = TextEditingController();
  var passwordController = TextEditingController();
  FocusNode emailFocusNode = FocusNode();
  FocusNode passWordFocusNode = FocusNode();

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
        body: Container(
          width: context.width(),
          height: context.height(),
          child: SingleChildScrollView(
            child: Form(
              key: _formKey,
              child: Column(
                children: <Widget>[
                  Container(
                    margin: const EdgeInsets.all(16),
                    child: Stack(
                      alignment: Alignment.topCenter,
                      children: <Widget>[
                        Container(
                          width: context.width(),
                          padding: const EdgeInsets.only(
                              left: 16, right: 16, bottom: 16),
                          margin: const EdgeInsets.only(top: 55.0),
                          decoration: boxDecorationWithShadow(
                              borderRadius: BorderRadius.circular(30)),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Container(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Container(
                                        width: 400.00,
                                        height: 200.00,
                                        decoration: const BoxDecoration(
                                          image: DecorationImage(
                                            image: ExactAssetImage(
                                                'assets/bg_login.png'),
                                            fit: BoxFit.contain,
                                          ),
                                        )).center(),
                                    Text("Log In",
                                        style: boldTextStyle(
                                            size: 32, color: primaryColor)),
                                    Text("Enter your email to proceed",
                                        style: boldTextStyle(
                                            size: 16, weight: FontWeight.w300)),
                                    16.height,
                                    Text("Email",
                                        style: boldTextStyle(size: 14)),
                                    8.height,
                                    AppTextField(
                                      decoration: inputDecoration(
                                          hint: 'Enter your email here',
                                          prefixIcon: Icons.email_outlined),
                                      textFieldType: TextFieldType.EMAIL,
                                      keyboardType: TextInputType.emailAddress,
                                      controller: emailController,
                                      focus: emailFocusNode,
                                      nextFocus: passWordFocusNode,
                                    ),
                                    16.height,
                                    Text("Password",
                                        style: boldTextStyle(size: 14)),
                                    8.height,
                                    AppTextField(
                                      decoration: inputDecoration(
                                          hint: 'Enter your password here',
                                          prefixIcon: Icons.lock_outline),
                                      suffixIconColor: primaryColor,
                                      textFieldType: TextFieldType.PASSWORD,
                                      isPassword: true,
                                      keyboardType:
                                          TextInputType.visiblePassword,
                                      controller: passwordController,
                                      focus: passWordFocusNode,
                                    ),
                                    16.height,
                                    AppButton(
                                        text: "LOG IN",
                                        color: secondaryColor,
                                        shapeBorder: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(15)),
                                        width: context.width(),
                                        onTap: () async {
                                          if (_formKey.currentState!
                                              .validate()) {
                                            String email =
                                                emailController.text.toString();
                                            String password = passwordController
                                                .text
                                                .toString();

                                            print(email);
                                            print(password);
                                            const HomeScreen().launch(context);
                                          }
                                          // WAEditProfileScreen(isEditProfile: false).launch(context);
                                        }),
                                    16.height,
                                    Row(
                                      mainAxisSize: MainAxisSize.min,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Text('Don\'t have an account yet?',
                                            style: primaryTextStyle(
                                                color: Colors.grey)),
                                        4.width,
                                        Text('Create One',
                                                style: boldTextStyle(
                                                    color: Colors.grey))
                                            .onTap(() {
                                          const RegisterScreen()
                                              .launch(context);
                                        }),
                                      ],
                                    ).center(),
                                  ],
                                ),
                              )
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  16.height,
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  void _login(response) {
    if (response.statusCode == 200) {
      final responseBody = json.decode(response.body);
      String jwt = responseBody['Token'];
      // storage.write('token', jwt);

      // Map<String, dynamic> jwtPayload = JwtHelper.parseJwtPayLoad(jwt);
      // storage.write('parent_id', jwtPayload['parent_id']);
      // storage.write('child_id', jwtPayload['child_id']);
      // LandingScreen().launch(context);
    } else {
      showErrorAlertDialog(context, 'Invalid Credentials',
          'Wrong email or password', () => Navigator.pop(context));
    }
  }
}
