import 'dart:convert';
import 'dart:developer';

import 'package:fixlah/config/colors.dart';
import 'package:fixlah/config/constants.dart';
import 'package:fixlah/config/utils.dart';
import 'package:fixlah/facilities/model/location_tag_model.dart';
import 'package:fixlah/home/screen/home_screen.dart';
import 'package:fixlah/inspection/model/inspection_get_model.dart';
import 'package:fixlah/inspection/model/inspection_response_model.dart'
    hide Data;
import 'package:fixlah/inspection/model/inspection_toRun_model.dart' hide Data;
import 'package:fixlah/inspection/screen/inspection_details2.dart';
import 'package:fixlah/inspection/screen/inspection_item.dart';
import 'package:fixlah/inspection/screen/inspection_report.dart';
import 'package:fixlah/inspection/screen/inspectipn_scanner.dart';
import 'package:fixlah/network/api_call.dart';
import 'package:fixlah/network/api_endpoints.dart';
import 'package:fixlah/network/response_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';
import 'package:url_launcher/url_launcher.dart';

class InspectionProvider extends ChangeNotifier {
  // Tab status
  String tabStatus = "To Run";
  // Tab Status Value
  String tabStatusValue = "";
// second inspection tab value
  int secondInspection = 0;
  // Pagination
  int page = 0;
  // Count Issue
  int statusCount = 0;
  // Normal loading while getting data
  bool loading = false;
  // Show while loading more data
  bool loadingMore = false;
  // Search vaiable
  String search = "";
  // In Progress Inspection data response instance
  InspectionResponse inspectionResponse = InspectionResponse();
  // In Progress Selected Inspection Data
  InspectionGetData inspectionData = InspectionGetData();
  // To Run Data response
  InspectionToRunResponse inspectionToRunResponse = InspectionToRunResponse();
  // Select to run data
  InspectionDataItem toRuninspectionData = InspectionDataItem();
  // selected Inspection item
  Items selctedItem = Items();
  // Inspection Type
  String inspectiontype = "";
  // Custom Facilities filter
  String? customFac;
  // Unit Specific filter for "To Run" tab
  String unitSpecific = "Unit Inspections";
  // Qr data
  LocationTagData? qrlocationTagData;
  // In progress count
  int inProgressCount = 0;
  // 2nd Inspection count
  int InspectionCount = 0;

  // get Inspection data
  Future getData(context) async {
    loading = true;
    page = 1;
    notifyListeners();
    if (tabStatusValue == "") {
      ApiResponse apiResponse = await ApiCall.getApi(context,
          endpoint:
              "${ApiEndpoints.inspectionTemplates}?page=$page&search=$search&facility_ids=${customFac ?? selectedFacilities.join(",")}&unit_specific=${unitSpecific.replaceFirst("Inspections", "")}");
      if (apiResponse.statusCode == 200) {
        inspectionToRunResponse = InspectionToRunResponse();

        inspectionToRunResponse =
            InspectionToRunResponse.fromJson(apiResponse.response);
        statusCount = inspectionToRunResponse.data!.total!;
      }
    } else {
      ApiResponse apiResponse = await ApiCall.getApi(context,
          endpoint:
              "${ApiEndpoints.inspections}?status=$tabStatusValue&page=$page&search=$search&facility_ids=${customFac ?? selectedFacilities.join(",")}&second_inspection=$secondInspection");
      if (apiResponse.statusCode == 200) {
        inspectionResponse = InspectionResponse();
        inspectionResponse = InspectionResponse.fromJson(apiResponse.response);
        statusCount = inspectionResponse.data!.total!;
      }
    }
    await getCount(context);
    loading = false;
    notifyListeners();
  }

