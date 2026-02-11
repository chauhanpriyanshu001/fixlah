import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'dart:typed_data';

import 'package:camera/camera.dart';
import 'package:fixlah/config/colors.dart';
import 'package:fixlah/config/constants.dart';

import 'package:fixlah/facilities/model/location_tag_model.dart';
import 'package:fixlah/facilities/provider/facilities_provider.dart';
import 'package:fixlah/home/provider/home_provider.dart';

import 'package:fixlah/issues/model/issue_assets_model.dart';
import 'package:fixlah/issues/model/issue_details_model.dart' hide Photos;
import 'package:fixlah/issues/model/issues_model.dart';
import 'package:fixlah/issues/screens/create_issue.dart';
import 'package:fixlah/issues/screens/issues_details.dart';
import 'package:fixlah/issues/screens/mark_image.dart';
import 'package:fixlah/issues/screens/unit_issue_2.dart';
import 'package:fixlah/issues/screens/unit_issue_final.dart';
import 'package:fixlah/network/api_call.dart';
import 'package:fixlah/network/api_endpoints.dart';
import 'package:fixlah/network/response_model.dart';
import 'package:fixlah/work%20order/model/work_order_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'dart:ui' as ui;
import 'package:path_provider/path_provider.dart';
import 'package:provider/provider.dart';

class IssuesProvider extends ChangeNotifier {
  String issueType = "";
  String search = "";
  XFile? image;
  String filter = "ALL";
  IssuesList issuesList = IssuesList();
  String status = "Urgent";
  // Count Issue
  int statusCount = 0;
  // Normal loading while getting data
  bool loading = false;
  // Show while loading more data
  bool loadingMore = false;
  IssueData? selctedIssueId;
  // Count Page
  int currentPage = 0;
  // Below variables is used to create unit issue
  File? finalImage;
  List<XFile> finalImges = [];
  Map<String, dynamic> createIssue = {};
  bool qrData = false;
  LocationTagData qrlocationTagData = LocationTagData();
  String selectedClientName = "";
  int itemCount = 0;
  ItemAssetsResponse itemAssetsResponse = ItemAssetsResponse();
  // Issue Urgent Count
  int urgentIssueCount = 0;
  // Issue Not Urgent Count
  int noturgentIssueCount = 0;
  // Issue deatils
  IssueDetails issueDetails = IssueDetails();

  resset() {
    finalImage = null;
    finalImges = [];
    createIssue = {};
    qrData = false;
    qrlocationTagData = LocationTagData();
    selectedClientName = "";
    itemCount = 0;
    itemAssetsResponse = ItemAssetsResponse();
    notifyListeners();
  }

  // set issue type
  setIssueType(context, {required String type}) {
    issueType = type;
    notifyListeners();
    if (issueType != "") {
      Navigator.push(context,
              MaterialPageRoute(builder: (context) => const UnitIssue2()))
          .then((value) {
        if (value == true) {
          Navigator.pop(context, true);
        }
      });
    }
  }

  checkNavigate(context) {
    // if (issueType == "Unit") {
    Navigator.push(context,
            MaterialPageRoute(builder: (context) => const CreateIssue()))
        .then((value) {
      if (value == true) {
        Navigator.pop(context, true);
      }
    });
    // } else if (issueType == "Common Area") {
    //   Navigator.push(
    //       context, MaterialPageRoute(builder: (context) => const CaIssue()));
    // }
  }

  Future<ui.Image> loadUiImage(File file) async {
    final bytes = await file.readAsBytes();
    final codec = await ui.instantiateImageCodec(bytes);
    final frame = await codec.getNextFrame();
    return frame.image;
  }

