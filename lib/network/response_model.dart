class ApiResponse {
  int? statusCode;
  dynamic response;

  ApiResponse({this.statusCode, this.response});

  ApiResponse.fromJson(Map<String, dynamic> json) {
    statusCode = json['statusCode'];
    response = json['response'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['statusCode'] = statusCode;
    if (response != null) {
      data['response'] = response;
    }
    return data;
  }
}