  // get More Inspection data ( Other Page Data )
  Future getMoreData(context) async {
    loadingMore = true;
    page = page + 1;
    notifyListeners();
    if (tabStatusValue == "") {
      ApiResponse apiResponse = await ApiCall.getApi(context,
          endpoint:
              "${ApiEndpoints.inspectionTemplates}?page=$page&search=$search&facility_ids=${customFac ?? selectedFacilities.join(",")}&unit_specific=${unitSpecific.replaceFirst("Inspections", "")}");
      if (apiResponse.statusCode == 200) {
        InspectionToRunResponse tempinspectionToRunResponse =
            InspectionToRunResponse.fromJson(apiResponse.response);
        for (var i = 0;
            i < tempinspectionToRunResponse.data!.data!.length;
            i++) {
          inspectionToRunResponse.data!.data!
              .add(tempinspectionToRunResponse.data!.data![i]);
        }
      }
    } else {
      ApiResponse apiResponse = await ApiCall.getApi(context,
          endpoint:
              "${ApiEndpoints.inspections}?status=$tabStatusValue&page=$page&search=$search&facility_ids=${customFac ?? selectedFacilities.join(",")}&second_inspection=$secondInspection");
      if (apiResponse.statusCode == 200) {
        InspectionResponse tempinspectionResponse =
            InspectionResponse.fromJson(apiResponse.response);
        for (var i = 0; i < tempinspectionResponse.data!.data!.length; i++) {
          inspectionResponse.data!.data!
              .add(tempinspectionResponse.data!.data![i]);
        }
      }
    }

    loadingMore = false;
    notifyListeners();
  }

  // select tab
  selectTab(context, {required String newtabStatus}) {
    if (newtabStatus == "In Progress") {
      tabStatus = newtabStatus;
      secondInspection = 0;
      tabStatusValue = "in_progress";
    }
    if (newtabStatus == "2nd Inspection") {
      tabStatus = newtabStatus;
      secondInspection = 1;
      tabStatusValue = "in_progress";
    }
    if (newtabStatus == "To Run") {
      tabStatus = newtabStatus;
      secondInspection = 0;
      tabStatusValue = "";
    }
    getData(context);
  }

  // Inspection Data in progress
  selectInspection(context, {required String id}) {
    getInspection(context, inspectionId: id.toString());
    naviagteTo(context, builder: (context) => const InspectionDetails2());
    notifyListeners();
  }

  // Inspection Data to run
  selectToRunInspection(context, {required InspectionDataItem inspectiondata}) {
    qrlocationTagData = LocationTagData();
    toRuninspectionData = inspectiondata;
    naviagteTo(context, builder: (context) => const InspectipnScanner());
    notifyListeners();
  }

  // Create inspection to run
  Future createInspection(context, {required Map<String, dynamic> body}) async {
    try {
      loading = true;
      notifyListeners();
      ApiResponse apiResponse = await ApiCall.postApi(context,
          endpoint: ApiEndpoints.inspections, body: body);
      if (apiResponse.statusCode == 201 || apiResponse.statusCode == 200) {
        inspectionToRunResponse.data?.data?.remove(toRuninspectionData);
        statusCount = statusCount - 1;
        log(apiResponse.statusCode.toString());
        log(jsonEncode(apiResponse.response));

        Fluttertoast.showToast(
            backgroundColor: NewColors.greencolor,
            textColor: NewColors.whitecolor,
            fontSize: 15.r,
            msg: apiResponse.response['message'].toString());
        await getInspection(context,
            inspectionId: apiResponse.response['data']['id'].toString());
        Navigator.push(context,
                MaterialPageRoute(builder: (context) => InspectionDetails2()))
            .then((value) {
          if (value == true) {
            Navigator.pop(context, true);
          }
        });
      }
    } catch (e) {
      log("Error Creating Inspection");
      log(e.toString());
    } finally {
      loading = false;
      notifyListeners();
    }
  }

  // get inspection
  Future getInspection(context, {required String inspectionId}) async {
    try {
      loading = true;
      notifyListeners();
      ApiResponse apiResponse = await ApiCall.getApi(context,
          endpoint: "${ApiEndpoints.inspections}/$inspectionId");
      if (apiResponse.statusCode == 200) {
        inspectionData = InspectionGetData();
        log(jsonEncode(apiResponse.response));
        inspectionData = InspectionGetData.fromJson(apiResponse.response);
      }
    } catch (e) {
      log("Error in Geting inspection deatils");
      log(e.toString());
    } finally {
      loading = false;
      notifyListeners();
    }
  }

