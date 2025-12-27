import 'package:fixlah/auth/provider/login_provider.dart';
import 'package:fixlah/config/colors.dart';
import 'package:fixlah/config/sizes.dart';
import 'package:fixlah/config/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

class ConfirmFace extends StatelessWidget {
  const ConfirmFace({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: NewColors.primary,
        title: Text(
          "Confirm Face Lock",
          style: TextStyle(fontSize: 18.r),
        ),
      ),
      body: Consumer<LoginState>(builder: (context, login, child) {
        return Column(
          children: [
            login.faceImage != null
                ? Expanded(child: Image.file(login.faceImage!))
                : SizedBox(),
            Padding(
              padding: EdgeInsets.all(10.r),
              child: Column(
                children: [
                  login.loading
                      ? LoadinWidget()
                      : InkWell(
                          onTap: () async {
                            login.setfaceLock(context);
                          },
                          child: Container(
                            height: fullHeight / 15,
                            decoration: BoxDecoration(
                                color: NewColors.primary,
                                borderRadius: BorderRadius.circular(100)),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  "Set Face Lock",
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: buildFontSize(35)),
                                ),
                              ],
                            ),
                          ),
                        ),
                ],
              ),
            )
          ],
        );
      }),
    );
  }
}
