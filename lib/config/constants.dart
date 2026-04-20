import 'package:fixlah/home/model/area_response_model.dart';
import 'package:fixlah/home/model/issue_categories_data.dart';
import 'package:fixlah/home/model/issue_type_data.dart';
import 'package:flutter/material.dart';
import 'package:flutter_device_type/flutter_device_type.dart';

class AppConstants {
  // Staging Url
  // static String baseUrl = "https://staging.fixlah.com.sg/api/";
  // static String assetBaseUrl =
  //     "https://fixlah-inspection-test-bucket.s3.ap-southeast-1.amazonaws.com";

  // Production Url
  static String baseUrl = "https://fixlah.com.sg/api/";
  static String assetBaseUrl =
      "https://fixlah-inspection-prod-bucket.s3.ap-southeast-1.amazonaws.com";
  static String issuesImageBaseUrl = "$assetBaseUrl/uploads/issue_photos/";
  static String woImageBaseUrl = "$assetBaseUrl/uploads/workorder_photos/";
}

// Shared Preference Variables Key

class SharedPreferencesKey {
  static String accessToken = "accessToken";
  static String userPermissions = "userPermissions";
}

// Global Variable
String appName = "Fixlah";
GlobalKey<NavigatorState>? appNavigator;

AreaListResponse? areaListResponse;
List<IssueCategorieData> issueCategoriesDataResponse = [];
List<IssueTypeData> issueTypeDataList = [];
List<DropdownMenuItem<IssueTypeData>> issueTypeDataDropDownlistList = [];
// Access Token
String accessToken = "";
// Permissions
List<String> permissions = [];
List selectedFacilities = [];
String approvedFacilities = "";

// Issues Status/Filter options
List issuesStatus = [
  "Urgent",
  "Not Urgent",
];

// check for permission
bool checkPermission({required String permit}) {
  if (permissions.contains(permit)) {
    return true;
  } else {
    // Fluttertoast.showToast(
    //   msg: "Sorry You Can Not ${permit.toUpperCase()}",
    //   textColor: NewColors.whitecolor,
    //   backgroundColor: NewColors.red,
    //   fontSize: 15.r,
    // );
    return false;
  }
}

// close Keyborad
closekeyboard() {
  FocusManager.instance.primaryFocus?.unfocus();
}

class DeviceUtils {
  static bool isTablet() {
    return Device.get().isTablet;
  }

  static bool isMobile() {
    return !Device.get().isTablet;
  }
}