  captureImage(context,
      {required XFile capturedimage,
      required bool goback,
      int? index,
      bool? addImage}) async {
    image = capturedimage;
    notifyListeners();
    final file = File(image!.path);
    ui.Image decodedimage = await loadUiImage(file);
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => MarkImageScreen(
                  goback: goback,
                  capturedImage: decodedimage,
                  index: index,
                  addImage: addImage,
                  capturedImageFile: File(capturedimage.path),
                ))).then((value) {
      Navigator.pop(context, true);
    });
  }

  Future saveImage(
    context, {
    required Uint8List byteList,
    required bool goback,
  }) async {
    finalImage = await uint8ListToFile(byteList, "issue${DateTime.now()}");
    if (finalImage != null) {
      if (goback) {
        finalImges.add(XFile(finalImage!.path));
        notifyListeners();
        Navigator.pop(context);
      } else {
        finalImges.clear();
        finalImges.add(XFile(finalImage!.path));
        notifyListeners();
        Navigator.push(context,
            MaterialPageRoute(builder: (context) => UnitIssueFinal())).then(
          (value) {
            Navigator.pop(context, true);
          },
        );
      }
    }
  }

  Future<File> uint8ListToFile(Uint8List byteList, String fileName) async {
    // Get temporary directory (you can also use getApplicationDocumentsDirectory)
    final tempDir = await getTemporaryDirectory();
    final file = File('${tempDir.path}/$fileName');

    // Write the bytes to the file
    await file.writeAsBytes(byteList, flush: true);

    return file;
  }

  // get issue list

  Future getData(context) async {
    try {
      loading = true;
      currentPage = 1;
      notifyListeners();
      ApiResponse apiResponse = await ApiCall.getApi(context,
          endpoint:
              "${ApiEndpoints.issues}?facility_ids=${selectedFacilities.join(",")}&page=$currentPage&status=${status.replaceAll(" ", "")}&search=$search");

      if (apiResponse.statusCode == 200) {
        issuesList = IssuesList();
        issuesList = IssuesList.fromJson(apiResponse.response!);
        log(apiResponse.response.toString());

        statusCount = issuesList.data!.total ?? 0;
        print(issuesList.data!.data!.length);
        if (filter != "ALL") {
          // Check for filter
          log(issuesList.data!.data.toString());
          List<IssueData> newDataList = [];
          for (var i = 0; i < issuesList.data!.data!.length; i++) {
            if (filter == "CREAM") {
              if (issuesList.data!.data![i].creamUnit == 1) {
                newDataList.add(issuesList.data!.data![i]);
              }
            }
            if (filter == "NON-CREAM") {
              if (issuesList.data!.data![i].creamUnit == 0) {
                newDataList.add(issuesList.data!.data![i]);
              }
            }
          }
          issuesList.data!.data = newDataList;
        }
      }
    } catch (e) {
      print("This is error");
      print(e.toString());
    } finally {
      loading = false;
      notifyListeners();
    }
  }

  // load more data
  Future getMoreData(context, {required int newpage}) async {
    try {
      loading = true;
      currentPage = newpage;
      notifyListeners();
      ApiResponse apiResponse = await ApiCall.getApi(context,
          endpoint:
              "${ApiEndpoints.issues}?facility_ids=${selectedFacilities.join(",")}&page=$currentPage&status=${status.replaceAll(" ", "")}&search=$search");

      if (apiResponse.statusCode == 200) {
        // IssuesList tempissuesList = IssuesList.fromJson(apiResponse.response!);
        // print(tempissuesList.data!.nextPageUrl);
        // for (var i = 0; i < tempissuesList.data!.data!.length; i++) {
        //   IssueData issueData = tempissuesList.data!.data![i];
        //   issuesList.data!.data!.add(issueData);
        //   notifyListeners();
        // }
        // statusCount = issuesList.data!.total ?? 0;
        // print(issuesList.data!.data!.length);
        // if (filter != "ALL") {
        //   // Check for filter
        //   List<IssueData> newDataList = [];
        //   for (var i = 0; i < issuesList.data!.data!.length; i++) {
        //     if (filter == "CREAM") {
        //       if (issuesList.data!.data![i].creamUnit == 1) {
        //         newDataList.add(issuesList.data!.data![i]);
        //       }
        //     }
        //     if (filter == "NON-CREAM") {
        //       if (issuesList.data!.data![i].creamUnit == 0) {
        //         newDataList.add(issuesList.data!.data![i]);
        //       }
        //     }
        //   }
        //   issuesList.data!.data = newDataList;
        // }
        issuesList = IssuesList();
        issuesList = IssuesList.fromJson(apiResponse.response!);
        log(apiResponse.response.toString());

        statusCount = issuesList.data!.total ?? 0;
        print(issuesList.data!.data!.length);
        if (filter != "ALL") {
          // Check for filter
          log(issuesList.data!.data.toString());
          List<IssueData> newDataList = [];
          for (var i = 0; i < issuesList.data!.data!.length; i++) {
            if (filter == "CREAM") {
              if (issuesList.data!.data![i].creamUnit == 1) {
                newDataList.add(issuesList.data!.data![i]);
              }
            }
            if (filter == "NON-CREAM") {
              if (issuesList.data!.data![i].creamUnit == 0) {
                newDataList.add(issuesList.data!.data![i]);
              }
            }
          }
          issuesList.data!.data = newDataList;
        }
      }
    } catch (e) {
      print("This is error");
      print(e.toString());
    } finally {
      loading = false;
      notifyListeners();
    }
  }

  // change issues status
  changeIssueStatus(context, {required String newstatus}) {
    status = newstatus;
    notifyListeners();
    getData(context);
  }

  // search
  makeSearch(context, {required String searchText}) {
    search = searchText;
    notifyListeners();
    getData(context);
  }

  // select All, Cream, Non-cream
  changeFilter(context, {required String selctedFilter}) {
    filter = selctedFilter;
    notifyListeners();
    getData(context);
  }

