import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:fixlah/auth/model/face_login_data_model.dart';
import 'package:fixlah/auth/model/login_response_model.dart';

import 'package:fixlah/auth/screen/login.dart';
import 'package:fixlah/config/colors.dart';
import 'package:fixlah/config/constants.dart';
import 'package:fixlah/config/utils.dart';
import 'package:fixlah/home/screen/home_screen.dart';
import 'package:fixlah/network/api_call.dart';
import 'package:fixlah/network/api_endpoints.dart';
import 'package:fixlah/network/response_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';
import 'package:onesignal_flutter/onesignal_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginState extends ChangeNotifier {
  bool rememberMe = false;
  bool passwordVisible = false;
  bool loading = false;
  double fontSize = 16.0;
  LoginResponse loginResponse = LoginResponse();
  File? faceImage;

  void toggleRememberMe() {
    rememberMe = !rememberMe;
    notifyListeners();
  }

  void togglePasswordVisibility() {
    passwordVisible = !passwordVisible;
    notifyListeners();
  }

  void setFontSize(double size) {
    fontSize = size;
    notifyListeners();
  }

  // Login Logic
  Future login(context,
      {Map<String, dynamic>? body, required bool rememberMe}) async {
    loading = true;
    notifyListeners();
    ApiResponse response = await ApiCall.postApi(context,
        body: body, endpoint: ApiEndpoints.login);
    if (response.statusCode == 200) {
      log(jsonEncode(response.response));
      loginResponse = LoginResponse.fromJson(response.response!);
      SharedPreferences sharedPreferences =
          await SharedPreferences.getInstance();
      accessToken = loginResponse.token!;
      permissions = loginResponse.user!.permissions!;
      OneSignal.login("${body!['username']}");

      if (rememberMe == true) {
        sharedPreferences.setStringList(
            SharedPreferencesKey.userPermissions, permissions);
        sharedPreferences.setString(
            SharedPreferencesKey.accessToken, accessToken);
      } else {
        sharedPreferences
            .setStringList(SharedPreferencesKey.userPermissions, []);
        sharedPreferences.setString(SharedPreferencesKey.accessToken, "");
      }
      naviagteToandreplace(context, builder: (context) => const HomeScreen());
    }
    loading = false;
    notifyListeners();
  }
// Forgot Password

  Future forgotPassword(context, {required String username}) async {
    try {
      loading = true;
      notifyListeners();
      ApiResponse apiResponse = await ApiCall.postApi(context,
          endpoint: ApiEndpoints.forgotPassword, body: {"username": username});
      if (apiResponse.statusCode == 200 || apiResponse.statusCode == 201) {
        log(apiResponse.response.toString());
        Fluttertoast.showToast(
          msg: apiResponse.response['message'],
          backgroundColor: NewColors.greencolor,
          textColor: NewColors.whitecolor,
          fontSize: 15.r,
        );
        Navigator.pop(context);
      }
    } catch (e) {
      log("Error in Forgot Password");
      log(e.toString());
    } finally {
      loading = false;
      notifyListeners();
    }
  }

// Temp save face image

  saveFaceImage(context, {required File imageFile}) {
    faceImage = imageFile;
    notifyListeners();
  }

  // set face lock
  Future setfaceLock(context) async {
    try {
      loading = true;
      notifyListeners();
      ApiResponse apiResponse = await ApiCall.postApi(
        context,
        endpoint: ApiEndpoints.faceenroll,
        body: {
          "user_id": loginResponse.user?.id,
        },
        file: [XFile(faceImage!.path)],
        fileParameter: "image",
      );
      if (apiResponse.statusCode == 200 || apiResponse.statusCode == 201) {
        log(apiResponse.response.toString());
        Fluttertoast.showToast(
          msg: apiResponse.response['message'].toString(),
          textColor: NewColors.whitecolor,
          backgroundColor: NewColors.greencolor,
          fontSize: 15.r,
        );
        faceImage = null;
        Navigator.pop(context, true);
      }
    } catch (e) {
      log("Error in Face Lock Setup");
      log(e.toString());
    } finally {
      loading = false;
      notifyListeners();
    }
  }

//  face authentication
  Future faceLock(context) async {
    try {
      loading = true;
      notifyListeners();
      ApiResponse apiResponse = await ApiCall.postApi(
        context,
        endpoint: ApiEndpoints.facelogin,
        body: {},
        file: [XFile(faceImage!.path)],
        fileParameter: "image",
      );
      if (apiResponse.statusCode == 200 || apiResponse.statusCode == 201) {
        log(jsonEncode(apiResponse.response));
        FaceLoginData loginResponse =
            FaceLoginData.fromJson(apiResponse.response!);
        SharedPreferences sharedPreferences =
            await SharedPreferences.getInstance();
        accessToken = loginResponse.token!;
        permissions = loginResponse.user!.permissions!;
        if (rememberMe == true) {
          sharedPreferences.setStringList(
              SharedPreferencesKey.userPermissions, permissions);
          sharedPreferences.setString(
              SharedPreferencesKey.accessToken, accessToken);
        } else {
          sharedPreferences
              .setStringList(SharedPreferencesKey.userPermissions, []);
          sharedPreferences.setString(SharedPreferencesKey.accessToken, "");
        }
        naviagteToandreplace(context, builder: (context) => const HomeScreen());
        Fluttertoast.showToast(
          msg: apiResponse.response['message'].toString(),
          textColor: NewColors.whitecolor,
          backgroundColor: NewColors.greencolor,
          fontSize: 15.r,
        );
        faceImage = null;
      }
    } catch (e) {
      log("Error in Face Lock Setup");
      log(e.toString());
    } finally {
      loading = false;
      notifyListeners();
    }
  }
  // Logout

  Future logOut(context) async {
    try {
      loading = true;
      notifyListeners();
      loginResponse = LoginResponse();
      SharedPreferences sharedPreferences =
          await SharedPreferences.getInstance();
      accessToken = "";
      permissions = [];
      sharedPreferences.setStringList(
          SharedPreferencesKey.userPermissions, permissions);
      sharedPreferences.setString(
          SharedPreferencesKey.accessToken, accessToken);
      OneSignal.logout();

      naviagteToandreplace(context, builder: (context) => const LoginScreen());
    } catch (e) {
      log("Error in Logout");
      log(e.toString());
    } finally {
      loading = false;
      notifyListeners();
    }
  }
}
