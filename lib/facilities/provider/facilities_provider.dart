import 'dart:convert';
import 'dart:developer';

import 'package:fixlah/config/colors.dart';
import 'package:fixlah/config/constants.dart';
import 'package:fixlah/facilities/model/block_list_model.dart';
import 'package:fixlah/facilities/model/client_data_model.dart';
import 'package:fixlah/facilities/model/facilities_model.dart'
    show FacilityList;
import 'package:fixlah/facilities/model/location_tag_model.dart';
import 'package:fixlah/facilities/model/unit_data_model.dart';

import 'package:fixlah/network/api_call.dart';
import 'package:fixlah/network/api_endpoints.dart';
import 'package:fixlah/network/response_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';

class FacilitiesProvider extends ChangeNotifier {
  bool loading = false;
  FacilityList facilityList = FacilityList();
  int totalFacilities = 0;
  List<BlockResponse> blockResponse = [];
  List<UnitData> unitList = [];
  ClientData selectedClient = ClientData();

  List selectedFacilitiesName = [];
  List<String> facilitiesImages = [
    "assets/facilities/fac_1.png",
    "assets/facilities/fac_2.png",
    "assets/facilities/fac_3.png",
    "assets/facilities/fac_4.png",
    "assets/facilities/fac_5.png",
  ];
// Location Tag data list
  List<LocationTagData> locationtaglist = [];
  Future getAllFacilities(context) async {
    // ignore: prefer_is_empty
    if (facilityList.data?.data?.length == 0 || facilityList.data == null) {
      print("object");
      loading = true;
      notifyListeners();
      ApiResponse apiResponse =
          await ApiCall.getApi(context, endpoint: ApiEndpoints.facilities);
      if (apiResponse.statusCode == 200) {
        facilityList = FacilityList.fromJson(apiResponse.response!);
        totalFacilities = facilityList.data!.total ?? 0;
        if (selectedFacilities.isEmpty) {
          for (var i = 0; i < totalFacilities; i++) {
            selectedFacilities.add(facilityList.data!.data![i].id);
            selectedFacilitiesName.add(facilityList.data!.data![i].name);
          }
        }
        loading = false;
        notifyListeners();
      }
    }
  }

  resetFacilityData() {
    selectedClient = ClientData();
    blockResponse = [];
    unitList = [];
    notifyListeners();
  }

  onFacilitiChange(context, {required int? value, required String? name}) {
    if (selectedFacilities.contains(value)) {
      if (selectedFacilities.length != 1) {
        selectedFacilities.remove(value);
        selectedFacilitiesName.remove(name);
        notifyListeners();
      }
    } else {
      selectedFacilities.add(value);
      selectedFacilitiesName.add(name);
      notifyListeners();
    }
  }

  // get block based on facility
  Future getBlock(context, {required int facilityId}) async {
    try {
      loading = true;
      notifyListeners();

      ApiResponse apiResponse = await ApiCall.getApi(context,
          endpoint:
              "${ApiEndpoints.facilities}/$facilityId/${ApiEndpoints.blocks}");
      if (apiResponse.statusCode == 200) {
        blockResponse.clear();
        log(apiResponse.response.toString());
        for (var i = 0; i < apiResponse.response.length; i++) {
          blockResponse.add(BlockResponse.fromJson(apiResponse.response![i]));
        }
      }
    } catch (e) {
      print("Error");
      print(e.toString());
    } finally {
      loading = false;
      notifyListeners();
    }
  }

// get location tag
  Future getLocationTag(context) async {
    try {
      loading = true;
      notifyListeners();
      ApiResponse apiResponse = await ApiCall.getApi(context,
          endpoint: "${ApiEndpoints.locationtags}?all=1");
      if (apiResponse.statusCode == 200) {
        for (var i = 0; i < apiResponse.response; i++) {
          locationtaglist
              .add(LocationTagData.fromJson(apiResponse.response[i]));
          notifyListeners();
        }
      }
    } catch (e) {
      print(e.toString());
    } finally {
      loading = false;
      notifyListeners();
    }
  }

  // get unit based on facility and block
  Future getUnit(context,
      {required String facilityId,
      required String blockId,
      required List<Floors> floors}) async {
    try {
      loading = true;
      unitList.clear();
      notifyListeners();
      for (var i = 0; i < floors.length; i++) {
        ApiResponse apiResponse = await ApiCall.getApi(context,
            endpoint:
                "${ApiEndpoints.facilities}/$facilityId/${ApiEndpoints.blocks}/$blockId/floors/${floors[i].id}/${ApiEndpoints.units}");
        print(apiResponse.response.toString());
        if (apiResponse.statusCode == 200) {
          // log(jsonEncode(apiResponse.response[0]));
          for (var j = 0; j < apiResponse.response.length; j++) {
            unitList.add(UnitData.fromJson(apiResponse.response[j]));
            notifyListeners();
          }
        }
      }
    } catch (e) {
      print("Error");
      print(e.toString());
    } finally {
      loading = false;
      notifyListeners();
    }
  }

  // get Client details based on id
  Future<String> getClient(context, {required String unitId}) async {
    try {
      loading = true;
      selectedClient = ClientData();
      notifyListeners();
      ApiResponse apiResponse = await ApiCall.getApi(context,
          endpoint:
              "${ApiEndpoints.facilityClient}/$unitId/${ApiEndpoints.client}");
      if (apiResponse.statusCode == 200) {
        if (apiResponse.response['success'] == true) {
          selectedClient = ClientData.fromJson(apiResponse.response);
          log("Client Name : ${selectedClient.client?.name}");
          log("Client id : ${selectedClient.client?.id}");
          notifyListeners();
        } else {
          Fluttertoast.showToast(
            msg: apiResponse.response['message'],
            fontSize: 15.r,
            textColor: NewColors.whitecolor,
            backgroundColor: NewColors.red,
          );
        }

        return selectedClient.client?.name ?? "";
      }
    } catch (e) {
      print("Error");
      print(e.toString());
      return selectedClient.client?.name ?? "";
    } finally {
      log("Error in getting Client");
      loading = false;
      notifyListeners();
      return selectedClient.client?.name ?? "";
    }
  }
}
