class CheckAuthDataModel {
  bool? authenticated;
  User? user;
  String? token;

  CheckAuthDataModel({this.authenticated, this.user, this.token});

  CheckAuthDataModel.fromJson(Map<String, dynamic> json) {
    authenticated = json['authenticated'];
    user = json['user'] != null ? new User.fromJson(json['user']) : null;
    token = json['token'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['authenticated'] = this.authenticated;
    if (this.user != null) {
      data['user'] = this.user!.toJson();
    }
    data['token'] = this.token;
    return data;
  }
}

class User {
  int? id;
  String? referenceUuid;
  String? username;
  String? name;
  String? employeeNo;
  String? joiningDate;
  String? mobile;
  String? email;
  String? designation;
  int? supervisorId;
  int? roleId;
  String? vocationType;
  String? facilityIds;
  String? employmentType;
  String? status;
  dynamic createdBy;
  dynamic updatedBy;
  dynamic emailVerifiedAt;
  dynamic faceReferenceId;
  String? createdAt;
  String? updatedAt;

  User(
      {this.id,
      this.referenceUuid,
      this.username,
      this.name,
      this.employeeNo,
      this.joiningDate,
      this.mobile,
      this.email,
      this.designation,
      this.supervisorId,
      this.roleId,
      this.vocationType,
      this.facilityIds,
      this.employmentType,
      this.status,
      this.createdBy,
      this.updatedBy,
      this.emailVerifiedAt,
      this.faceReferenceId,
      this.createdAt,
      this.updatedAt});

  User.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    referenceUuid = json['reference_uuid'];
    username = json['username'];
    name = json['name'];
    employeeNo = json['employee_no'];
    joiningDate = json['joining_date'];
    mobile = json['mobile'];
    email = json['email'];
    designation = json['designation'];
    supervisorId = json['supervisor_id'];
    roleId = json['role_id'];
    vocationType = json['vocation_type'];
    facilityIds = json['facility_ids'];
    employmentType = json['employment_type'];
    status = json['status'];
    createdBy = json['created_by'];
    updatedBy = json['updated_by'];
    emailVerifiedAt = json['email_verified_at'];
    faceReferenceId = json['face_reference_id'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['reference_uuid'] = this.referenceUuid;
    data['username'] = this.username;
    data['name'] = this.name;
    data['employee_no'] = this.employeeNo;
    data['joining_date'] = this.joiningDate;
    data['mobile'] = this.mobile;
    data['email'] = this.email;
    data['designation'] = this.designation;
    data['supervisor_id'] = this.supervisorId;
    data['role_id'] = this.roleId;
    data['vocation_type'] = this.vocationType;
    data['facility_ids'] = this.facilityIds;
    data['employment_type'] = this.employmentType;
    data['status'] = this.status;
    data['created_by'] = this.createdBy;
    data['updated_by'] = this.updatedBy;
    data['email_verified_at'] = this.emailVerifiedAt;
    data['face_reference_id'] = this.faceReferenceId;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}