  // select inspection item
  selectInspectionItem(context, {required Items chossenItem}) {
    selctedItem = chossenItem;
    notifyListeners();
    naviagteTo(context, builder: (context) => const InspectionItem());
  }

// Update Item
  Future saveItem(context,
      {required int inspectionId,
      required int itemId,
      required Map<String, dynamic> body}) async {
    try {
      loading = true;
      notifyListeners();
      ApiResponse apiResponse = await ApiCall.postApi(context,
          endpoint:
              "${ApiEndpoints.inspections}/$inspectionId/${ApiEndpoints.items}/$itemId",
          body: body);
      log(apiResponse.statusCode.toString());
      if (apiResponse.statusCode == 201 || apiResponse.statusCode == 200) {
        // Save Photo
        log(apiResponse.response.toString());
        Fluttertoast.showToast(
            fontSize: 15.r,
            textColor: NewColors.whitecolor,
            backgroundColor: NewColors.greencolor,
            msg: apiResponse.response['message']);
        selctedItem.condition = apiResponse.response['data']['condition'];
        selctedItem.overallGrade =
            apiResponse.response['data']['overall_grade'];
        selctedItem.remarks = apiResponse.response['data']['remarks'];
        Navigator.pop(context);
      }
    } catch (e) {
      log("Error in saving inspection item");
      log(e.toString());
    } finally {
      loading = false;
      notifyListeners();
    }
  }

  // Search
  makeSearch(context, {required String searchQuery}) {
    search = searchQuery;
    getData(context);
  }

  // Update Item Photo
  Future saveItemPhoto(context,
      {required int inspectionId,
      required Map<String, dynamic> body,
      List<XFile>? file}) async {
    try {
      loading = true;
      notifyListeners();
      ApiResponse apiResponse = await ApiCall.postApi(context,
          endpoint: "${ApiEndpoints.inspections}/$inspectionId/photos",
          body: body,
          file: file,
          fileParameter: "photo");
      log(apiResponse.statusCode.toString());
      if (apiResponse.statusCode == 201 || apiResponse.statusCode == 200) {
        log(apiResponse.response.toString());
        if (body['type'] == "good") {
          selctedItem.goodPhotos
              ?.add(InspectionPhoto.fromJson(apiResponse.response["data"]));
        }
        if (body['type'] == "before") {
          selctedItem.beforePhotos
              ?.add(InspectionPhoto.fromJson(apiResponse.response["data"]));
        }
        if (body['type'] == "after") {
          selctedItem.afterPhotos
              ?.add(InspectionPhoto.fromJson(apiResponse.response["data"]));
        }
        Fluttertoast.showToast(
            fontSize: 15.r,
            textColor: NewColors.whitecolor,
            backgroundColor: NewColors.greencolor,
            msg: apiResponse.response["message"]);
      }
    } catch (e) {
      log("Error in saving inspection item Photo");
      log(e.toString());
    } finally {
      loading = false;
      notifyListeners();
    }
  }

  // delete item photo
  Future deleteItemPhoto(context,
      {required String type, required int photoId}) async {
    try {
      loading = true;
      notifyListeners();
      ApiResponse apiResponse = await ApiCall.deleteApi(
        context,
        endpoint:
            "${ApiEndpoints.inspections}/${selctedItem.inspectionId}/photos/$type/$photoId",
      );
      log(apiResponse.statusCode.toString());
      if (apiResponse.statusCode == 200) {
        log(apiResponse.response.toString());
        if (type == "good") {
          selctedItem.goodPhotos?.removeWhere((data) => data.id == photoId);
        }
        if (type == "before") {
          selctedItem.beforePhotos?.removeWhere((data) => data.id == photoId);
        }
        if (type == "after") {
          selctedItem.afterPhotos?.removeWhere((data) => data.id == photoId);
        }
        Fluttertoast.showToast(
            fontSize: 15.r,
            textColor: NewColors.whitecolor,
            backgroundColor: NewColors.greencolor,
            msg: apiResponse.response["message"]);
      }
    } catch (e) {
      log("Error in saving inspection item Photo");
      log(e.toString());
    } finally {
      loading = false;
      notifyListeners();
    }
  }

  // Check inspection and navigate for generating report
  checkAndNaviagte(context) {
    bool navigate = true;
    for (var i = 0; i < inspectionData.data!.items!.length; i++) {
      if (inspectionData.data!.items![i].condition == null &&
          inspectionData.data!.items![i].overallGrade == null) {
        navigate = false;
        break;
      }
    }
    if (navigate == true) {
      naviagteTo(context, builder: (context) => const InspectionReport());
    } else {
      Fluttertoast.showToast(
        fontSize: 15.r,
        msg: "Please Complete Your Inspection",
        textColor: NewColors.whitecolor,
        backgroundColor: NewColors.red,
      );
    }
  }

