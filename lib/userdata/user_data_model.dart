class UserData {
  int? id;
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
  String? createdAt;
  String? updatedAt;

  UserData(
      {this.id,
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
      this.createdAt,
      this.updatedAt});

  UserData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
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
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['username'] = username;
    data['name'] = name;
    data['employee_no'] = employeeNo;
    data['joining_date'] = joiningDate;
    data['mobile'] = mobile;
    data['email'] = email;
    data['designation'] = designation;
    data['supervisor_id'] = supervisorId;
    data['role_id'] = roleId;
    data['vocation_type'] = vocationType;
    data['facility_ids'] = facilityIds;
    data['employment_type'] = employmentType;
    data['status'] = status;
    data['created_by'] = createdBy;
    data['updated_by'] = updatedBy;
    data['email_verified_at'] = emailVerifiedAt;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    return data;
  }
}
