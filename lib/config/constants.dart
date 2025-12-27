import 'package:fixlah/home/model/area_response_model.dart';
import 'package:fixlah/home/model/issue_categories_data.dart';
import 'package:fixlah/home/model/issue_type_data.dart';
import 'package:flutter/material.dart';
import 'package:flutter_device_type/flutter_device_type.dart';

class AppConstants {
  static String appName = "Fixlah";
  static String baseUrl = "https://fixlah.myila.in/api/";
  static String issuesImageBaseUrl =
      "https://fixlah.myila.in/uploads/issue_photos/";
  static String woImageBaseUrl =
      "https://fixlah.myila.in/uploads/workorder_photos/";
}

// Shared Preference Variables Key

class SharedPreferencesKey {
  static String accessToken = "accessToken";
  static String userPermissions = "userPermissions";
}

// Global Variable
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