// Select Issue
  selectIssue(context, IssueData issueData) {
    selctedIssueId = issueData;
    notifyListeners();
    // Navigate
    Navigator.push(
            context, MaterialPageRoute(builder: (context) => IssuesDetails()))
        .then((value) {
      if (value == true) {
        getData(context);
        // Navigator.pop(context, true);
      }
    });
  }

  // Add data in create issue
  createIssueDataController(Map<String, dynamic> other) {
    createIssue.addAll(other);
    notifyListeners();
  }

// Delete Image
  deleteImage({required int index}) {
    finalImges.removeAt(index);
    notifyListeners();
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
        qrlocationTagData = LocationTagData.fromJson(apiResponse.response);

        FacilitiesProvider facilitiesProvider = FacilitiesProvider();

        issueType = qrlocationTagData.unit?.unitNo != null ? "Unit" : "";
        // await facilitiesProvider.getBlock(context,
        //     facilityId: qrlocationTagData.facilityId!);
        if (qrlocationTagData.facility != null) {
          facilitiesProvider.getBlock(context,
              facilityId: qrlocationTagData.facility!.id!);
        }
        if (qrlocationTagData.unit != null) {
          selectedClientName = await facilitiesProvider.getClient(context,
              unitId: qrlocationTagData.unit!.id.toString());
        }
        if (issueType == "Unit") {
          createIssue = {
            "facility_id": qrlocationTagData.facility?.id ?? "",
            "facility_block_id": qrlocationTagData.block?.id ?? "",
            "facility_unit_id": qrlocationTagData.unit?.id ?? "",
            "cream_unit": qrlocationTagData.unit?.creamUnit == "Yes" ? 1 : 0,
            "client_id": facilitiesProvider.selectedClient.client?.id ?? "",
          };
        } else {
          createIssue = {
            "facility_id": qrlocationTagData.facility?.id ?? "",
            "facility_block_id": qrlocationTagData.block?.id ?? "",
            "facility_unit_id": "",
            "cream_unit": "0",
            "client_id": facilitiesProvider.selectedClient.client?.id ?? "",
            "location_tag_id": qrlocationTagData.id ?? "",
            "items[0][remarks]": qrlocationTagData.name ?? ""
          };
        }
        // await getAssets(context);

        qrData = true;
      }
    } catch (e) {
      print("error getting data");
      print(e.toString());
    } finally {
      loading = false;
      notifyListeners();
    }
  }

  // get assets ( ISSUE ITEM )
  Future getAssets(context, {String? facilityId}) async {
    try {
      loading = true;
      notifyListeners();
      ApiResponse apiResponse = await ApiCall.getApi(context,
          endpoint:
              "${ApiEndpoints.facilities}/${facilityId ?? createIssue['facility_id']}/${ApiEndpoints.assets}?all=1");
      if (apiResponse.statusCode == 200) {
        itemAssetsResponse = ItemAssetsResponse();
        log(jsonEncode(apiResponse.response));
        itemAssetsResponse = ItemAssetsResponse.fromJson(apiResponse.response);
        notifyListeners();
      }
    } catch (e) {
      print("error");
      print(e.toString());
    } finally {
      loading = false;
      notifyListeners();
    }
  }

  // Create Api Request
  Future createIssueApiRequest(context) async {
    loading = true;
    notifyListeners();
    createIssue.addAll({
      "issue_raised_by": "Dorm Ops",
      "items[0][done_by]": "dormetry",
      "location_tag_id": ""
    });
    log("--DATA--");
    log(jsonEncode(createIssue));
    ApiResponse apiResponse = await ApiCall.postApi(context,
        endpoint: ApiEndpoints.issues,
        body: createIssue,
        file: finalImges,
        fileParameter: "items[0][photos][]");

    if (apiResponse.statusCode == 201 || apiResponse.statusCode == 200) {
      Fluttertoast.showToast(
        fontSize: 15.r,
        textColor: NewColors.whitecolor,
        msg: "Issue created successfully",
        backgroundColor: NewColors.greencolor,
      );
      createIssue.clear();
      await Provider.of<HomeProvider>(
        context,
        listen: false,
      ).getData(context);
      Navigator.pop(context, true);
    }

    loading = false;
    notifyListeners();
  }

