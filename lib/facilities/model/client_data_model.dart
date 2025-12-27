class ClientData {
  bool? success;
  Client? client;

  ClientData({this.success, this.client});

  ClientData.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    client =
        json['client'] != null ? new Client.fromJson(json['client']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['success'] = this.success;
    if (this.client != null) {
      data['client'] = this.client!.toJson();
    }
    return data;
  }
}

class Client {
  int? id;
  String? name;
  String? onefmClientInternalId;
  String? companyName;
  String? email;
  String? netsuiteClientId;
  String? phone;
  String? mobile;
  String? address;
  String? mailingAddress;
  String? operationPersonName;
  String? operationPhone;
  String? operationMobile;
  String? operationEmail;
  String? accountPersonName;
  String? accountPhone;
  String? accountMobile;
  String? accountEmail;
  String? directorPersonName;
  String? directorPhone;
  String? directorMobile;
  String? directorEmail;
  int? status;
  int? createdBy;
  int? updatedBy;
  dynamic createdAt;
  dynamic updatedAt;

  Client(
      {this.id,
      this.name,
      this.onefmClientInternalId,
      this.companyName,
      this.email,
      this.netsuiteClientId,
      this.phone,
      this.mobile,
      this.address,
      this.mailingAddress,
      this.operationPersonName,
      this.operationPhone,
      this.operationMobile,
      this.operationEmail,
      this.accountPersonName,
      this.accountPhone,
      this.accountMobile,
      this.accountEmail,
      this.directorPersonName,
      this.directorPhone,
      this.directorMobile,
      this.directorEmail,
      this.status,
      this.createdBy,
      this.updatedBy,
      this.createdAt,
      this.updatedAt});

  Client.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    onefmClientInternalId = json['onefm_client_internal_id'];
    companyName = json['company_name'];
    email = json['email'];
    netsuiteClientId = json['netsuite_client_id'];
    phone = json['phone'];
    mobile = json['mobile'];
    address = json['address'];
    mailingAddress = json['mailing_address'];
    operationPersonName = json['operation_person_name'];
    operationPhone = json['operation_phone'];
    operationMobile = json['operation_mobile'];
    operationEmail = json['operation_email'];
    accountPersonName = json['account_person_name'];
    accountPhone = json['account_phone'];
    accountMobile = json['account_mobile'];
    accountEmail = json['account_email'];
    directorPersonName = json['director_person_name'];
    directorPhone = json['director_phone'];
    directorMobile = json['director_mobile'];
    directorEmail = json['director_email'];
    status = json['status'];
    createdBy = json['created_by'];
    updatedBy = json['updated_by'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['onefm_client_internal_id'] = this.onefmClientInternalId;
    data['company_name'] = this.companyName;
    data['email'] = this.email;
    data['netsuite_client_id'] = this.netsuiteClientId;
    data['phone'] = this.phone;
    data['mobile'] = this.mobile;
    data['address'] = this.address;
    data['mailing_address'] = this.mailingAddress;
    data['operation_person_name'] = this.operationPersonName;
    data['operation_phone'] = this.operationPhone;
    data['operation_mobile'] = this.operationMobile;
    data['operation_email'] = this.operationEmail;
    data['account_person_name'] = this.accountPersonName;
    data['account_phone'] = this.accountPhone;
    data['account_mobile'] = this.accountMobile;
    data['account_email'] = this.accountEmail;
    data['director_person_name'] = this.directorPersonName;
    data['director_phone'] = this.directorPhone;
    data['director_mobile'] = this.directorMobile;
    data['director_email'] = this.directorEmail;
    data['status'] = this.status;
    data['created_by'] = this.createdBy;
    data['updated_by'] = this.updatedBy;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}
