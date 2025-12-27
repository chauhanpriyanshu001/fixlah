import 'dart:convert';

import 'package:fixlah/network/api_call.dart';
import 'package:fixlah/network/api_endpoints.dart';
import 'package:fixlah/network/response_model.dart';
import 'package:fixlah/userdata/user_data_model.dart';
import 'package:flutter/material.dart';

class UserdataProvider extends ChangeNotifier {
  bool loading = true;
  UserData userData = UserData();

  // get user data
  Future getUserData(context) async {
    loading = true;
    notifyListeners();
    ApiResponse response =
        await ApiCall.getApi(context, endpoint: ApiEndpoints.user);
    if (response.statusCode == 200) {
      userData = UserData.fromJson(response.response!);
      notifyListeners();
      print(userData.username);
      loading = false;
      notifyListeners();
      print(jsonEncode(response.response));
    }
  }
}
