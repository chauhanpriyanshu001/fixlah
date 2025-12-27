import 'dart:developer';

import 'package:fixlah/auth/screen/login.dart';
import 'package:fixlah/config/constants.dart';
import 'package:fixlah/config/utils.dart';
import 'package:fixlah/home/screen/home_screen.dart';
import 'package:fixlah/network/api_call.dart';
import 'package:fixlah/network/api_endpoints.dart';
import 'package:fixlah/network/response_model.dart';

import 'package:flutter/material.dart';
import 'package:onesignal_flutter/onesignal_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SplashProvider extends ChangeNotifier {
  Future checkAuth(context) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    accessToken =
        sharedPreferences.getString(SharedPreferencesKey.accessToken) ?? "";

    if (accessToken != "") {
      if (await checkToken(context)) {
        print(accessToken);
        permissions = sharedPreferences
            .getStringList(SharedPreferencesKey.userPermissions)!;
        naviagteToandreplace(context, builder: (context) => const HomeScreen());
      } else {
        // One signal
        OneSignal.logout();

        naviagteToandreplace(context,
            builder: (context) => const LoginScreen());
      }
    } else {
      OneSignal.logout();

      naviagteToandreplace(context, builder: (context) => const LoginScreen());
    }
  }

  Future<bool> checkToken(context) async {
    ApiResponse apiResponse =
        await ApiCall.getApi(context, endpoint: ApiEndpoints.checkAuth);
    log(apiResponse.response.toString());
    if (apiResponse.statusCode == 200 && apiResponse.response != {}) {
      return true;
    } else {
      return false;
    }
  }
}
