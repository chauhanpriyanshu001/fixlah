import 'dart:developer';

import 'package:fixlah/config/constants.dart';
import 'package:fixlah/home/model/area_response_model.dart';

import 'package:fixlah/home/model/dashboard_data.dart';
import 'package:fixlah/home/model/issue_categories_data.dart';
import 'package:fixlah/home/model/issue_type_data.dart';
import 'package:fixlah/network/api_call.dart';
import 'package:fixlah/network/api_endpoints.dart';
import 'package:fixlah/network/response_model.dart';
import 'package:flutter/material.dart';

class HomeProvider extends ChangeNotifier {
  bool loading = false;
  DashboardData dashboardData = DashboardData();

  Future getData(context) async {
    loading = true;
    notifyListeners();

    ApiResponse apiResponse = await ApiCall.getApi(context,
        endpoint:
            "${ApiEndpoints.dashboard}?facility_ids=${selectedFacilities.join(",")}");
    if (apiResponse.statusCode == 200) {
      dashboardData = DashboardData();
      dashboardData = DashboardData.fromJson(apiResponse.response!);
      loading = false;
      notifyListeners();
    } else {
      loading = false;
      notifyListeners();
    }
  }

  // Get Area List
  Future getAreaList(context) async {
    try {
      loading = true;
      notifyListeners();
      ApiResponse apiResponse =
          await ApiCall.getApi(context, endpoint: ApiEndpoints.areas);
      if (apiResponse.statusCode == 200) {
        areaListResponse = AreaListResponse.fromJson(apiResponse.response!);
      }
    } catch (e) {
      print(e.toString());
    } finally {
      loading = false;
      notifyListeners();
    }
  }

  // Get Issue Type
  Future getIssueType(context) async {
    try {
      loading = true;
      notifyListeners();
      ApiResponse apiResponse = await ApiCall.getApi(context,
          endpoint: "${ApiEndpoints.issueTypes}?all=1&type=item");
      if (apiResponse.statusCode == 200) {
        issueTypeDataList.clear();
        print(apiResponse.response.length);
        for (var i = 0; i < apiResponse.response.length; i++) {
          issueTypeDataList
              .add(IssueTypeData.fromJson(apiResponse.response[i]));
          issueTypeDataDropDownlistList.add(DropdownMenuItem<IssueTypeData>(
            value: IssueTypeData.fromJson(apiResponse.response[i]),
            child: Text(issueTypeDataList[i].name ?? "-"),
          ));
        }
        print(issueTypeDataList);
      }
    } catch (e) {
      print("Error");
      print(e.toString());
    } finally {
      loading = false;
      notifyListeners();
    }
  }

  // Get Issue Categories
  Future getIssueCategory(context) async {
    try {
      loading = true;
      notifyListeners();
      ApiResponse apiResponse = await ApiCall.getApi(context,
          endpoint: "${ApiEndpoints.issueTypes}?all=1&type=main");
      if (apiResponse.statusCode == 200) {
        log(apiResponse.response.toString());
        log(apiResponse.response.length.toString());
        log(apiResponse.response[0].toString());
        issueCategoriesDataResponse = [];
        for (var i = 0; i < apiResponse.response.length; i++) {
          log(apiResponse.response[i].toString());
          issueCategoriesDataResponse
              .add(IssueCategorieData.fromJson(apiResponse.response[i]));
        }
      }
    } catch (e) {
      print("Error in adding issue category data");
      print(e.toString());
    } finally {
      loading = false;
      notifyListeners();
    }
  }
}
