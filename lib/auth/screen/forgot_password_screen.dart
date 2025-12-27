import 'package:fixlah/auth/provider/login_provider.dart';
import 'package:fixlah/config/colors.dart';
import 'package:fixlah/config/graphics.dart';
import 'package:fixlah/config/sizes.dart';
import 'package:fixlah/config/text_fields.dart';
import 'package:fixlah/config/utils.dart';
import 'package:fixlah/config/validators.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:provider/provider.dart';

class ForgotPasswordScreen extends StatefulWidget {
  const ForgotPasswordScreen({super.key});

  @override
  State<ForgotPasswordScreen> createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  TextEditingController username = TextEditingController();
  final _key = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Consumer<LoginState>(builder: (context, login, child) {
        return Column(
          children: [
            Expanded(
              flex: 2,
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
                        width: 200.r,
                      ),
                    ),
                    Expanded(
                      flex: 2,
                      child: Image.asset(
                        Graphics.workerlogo,
                        width: 250.r,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Expanded(
              child: Padding(
                padding: EdgeInsetsGeometry.all(20.r),
                child: Form(
                    key: _key,
                    child: Column(
                      children: [
                        CustomTextFields(
                          controller: username,
                          label: "Username",
                          validator: Validators.validateRequired,
                          hintText: "Enter your Username",
                        ),
                        SizedBox(
                          height: 20.r,
                        ),
                        login.loading
                            ? LoadinWidget()
                            : Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Expanded(
                                    child: InkWell(
                                      onTap: () async {
                                        if (_key.currentState!.validate()) {
                                          await login.forgotPassword(
                                            context,
                                            username: username.text,
                                          );
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
                                              "Send Reset Link",
                                              style: TextStyle(
                                                  fontWeight: FontWeight.w500,
                                                  fontSize: buildFontSize(35)),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              )
                      ],
                    )),
              ),
            ),
            TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: Text(
                  "Back to Login",
                  style: TextStyle(
                      color: NewColors.black, fontWeight: mediumFontWeight),
                ))
          ],
        );
      }),
    );
  }
}
