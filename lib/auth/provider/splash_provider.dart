import 'dart:developer';

import 'package:fixlah/auth/model/check_auth_data_model.dart';
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
  Future checkAuth(context, {String? accessTokenNew}) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    accessToken =
        sharedPreferences.getString(SharedPreferencesKey.accessToken) != "" &&
                sharedPreferences.getString(SharedPreferencesKey.accessToken) !=
                    null
            ? sharedPreferences.getString(SharedPreferencesKey.accessToken)!
            : accessTokenNew ?? "";
    log(accessToken);
    if (accessToken != "") {
      if (await checkToken(context)) {
        print(accessToken);
        if (accessTokenNew != null) {
          naviagteToandreplace(context,
              builder: (context) => const HomeScreen());
        } else {
          permissions = sharedPreferences
              .getStringList(SharedPreferencesKey.userPermissions)!;
          log(permissions.toString());
          naviagteToandreplace(context,
              builder: (context) => const HomeScreen());
        }
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
      CheckAuthDataModel checkAuthDataModel =
          CheckAuthDataModel.fromJson(apiResponse.response);
      approvedFacilities = checkAuthDataModel.user!.facilityIds!;
      return true;
    } else {
      return false;
    }
  }
}
