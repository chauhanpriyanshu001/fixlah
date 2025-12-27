import 'package:fixlah/auth/provider/login_provider.dart';
import 'package:fixlah/auth/screen/face_detector.dart';
import 'package:fixlah/auth/screen/forgot_password_screen.dart';
import 'package:fixlah/config/colors.dart';
import 'package:fixlah/config/graphics.dart';
import 'package:fixlah/config/sizes.dart';
import 'package:fixlah/config/text_fields.dart';
import 'package:fixlah/config/utils.dart';
import 'package:fixlah/config/validators.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController username = TextEditingController();
  TextEditingController password = TextEditingController();
  bool rememberme = false;
  final _key = GlobalKey<FormState>();

  @override
  void dispose() {
    super.dispose();
    username.dispose();
    password.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: NewColors.primary,
      body: SafeArea(
        child: Consumer<LoginState>(builder: (context, login, child) {
          return Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Container(
                  width: fullWidth,
                  // height: fullHeight / 2,
                  decoration: const BoxDecoration(
                    gradient: LinearGradient(
                      begin: AlignmentDirectional.topCenter,
                      end: AlignmentDirectional.bottomCenter,
                      colors: [
                        NewColors.primary,
                        Colors.white,
                      ],
                    ),
                  ),
                  child: Column(
                    children: [
                      Expanded(
                        child: Image.asset(
                          Graphics.textlogo,
                          width: aspectRatio * 400,
                        ),
                      ),
                      Expanded(
                        flex: 2,
                        child: Image.asset(
                          Graphics.workerlogo,
                          width: aspectRatio * 500,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              // login form
              Container(
                color: NewColors.whitecolor,
                child: Padding(
                  padding: EdgeInsets.all(aspectRatio * 50),
                  child: Form(
                    key: _key,
                    child: Column(
                      children: [
                        CustomTextFields(
                          label: "User Name",
                          hintText: "Enter Username",
                          validator: Validators.validateRequired,
                          controller: username,
                        ),
                        SizedBox(
                          height: aspectRatio * 20,
                        ),
                        CustomTextFields(
                          label: "Password",
                          textInputAction: TextInputAction.done,
                          validator: Validators.validateRequired,
                          isPassword: true,
                          hintText: "Enter Password",
                          controller: password,
                        ),
                        SizedBox(
                          height: aspectRatio * 10,
                        ),
                        // extra
                        Row(
                          children: [
                            Checkbox(
                              value: rememberme,
                              onChanged: (value) {
                                rememberme = value!;
                                setState(() {});
                              },
                              shape: const CircleBorder(),
                              fillColor: const WidgetStatePropertyAll(
                                NewColors.primary,
                              ),
                            ),
                            Text(
                              "Remember Me",
                              style: TextStyle(
                                  fontSize: buildFontSize(30),
                                  fontWeight: FontWeight.w500),
                            ),
                            Expanded(child: SizedBox()),
                            InkWell(
                              onTap: () {
                                naviagteTo(context,
                                    builder: (context) =>
                                        ForgotPasswordScreen());
                              },
                              child: Text(
                                "Forgot Password",
                                style: TextStyle(
                                    fontSize: buildFontSize(30),
                                    fontWeight: FontWeight.w500),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: aspectRatio * 10,
                        ),
                        // login. and face detection

                        login.loading
                            ? LoadinWidget()
                            : Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Expanded(
                                    child: InkWell(
                                      onTap: () async {
                                        if (_key.currentState!.validate()) {
                                          await login.login(context,
                                              body: {
                                                "username": username.text,
                                                "password": password.text
                                              },
                                              rememberMe: rememberme);
                                        } else {
                                          Fluttertoast.showToast(
                                              fontSize: 15.r,
                                              textColor: NewColors.black,
                                              backgroundColor:
                                                  NewColors.primary,
                                              msg: "Please Check Your Input");
                                        }
                                      },
                                      child: Container(
                                        height: fullHeight / 15,
                                        decoration: BoxDecoration(
                                            color: NewColors.primary,
                                            borderRadius:
                                                BorderRadius.circular(100)),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Text(
                                              "Login",
                                              style: TextStyle(
                                                  fontWeight: FontWeight.w500,
                                                  fontSize: buildFontSize(35)),
                                            ),
                                            SizedBox(
                                              width: aspectRatio * 20,
                                            ),
                                            Image.asset(Graphics.right_arrow,
                                                width: aspectRatio * 50)
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    width: aspectRatio * 50,
                                  ),
                                  InkWell(
                                    onTap: () {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  FaceDetector(
                                                    isLogin: true,
                                                  )));
                                    },
                                    child: Image.asset(
                                      Graphics.face_lock,
                                      width: fullWidth / 10,
                                    ),
                                  )
                                ],
                              )
                      ],
                    ),
                  ),
                ),
              ),
              // SizedBox(
              //   height: aspectRatio * 10,
              // ),
              if (fullWidth < 400 == false)
                Container(
                  color: NewColors.whitecolor,
                  child: Padding(
                    padding: EdgeInsets.all(aspectRatio * 50),
                    child: Column(
                      children: [
                        Divider(
                          color: NewColors.secondaycolor,
                          thickness: 2,
                        ),
                        Row(
                          children: [
                            Text(
                              "Select Font Size",
                              style: TextStyle(
                                  color: NewColors.textcolor,
                                  fontSize: buildFontSize(30)),
                            ),
                            Expanded(child: SizedBox()),
                            InkWell(
                              onTap: () {
                                bigSize = false;
                                setState(() {});
                              },
                              child: Container(
                                padding: EdgeInsets.symmetric(
                                    vertical: aspectRatio * 10,
                                    horizontal: aspectRatio * 30),
                                decoration: BoxDecoration(
                                    color: bigSize == true
                                        ? NewColors.secondaycolor
                                        : Colors.white,
                                    borderRadius: BorderRadius.circular(16),
                                    border: Border.all(
                                      width: 3,
                                      color: bigSize == true
                                          ? NewColors.secondaycolor
                                          : NewColors.primary,
                                    )),
                                child: Center(
                                  child: Text(
                                    "A",
                                    style:
                                        TextStyle(fontSize: buildFontSize(40)),
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(
                              width: aspectRatio * 10,
                            ),
                            InkWell(
                              onTap: () {
                                bigSize = true;
                                setState(() {});
                              },
                              child: Container(
                                padding: EdgeInsets.symmetric(
                                    vertical: aspectRatio * 10,
                                    horizontal: aspectRatio * 30),
                                decoration: BoxDecoration(
                                    color: bigSize != true
                                        ? NewColors.secondaycolor
                                        : Colors.white,
                                    borderRadius: BorderRadius.circular(16),
                                    border: Border.all(
                                      width: 3,
                                      color: bigSize != true
                                          ? NewColors.secondaycolor
                                          : NewColors.primary,
                                    )),
                                child: Center(
                                  child: Text(
                                    "A",
                                    style:
                                        TextStyle(fontSize: buildFontSize(40)),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                )
            ],
          );
        }),
      ),
    );
  }
}
