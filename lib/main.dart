import 'dart:developer';

import 'package:face_camera/face_camera.dart';
import 'package:fixlah/auth/screen/spalsh.dart';

import 'package:fixlah/config/colors.dart';
import 'package:fixlah/config/constants.dart';
import 'package:fixlah/config/provider.dart';
import 'package:fixlah/config/sizes.dart';
import 'package:fixlah/work%20order/screen/wo_deatils.dart';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:onesignal_flutter/onesignal_flutter.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await FaceCamera.initialize(); //Face Detector
  // navigator
  appNavigator = GlobalKey<NavigatorState>();
  runApp(const MyApp());
  // Enable verbose logging for debugging (remove in production)
  OneSignal.Debug.setLogLevel(OSLogLevel.verbose);
  // Initialize with your OneSignal App ID
  OneSignal.initialize("94c41dbc-8c43-40a4-9480-7866127330f1");
  // Use this method to prompt for push notifications.
  OneSignal.Notifications.requestPermission(false);

  OneSignal.Notifications.addClickListener((data) {
    log("<--- Notification Data --->");
    log(data.toString());
    Map<String, dynamic>? notificationData = data.notification.additionalData;
    if (notificationData != null) {
      if (notificationData['type'] == "workorder") {
        if (notificationData['action'] == "open work order") {
          appNavigator!.currentState!.push(MaterialPageRoute(
              builder: (_) => WoDeatils(
                    id: notificationData['id'],
                  )));
        }
      }
    }
  });
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    aspectRatio = MediaQuery.sizeOf(context).aspectRatio;
    fullWidth = MediaQuery.sizeOf(context).width;
    fullHeight = MediaQuery.sizeOf(context).height;
    text_fields_font_Size = aspectRatio * 25;
    return ScreenUtilInit(
      designSize: const Size(375, 812),
      child: MultiProvider(
        providers: providers,
        child: SafeArea(
          top: false,
          left: false,
          right: false,
          bottom: false,
          child: MaterialApp(
            navigatorKey: appNavigator,
            debugShowCheckedModeBanner: false,
            title: 'Fix-Lah',
            theme: ThemeData(
              pageTransitionsTheme: const PageTransitionsTheme(builders: {
                TargetPlatform.android: CupertinoPageTransitionsBuilder(),
              }),
              bottomSheetTheme: const BottomSheetThemeData(
                  backgroundColor: NewColors.whitecolor),
              scaffoldBackgroundColor: Colors.white,
              appBarTheme: AppBarTheme(
                toolbarHeight: 60,
                iconTheme: IconThemeData(
                  size: 30, // Set your desired size here
                ),
                backgroundColor: Colors.white,
                actionsIconTheme: IconThemeData(size: 25),
              ),
              fontFamily: "Inter",
              colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
              useMaterial3: true,
            ),
            home: const SpalshScreen(),
          ),
        ),
      ),
    );
  }
}
