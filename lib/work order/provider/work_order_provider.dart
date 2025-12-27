import 'dart:convert';
import 'dart:developer';

import 'package:camera/camera.dart';
import 'package:fixlah/config/colors.dart';
import 'package:fixlah/config/constants.dart';
import 'package:fixlah/config/utils.dart';

import 'package:fixlah/home/provider/home_provider.dart';
import 'package:fixlah/home/screen/home_screen.dart';
import 'package:fixlah/network/api_call.dart';
import 'package:fixlah/network/api_endpoints.dart';
import 'package:fixlah/network/response_model.dart';
import 'package:fixlah/work%20order/model/work_order_detail_model.dart';
import 'package:fixlah/work%20order/model/work_order_model.dart';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';

class WorkOrderProvider extends ChangeNotifier {
  // Pagination
  int currentPage = 0;
  // Normal loading while getting data
  bool loading = false;
  // Show while loading more data
  bool loadingMore = false;
  // Count WO
  int statusCount = 0;

  // Tab Status
  String tabStatus = "Urgent";
  // my or all work order
  String woType = "myworkorder"; // for api
  String woOrder = "My"; // for ui
  // Search var
  String search = "";
  // Main WO List
  WorkOrderList workOrderList = WorkOrderList();
  WorkOrderDetails selctedWOData = WorkOrderDetails();
  // selected wo
  // Filter : All, Cream, non-cream
  String filter = "ALL";

// Get main wo list
  getData(context) async {
    try {
      loading = true;
      currentPage = 1;
      notifyListeners();
      ApiResponse apiResponse = await ApiCall.getApi(context,
          endpoint:
              "${ApiEndpoints.workOrder}?facility_ids=${selectedFacilities.join(",")}&page=$currentPage&status=$woType&priority=${tabStatus.toLowerCase().replaceAll(" ", "")}&search=$search");
      print(apiResponse.response.toString());
      print(apiResponse.statusCode);
      if (apiResponse.statusCode == 200) {
        workOrderList = WorkOrderList();
        workOrderList = WorkOrderList.fromJson(apiResponse.response!);
        if (filter != "ALL") {
          // Check for filter
          List<WorkOrderData> newDataList = [];
          statusCount = workOrderList.data!.total!;

          for (var i = 0; i < workOrderList.data!.data!.length; i++) {
            if (filter == "CREAM") {
              if (workOrderList.data!.data![i].creamUnit == 1) {
                newDataList.add(workOrderList.data!.data![i]);
              }
            }
            if (filter == "NON-CREAM") {
              if (workOrderList.data!.data![i].creamUnit == 0) {
                newDataList.add(workOrderList.data!.data![i]);
              }
            }
          }
          workOrderList.data!.data = newDataList;
        }
        notifyListeners();
      }
    } catch (e) {
      print("Error in getting work order");
      print(e.toString());
    } finally {
      loading = false;
      notifyListeners();
    }
  }

  Future getMoreData(context) async {
    try {
      loadingMore = true;
      currentPage = currentPage + 1;
      notifyListeners();
      ApiResponse apiResponse = await ApiCall.getApi(context,
          endpoint:
              "${ApiEndpoints.workOrder}?facility_ids=${selectedFacilities.join(",")}&page=$currentPage&status=$woType&priority=${tabStatus.toLowerCase().replaceAll(" ", "")}&search=$search");

      if (apiResponse.statusCode == 200) {
        WorkOrderList tempissuesList =
            WorkOrderList.fromJson(apiResponse.response!);

        for (var i = 0; i < tempissuesList.data!.data!.length; i++) {
          WorkOrderData issueData = tempissuesList.data!.data![i];
          workOrderList.data!.data!.add(issueData);
          notifyListeners();
        }
        statusCount = workOrderList.data!.total ?? 0;
        print(workOrderList.data!.data!.length);
        if (filter != "ALL") {
          // Check for filter
          List<WorkOrderData> newDataList = [];
          for (var i = 0; i < workOrderList.data!.data!.length; i++) {
            if (filter == "CREAM") {
              if (workOrderList.data!.data![i].creamUnit == 1) {
                newDataList.add(workOrderList.data!.data![i]);
              }
            }
            if (filter == "NON-CREAM") {
              if (workOrderList.data!.data![i].creamUnit == 0) {
                newDataList.add(workOrderList.data!.data![i]);
              }
            }
          }
          workOrderList.data!.data = newDataList;
        }
      }
    } catch (e) {
      print("This is error");
      print(e.toString());
    } finally {
      loadingMore = false;
      notifyListeners();
    }
  }

  // change tab status
  changeTab(context, {required String newTab}) {
    tabStatus = newTab;
    notifyListeners();
    getData(context);
  }

  // Search
  searchRequest(context, {required String searchText}) {
    search = searchText;
    notifyListeners();
    getData(context);
  }

  // Select WO type
  selectWoType(context, {required String woTypeInput}) {
    woOrder = woTypeInput;
    if (woOrder == "My") {
      woType = "myworkorder";
    } else {
      woType = "pending";
    }
    notifyListeners();
    getData(context);
  }

  // select All, Cream, Non-cream
  changeFilter(context, {required String selctedFilter}) {
    filter = selctedFilter;
    notifyListeners();
    getData(context);
  }

  // Complete Work Order
  Future completeWO(context,
      {required String id,
      required Map<String, dynamic>? body,
      required List<XFile>? file}) async {
    try {
      loading = true;
      notifyListeners();
      ApiResponse apiResponse = await ApiCall.postApi(
        context,
        endpoint: "${ApiEndpoints.workOrder}/$id/complete",
        fileParameter: "completion_photos[]",
        body: body,
        file: file,
      );
      if (apiResponse.statusCode == 200 || apiResponse.statusCode == 201) {
        Fluttertoast.showToast(
            textColor: NewColors.whitecolor,
            backgroundColor: NewColors.greencolor,
            fontSize: 15.r,
            msg: apiResponse.response['message']);
        HomeProvider homeProvider = HomeProvider();
        homeProvider.getData(context);
        naviagteToandreplace(context, builder: (context) => HomeScreen());
      }
    } catch (e) {
      log("Error in WO Completion");
      log(e.toString());
    } finally {
      loading = false;
      notifyListeners();
    }
  }

// Get wo details
  Future getWoDetails(context, {required String woId}) async {
    try {
      loading = true;
      notifyListeners();
      ApiResponse apiResponse = await ApiCall.getApi(context,
          endpoint: ApiEndpoints.workOrder + "/${woId}");
      if (apiResponse.statusCode == 200) {
        log(jsonEncode(apiResponse.response));
        selctedWOData = WorkOrderDetails.fromJson(apiResponse.response);
      }
    } catch (e) {
      log("Error is getting work order deatils");
      log(e.toString());
    } finally {
      loading = false;
      notifyListeners();
    }
  }
}
