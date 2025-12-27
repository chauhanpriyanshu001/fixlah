import 'dart:convert';

import 'package:fixlah/auth/screen/login.dart';
import 'package:fixlah/config/colors.dart';
import 'package:fixlah/config/constants.dart';
import 'package:fixlah/config/utils.dart';
import 'package:fixlah/network/response_model.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';

class ApiCall {
  // Post Api Call
  static Future<ApiResponse> postApi(context,
      {required String endpoint,
      Map<String, dynamic>? body,
      List<XFile>? file,
      String? fileParameter}) async {
    var request = http.MultipartRequest(
        "POST", Uri.parse(AppConstants.baseUrl + endpoint));
    Map<String, dynamic>? rawMap = body;
    request.fields.addAll(rawMap!.map(
      (key, value) => MapEntry(key, value.toString()),
    ));
    print(request.url);
    if (file != null) {
      for (var i = 0; i < file.length; i++) {
        request.files.add(
            await http.MultipartFile.fromPath(fileParameter!, file[i].path));
      }
    }
    request.headers.addAll({
      "Authorization": "Bearer $accessToken",
      "X-Client-Platform": "android_app",
    });
    http.StreamedResponse response = await request.send();
    String data = await response.stream.bytesToString();
    print(data);
    print(response.statusCode);
    ApiResponse apiResponse =
        handleResponse(context, response.statusCode, data);
    return apiResponse;
  }

  // Get Api Call
  static Future<ApiResponse> getApi(context,
      {required String endpoint, Object? body}) async {
    var request = await http.get(
      Uri.parse(
        AppConstants.baseUrl + endpoint,
      ),
      headers: {
        "Authorization": "Bearer $accessToken",
        "X-Client-Platform": "android_app",
        "Content-Type": "multipart/form-data"
      },
    );
    print(request.request);
    print(request.statusCode);
    print(request.body);

    return handleResponse(context, request.statusCode, request.body);
  }

// Delete Api Call
  static Future<ApiResponse> deleteApi(context,
      {required String endpoint, Object? body}) async {
    var request = await http.delete(
      Uri.parse(
        AppConstants.baseUrl + endpoint,
      ),
      headers: {
        "Authorization": "Bearer $accessToken",
        "X-Client-Platform": "android_app",
        "Content-Type": "multipart/form-data"
      },
    );
    print(request.request);

    return handleResponse(context, request.statusCode, request.body);
  }

// Put Api call

  static Future<ApiResponse> putApi(context,
      {required String endpoint,
      Map<String, dynamic>? body,
      List<XFile>? file,
      String? fileParameter}) async {
    var request = http.MultipartRequest(
        "PUT", Uri.parse(AppConstants.baseUrl + endpoint));
    Map<String, dynamic>? rawMap = body;
    request.fields.addAll(rawMap!.map(
      (key, value) => MapEntry(key, value.toString()),
    ));
    print(request.fields);
    print(request.url);

    if (file != null) {
      for (var i = 0; i < file.length; i++) {
        request.files.add(
            await http.MultipartFile.fromPath(fileParameter!, file[i].path));
      }
    }
    request.headers.addAll({
      'Accept': 'application/json',
      "Authorization": "Bearer $accessToken",
      "X-Client-Platform": "android_app",
      'Content-Type': 'multipart/form-data',
    });
    http.StreamedResponse response = await request.send();
    print(response.statusCode);
    print(response.reasonPhrase);
    String data = await response.stream.bytesToString();
    // log(data);
    ApiResponse apiResponse =
        handleResponse(context, response.statusCode, data);
    return apiResponse;
  }
}

ApiResponse handleResponse(context, int? statusCode, response) {
  ApiResponse apiResponse = ApiResponse(statusCode: statusCode, response: {});
  try {
    if (statusCode == 401) {
      Map errorResponse = jsonDecode(response);

      Fluttertoast.showToast(
          fontSize: 15.r,
          msg: errorResponse['message'],
          textColor: NewColors.whitecolor,
          backgroundColor: NewColors.red);
      // naviagteToandreplace(context, builder: (context) => const LoginScreen());
    } else if (statusCode == 400 || statusCode == 409 || statusCode == 406) {
      Map errorResponse = jsonDecode(response);
      if (errorResponse['message']
          .toString()
          .contains("Report can only be generated for completed inspections")) {
        Fluttertoast.showToast(
            fontSize: 15.r,
            textColor: NewColors.whitecolor,
            msg: errorResponse['message'],
            backgroundColor: NewColors.greencolor);
      } else {
        Fluttertoast.showToast(
            fontSize: 15.r,
            textColor: NewColors.whitecolor,
            msg: errorResponse['message'],
            backgroundColor: NewColors.red);
      }
    }
    // else if (statusCode == 201) {
    //     Fluttertoast.showToast(fontSize: 15.r,msg: response['message']);
    //   apiResponse = ApiResponse.fromJson({
    //     "statusCode": statusCode,
    //     "response": jsonDecode(response),
    //   });
    // }
    else if (statusCode == 403) {
      Fluttertoast.showToast(
          fontSize: 20.r,
          msg: response['message'],
          textColor: NewColors.whitecolor,
          backgroundColor: NewColors.red);
    } else if (statusCode == 500 ||
        response.toString().contains("<title>Login - FIX-LAH</title>")) {
      naviagteToandreplace(context, builder: (context) => const LoginScreen());
      Fluttertoast.showToast(
          textColor: NewColors.whitecolor,
          fontSize: 15.r,
          msg: "Please Login",
          backgroundColor: NewColors.red);
    } else {
      apiResponse = ApiResponse.fromJson({
        "statusCode": statusCode,
        "response": jsonDecode(response),
      });
    }
    return apiResponse;
  } catch (e) {
    print(e);
    //   Fluttertoast.showToast(fontSize: 15.r,msg: "Please Check Your Internet Connection");
    return ApiResponse();
  }
}