  // Generate Report ( Complete Inspection )
  Future completeInspection(context,
      {required Map<String, dynamic> body,
      List<XFile>? file,
      String? fileParameter}) async {
    try {
      loading = true;
      notifyListeners();
      ApiResponse apiResponse = await ApiCall.postApi(
        context,
        endpoint:
            "${ApiEndpoints.inspections}/${inspectionData.data?.id}/${ApiEndpoints.signatures}",
        body: body,
        file: file,
        fileParameter: fileParameter,
      );
      log(apiResponse.statusCode.toString());
      if (apiResponse.statusCode == 200) {
        Fluttertoast.showToast(
            fontSize: 15.r,
            textColor: NewColors.whitecolor,
            backgroundColor: NewColors.greencolor,
            msg: apiResponse.response['message']);
        if (!context.mounted) return;

        await getStatus(context, inspection: inspectionData.data);

        naviagteToandreplace(
          context,
          builder: (context) => const HomeScreen(),
        );
      }
    } catch (e) {
      log("Error in Signing Inspection");
      log(e.toString());
    } finally {
      loading = false;
      notifyListeners();
    }
  }

  // Select custom Filter
  selectFilter(context, {required String id}) {
    customFac = id;
    getData(context);
  }

// Select Unit Specific for "To Run" tab
  selectUnitSpecific(context, {required String selectedValue}) {
    unitSpecific = selectedValue;
    notifyListeners();
    getData(context);
  }

  // Get Qr Data
  Future getQrData(context, {required String qrid}) async {
    try {
      loading = true;
      notifyListeners();
      ApiResponse apiResponse = await ApiCall.getApi(context,
          endpoint: "${ApiEndpoints.locationtags}/$qrid/get");
      if (apiResponse.statusCode == 200) {
        log(jsonEncode(apiResponse.response));
        qrlocationTagData = LocationTagData();
        qrlocationTagData = LocationTagData.fromJson(apiResponse.response);
      }
    } catch (e) {
      print("error getting data");
      print(e.toString());
    } finally {
      loading = false;
      notifyListeners();
    }
  }

// Get Count
  Future getCount(context) async {
    try {
      loading = true;
      notifyListeners();
      ApiResponse apiResponse = await ApiCall.getApi(context,
          endpoint: ApiEndpoints.inspections +
              "?status=in_progress&include_counts=1");
      if (apiResponse.statusCode == 200) {
        log(apiResponse.response.toString());
        inProgressCount = apiResponse.response['data']['total'];
        notifyListeners();
      }
      ApiResponse apiResponse2 = await ApiCall.getApi(context,
          endpoint: ApiEndpoints.inspections +
              "?status=in_progress&include_counts=1&second_inspection=1");
      if (apiResponse2.statusCode == 200) {
        log(apiResponse2.response.toString());
        InspectionCount = apiResponse2.response['data']['total'];
        notifyListeners();
      }
    } catch (e) {
      log("Error is Getting Status");
      log(e.toString());
    } finally {
      loading = false;
      notifyListeners();
    }
  }

  // get report status
  Future<bool?>? getStatus(context, {required Data? inspection}) async {
    try {
      loading = true;
      notifyListeners();
      ApiResponse apiResponse = await ApiCall.getApi(context,
          endpoint: ApiEndpoints.inspections +
              "/${inspection?.id.toString()}/reports/status");
      if (apiResponse.statusCode == 200) {
        log(apiResponse.response.toString());
        if (apiResponse.response['report_status'] == "generated") {
          launchUrl(Uri.parse(apiResponse.response['html_url']));
        }
      }
    } catch (e) {
      log("Error in getting inspection status");
      log(e.toString());
    } finally {
      loading = true;
      notifyListeners();
    }
    return null;
  }

  // Get report Html url
  Future getReportHtml(context, {required Data? inspectionId}) async {
    try {
      loading = true;
      notifyListeners();
      ApiResponse apiResponse = await ApiCall.getApi(context,
          endpoint: ApiEndpoints.inspections +
              "/${inspectionId?.id}/reports/pdf-url");
      if (apiResponse.statusCode == 200) {
        log(apiResponse.response.toString());
      }
    } catch (e) {
      log("Error in getting Report Pdf Url");
      log(e.toString());
    } finally {
      loading = false;
      notifyListeners();
    }
  }
}