// create edit issue item
  Future createIssueItem(
      context, Map<String, dynamic> body, String issueId, int index) async {
    try {
      loading = true;
      notifyListeners();
      body.addAll({
        "issue_raised_by": "Dorm Ops",
        "items[$index][done_by]": "dormetry",
        "items[$index][remarks]": "test",
        "items[$index][charge]": "0",
        "location_tag_id": ""
      });
      ApiResponse apiResponse = await ApiCall.postApi(context,
          endpoint: "${ApiEndpoints.issues}/$issueId",
          body: body,
          file: finalImges,
          fileParameter: "items[$index][photos][]");
      if (apiResponse.statusCode == 200 || apiResponse.statusCode == 201) {
        log(apiResponse.response.toString());
        Fluttertoast.showToast(
          msg: apiResponse.response['message'],
          fontSize: 15.r,
          textColor: NewColors.whitecolor,
          backgroundColor: NewColors.greencolor,
        );
        Navigator.pop(context, true);
      }
    } catch (e) {
      log("Error is adding Issue");
      log(e.toString());
    } finally {
      loading = false;
      notifyListeners();
    }
  }

  // get issue deatils
  Future getIssueDetail(context, {required String issueId}) async {
    try {
      loading = true;
      notifyListeners();
      ApiResponse apiResponse = await ApiCall.getApi(context,
          endpoint: ApiEndpoints.issues + "/$issueId");
      if (apiResponse.statusCode == 200) {
        issueDetails = IssueDetails.fromJson(apiResponse.response);
      }
    } catch (e) {
      log("Error in Geting Issue data");
      log(e.toString());
    } finally {
      loading = false;
      notifyListeners();
    }
  }

  // Delete issue
  Future deleteIssue(context, {required int? issueId}) async {
    try {
      loading = true;
      notifyListeners();
      ApiResponse apiResponse = await ApiCall.deleteApi(context,
          endpoint: "${ApiEndpoints.issues}/$issueId");
      log(apiResponse.response.toString());
      if (apiResponse.statusCode == 200) {
        if (apiResponse.response['success'] == true) {
          Fluttertoast.showToast(
              textColor: NewColors.whitecolor,
              backgroundColor: NewColors.greencolor,
              fontSize: 15.r,
              msg: apiResponse.response['message']);
          getData(context);
          if (status == "Urgent") {
            urgentIssueCount -= 1;
          } else {
            noturgentIssueCount -= 1;
          }
          Navigator.pop(context);
        }
      }
    } catch (e) {
      log("Error in deleting Issue");
      log(e.toString());
    } finally {
      loading = false;
      notifyListeners();
    }
  }

// Delete Issue Item Photo
  Future deleteIssueItemPhoto(context, {required String id}) async {
    try {
      loading = true;
      notifyListeners();
      ApiResponse apiResponse = await ApiCall.deleteApi(context,
          endpoint: "${ApiEndpoints.issuePhotos}/$id");
      if (apiResponse.statusCode == 200) {
        log(apiResponse.response.toString());
        selctedIssueId?.photos?.removeWhere((data) => data.id.toString() == id);
        Fluttertoast.showToast(
            backgroundColor: NewColors.whitecolor,
            textColor: NewColors.black,
            fontSize: 15.r,
            msg: apiResponse.response['message']);
      }
    } catch (e) {
      log("Error deleting issue item image");
      log(e.toString());
    } finally {
      loading = false;
      notifyListeners();
    }
  }

  // clear and reset all creating data
  clearCreateData() {
    createIssue = {};
    qrData = false;
    qrlocationTagData = LocationTagData();
    selectedClientName = "";
    itemCount = 0;
    itemAssetsResponse = ItemAssetsResponse();
    notifyListeners();
  }

  // change qr data
  changeQrStatus(status) {
    try {
      qrData = status;
      notifyListeners();
    } catch (e) {
      log(e.toString());
    }
  }

// Delete issue item
  Future deleteIssueItem(context,
      {required String issueId, required itemId}) async {
    try {
      loading = true;
      notifyListeners();
      ApiResponse apiResponse = await ApiCall.deleteApi(context,
          endpoint:
              "${ApiEndpoints.issues}/$issueId/${ApiEndpoints.items}/$itemId");
      if (apiResponse.statusCode == 200) {
        log(apiResponse.response.toString());
        if (apiResponse.response['success'] == true) {
          selctedIssueId?.items
              ?.removeWhere((data) => data.id.toString() == itemId);
          Fluttertoast.showToast(
              backgroundColor: NewColors.greencolor,
              fontSize: 15.r,
              textColor: NewColors.whitecolor,
              msg: apiResponse.response['message']);
          Navigator.pop(context);
        }
      }
    } catch (e) {
      log("Errror in Deleting issue item");
      log(e.toString());
    } finally {
      loading = false;
      notifyListeners();
    }
  }

//  add image
  Future addItemImage(context,
      {required Uint8List byteList, required int index}) async {
    try {
      loading = false;
      notifyListeners();
      File file = await uint8ListToFile(byteList, "issue${DateTime.now()}");
      final IssueItem issueItem = selctedIssueId!.items![index];

      ApiResponse apiResponse = await ApiCall.postApi(context,
          endpoint: "${ApiEndpoints.issues}/${selctedIssueId!.id}",
          body: {
            "items[$index][id]": issueItem.id,
            "items[$index][item]": issueItem.item,
            "items[$index][area_id]": issueItem.areaId,
            "items[$index][issue_type][]": issueItem.issueType,
            "items[$index][quantity]": issueItem.quantity,
            "items[$index][charge]": issueItem.charge,
            "items[$index][remarks]": issueItem.remarks,
            "items[$index][done_by]": issueItem.doneBy,
          },
          file: [XFile(file.path)],
          fileParameter: "items[$index][photos][]");
      if (apiResponse.statusCode == 200) {
        log(apiResponse.response.toString());
        selctedIssueId!.photos!.clear();
        for (var i = 0;
            i < apiResponse.response['data']['photos'].length;
            i++) {
          selctedIssueId!.photos!
              .add(Photos.fromJson(apiResponse.response['data']['photos'][i]));
        }
        Fluttertoast.showToast(
          msg: apiResponse.response['message'],
          fontSize: 15.r,
          textColor: NewColors.whitecolor,
          backgroundColor: NewColors.greencolor,
        );
        Navigator.pop(context, true);
      }
    } catch (e) {
      log("Error in adding item image");
      log(e.toString());
    } finally {
      loading = false;
      notifyListeners();
    }
  }

  // edit issue
  Future editIssue(context,
      {required String issueId, required Map<String, dynamic>? body}) async {
    try {
      loading = true;
      notifyListeners();
      log("edit data");
      log(body.toString());
      ApiResponse apiResponse = await ApiCall.postApi(context,
          endpoint: "${ApiEndpoints.issues}/$issueId", body: body);
      if (apiResponse.statusCode == 200) {
        log(apiResponse.response.toString());
        int tempIndex = selctedIssueId!.items!
            .indexWhere((data) => data.issueId.toString() == issueId);
        if (tempIndex != -1) {
          selctedIssueId!.items![tempIndex].item =
              body?["items${[tempIndex]}[item]"].toString();
          selctedIssueId!.items![tempIndex].issueType =
              body?["items${[tempIndex]}[issue_type][]"].toString();
          selctedIssueId!.items![tempIndex].areaId =
              int.parse(body?["items${[tempIndex]}[area_id]"].toString() ?? "");

          selctedIssueId!.items![tempIndex].quantity = int.parse(
              body?["items${[tempIndex]}[quantity]"].toString() ?? "");
          selctedIssueId!.items![tempIndex].charge =
              body?["items${[tempIndex]}[charge]"].toString();
          Fluttertoast.showToast(
              backgroundColor: NewColors.greencolor,
              textColor: NewColors.whitecolor,
              fontSize: 15.r,
              msg: apiResponse.response['message']);
          Navigator.pop(context);
        } else {
          print(tempIndex);
        }
      }
    } catch (e) {
      log("Error in Editing Issue");
      log(e.toString());
    } finally {
      loading = false;
      notifyListeners();
    }
  }
}
